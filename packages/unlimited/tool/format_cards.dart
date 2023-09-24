import 'dart:io' as io;

import 'package:args/args.dart';
import 'package:path/path.dart' as path;

/// Formats and optionally fixes comments in a `.dart` file in `lib/src/cards`.
///
/// If `--fix` is not provided, but it would change the input file, exit code 1
/// is returned and `stdout` issues diagnostics. Otherwise, exit code 0 is
/// returned.
///
/// ## Usage
///
/// ```shell
/// dart tool/format_cards.dart <file.dart> [--fix]
/// ```
///
/// For example:
///
/// ```shell
/// # Formats lib/src/cards/sor.dart.
/// dart tool/format_cards.dart sor
/// ```
void main(List<String> args) {
  final results = _argParser.parse(args);
  if (results.rest.length != 1) {
    io.stdout.writeln('Usage: dart tool/format_cards.dart <file.dart>');
    io.stdout.writeln(_argParser.usage);
    io.exit(1);
  }

  final abbreviation = results.rest.single;
  final file = io.File(
    path.join(
      'lib',
      'src',
      'cards',
      '$abbreviation.dart',
    ),
  );
  if (!file.existsSync()) {
    io.stdout.writeln('Not a valid ".dart" file: ${file.path}');
    io.exit(1);
  }

  // Find the set.dart file.
  final setDefinitionsPath = results['set-definitions-path'] as String;
  final setDefinitionsFile = io.File(setDefinitionsPath);
  if (!setDefinitionsFile.existsSync()) {
    io.stdout.writeln('Not a valid ".dart" file: ${setDefinitionsFile.path}');
    io.exit(1);
  }

  // Verbose mode?
  final verbose = results['verbose'] as bool;

  // Load the file as lines.
  final lines = file.readAsLinesSync();

  // As a first pass, remove all comments that are "\s// +ABBR.*"
  // In reverse order, iterate through lines and remove.
  for (var i = lines.length - 1; i >= 0; i--) {
    final line = lines[i];
    if (line.trimLeft().startsWith('// ${abbreviation.toUpperCase()}')) {
      lines.removeAt(i);
    }
  }

  // Remove all empty lines.
  for (var i = lines.length - 1; i >= 0; i--) {
    final line = lines[i];
    if (line.trim().isEmpty) {
      lines.removeAt(i);
    }
  }

  // Determine how many cards are in the set.
  final belongsTo = RegExp(r'belongsTo: CardSet\.(\w*),');
  _SetInfo? setInfo;
  for (final line in lines) {
    if (belongsTo.hasMatch(line)) {
      final match = belongsTo.firstMatch(line)!;
      final name = match.group(1)!;
      setInfo = _SetInfo.parse(setDefinitionsFile, name);
      break;
    }
  }
  if (setInfo == null) {
    io.stdout.writeln('Could not determine set info for "$abbreviation".');
    io.exit(1);
  }

  // In verbose mode, print the set info.
  if (verbose) {
    io.stderr.writeln('Set info for "${abbreviation.toUpperCase()}":');
    io.stderr.writeln('  totalCards:  ${setInfo.totalCards}');
    io.stderr.writeln('  totalTokens: ${setInfo.totalTokens}');
  }

  // Starting at the back, add a comment i.e. "  // SOR 252".
  // If the card doesn't exist, suffix it with ": TBD", i.e. "// SOR 252: TBD".
  // Tokens are written "SOR T01", "SOR T02", etc, instead.
  for (var i = lines.length - 1; i >= 0; i--) {
    final line = lines[i];
    if (!line.contains('Card(')) {
      continue;
    }
    final card = _CardInfo.parse(lines, i);
    if (verbose) {
      io.stderr.writeln('Card parsed:');
      io.stderr.writeln('  lineStart:   ${card.lineStart}');
      io.stderr.writeln('  lineEnd:     ${card.lineEnd}');
      io.stderr.writeln('  orderInSet:  ${card.orderInSet}');
    }
  }
}

final class _SetInfo {
  final int totalCards;
  final int totalTokens;

  const _SetInfo(this.totalCards, this.totalTokens);

  factory _SetInfo.parse(io.File setDefinitions, String name) {
    // Find what line number contains "$name = CardSet(...)".
    final lines = setDefinitions.readAsLinesSync();
    final line = lines.indexWhere((line) => line.contains('$name = CardSet('));

    // Now, find the next occurance of totalCards and totalTokens.
    var totalCards = 0;
    var totalTokens = 0;
    for (var i = line; i < lines.length; i++) {
      final line = lines[i];
      if (_totalCards.hasMatch(line)) {
        final match = _totalCards.firstMatch(line)!;
        totalCards = int.parse(match.group(1)!);
      }
      if (_totalTokens.hasMatch(line)) {
        final match = _totalTokens.firstMatch(line)!;
        totalTokens = int.parse(match.group(1)!);
      }
    }

    return _SetInfo(totalCards, totalTokens);
  }

  static final _totalCards = RegExp(r'totalCards: (\d+),');
  static final _totalTokens = RegExp(r'totalTokens: (\d+),');
}

final class _CardInfo {
  final int lineStart;
  final int lineEnd;
  final int orderInSet;

  const _CardInfo(this.lineStart, this.lineEnd, this.orderInSet);

  factory _CardInfo.parse(List<String> lines, int startAt) {
    final lineStart = startAt;

    // Find the line that contains "orderInSet: 1," and parse it.
    int? orderInSet;
    for (var i = startAt; i < lines.length; i++) {
      final line = lines[i];
      if (_orderInSet.hasMatch(line)) {
        final match = _orderInSet.firstMatch(line)!;
        orderInSet = int.parse(match.group(1)!);
        break;
      }
    }
    if (orderInSet == null) {
      throw FormatException('Could not find "orderInSet".', lines[startAt]);
    }

    int? lineEnd;
    for (var i = startAt; i < lines.length; i++) {
      final line = lines[i];
      if (line.trim() == '),') {
        lineEnd = i;
        break;
      }
    }
    if (lineEnd == null) {
      throw FormatException('Could not find end of card.', lines[startAt]);
    }

    return _CardInfo(lineStart, lineEnd, orderInSet);
  }

  static final _orderInSet = RegExp(r'orderInSet: (\d+),');
}

final _argParser = ArgParser()
  ..addOption(
    'set-definitions-path',
    help: 'Path to the "set.dart" file.',
    valueHelp: '<path-to-set.dart>',
    defaultsTo: path.join('lib', 'src', 'schema', 'set.dart'),
  )
  ..addFlag(
    'verbose',
    negatable: false,
    help: 'Prints verbose diagnostics.',
  )
  ..addFlag(
    'fix',
    negatable: false,
    // ignore: noop_primitive_operations
    help: ''
        'Fixes the file if needed. If not set, but the file would be '
        'changed, exits with code 1 and prints diagnostics.',
  );
