import 'dart:convert' show utf8;
import 'dart:io' as io;

import 'package:path/path.dart' as path;

/// Checks `https://swudb.com` to see if the database is up to date.
///
/// Prints a link to each card that is missing from the database.
///
/// ## Usage
///
/// ```shell
/// dart tool/swudb_check.dart <file.dart>
/// ```
///
/// For example:
///
/// ```shell
/// # Checks lib/src/cards/sor.dart.
/// dart tool/swudb_check.dart sor
/// ```
///
/// This tool is expected to be used _after_ `tool/format_cards.dart`.
void main(List<String> args) async {
  if (args.length != 1) {
    io.stdout.writeln('Usage: dart tool/swudb_check.dart <file.dart>');
    io.exit(1);
  }

  // Starting with page 1, download a list of cards.
  // i.e. https://swudb.com/search/set:SOR?display=checklist&pagenumber=1 to N.
  final cards = <int, _Card>{};

  // Create a URI.
  final abbreviation = args.single.toUpperCase();

  final base = Uri.https(
    'swudb.com',
    '/search/set:$abbreviation',
    {
      'display': 'checklist',
    },
  );

  // Keep downloading and parsing pages until the page number is redirected.
  final http = io.HttpClient();
  var page = 1;
  while (true) {
    final url = base.replace(queryParameters: {
      ...base.queryParameters,
      'pagenumber': '$page',
    });
    final request = await http.openUrl('GET', url);
    final response = await request.close();
    if (response.statusCode != 200) {
      io.stdout.writeln('Error: ${response.statusCode}');
      io.exit(1);
    }
    if (response.redirects.isNotEmpty) {
      break;
    }

    // Find every <a href="/Card/SOR/001">NAME</a>
    final body = await response.transform(utf8.decoder).join();
    for (final match in _link.allMatches(body)) {
      final orderInSet = int.parse(match.group(1)!);

      // Find the name by looking at the next line.
      final name = body
          .substring(
            match.end,
            body.indexOf('</a>', match.end),
          )
          .trim()
          .replaceAll('&#x27E1;', '[U]');

      cards[orderInSet] = _Card(orderInSet, name);
    }

    page++;
  }

  // Load the file as lines, and look for "// SOR XXX: TBD".
  final file = io.File(path.join('lib', 'src', 'cards', '$abbreviation.dart'));
  if (!file.existsSync()) {
    io.stdout.writeln('Not a valid ".dart" file: ${file.path}');
    io.exit(1);
  }

  final lines = file.readAsLinesSync();
  var missing = 0;
  for (final line in lines) {
    final match = _tbd.firstMatch(line);
    if (match != null) {
      final orderInSet = int.parse(match.group(1)!);
      if (cards.containsKey(orderInSet)) {
        missing++;
        io.stdout.writeln(
          'Missing: ${cards[orderInSet]!.name} '
          '(${orderInSet.toString().padLeft(3, '0')}):\n  '
          'https://swudb.com/Card/$abbreviation/${orderInSet.toString().padLeft(3, '0')}',
        );
      }
    }
  }

  http.close(force: true);

  if (missing > 0) {
    io.stderr.writeln();
    io.stderr.writeln('$missing missing cards found.');
    io.exit(1);
  }
}

final _link = RegExp(r'<a href="/Card/\w+/(\d{3})">');
final _tbd = RegExp(r'\s+// \w+ (\d{3}): TBD');

final class _Card {
  /// The order of the card in the set.
  final int orderInSet;

  /// The name of the card.
  final String name;

  const _Card(this.orderInSet, this.name);
}
