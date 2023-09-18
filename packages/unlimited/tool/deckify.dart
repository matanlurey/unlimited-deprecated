import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:unlimited/cards.dart';
import 'package:unlimited/schema.dart';

/// A tool to generate a list of cards from a plain-text decklist.
///
/// ## Example
///
/// ```shell
/// # Create a decklist.
/// cat << EOF > decklist.txt
/// Luke Skywalker (x1)
/// Administrator's Tower (x1)
/// 2-1B Surgical Droid (x1)
/// R2-D2 (x3)
/// EOF
///
/// # Generate some Dart code.
/// dart tool/deckify.dart < decklist.txt > deck.dart
/// ```
void main(List<String> args) async {
  if (args.isNotEmpty) {
    stdout.writeln('Usage: dart tool/deckify.dart < decklist.txt > deck.dart');
    exit(1);
  }

  // For now, we'll assume all cards come from "Spark of Rebellion".
  final cardSet = sparkOfRebellion;

  // Read the decklist from stdin.
  final deckList = await stdin
      .transform(utf8.decoder)
      .transform(const LineSplitter())
      .map((line) => line.trim())
      .where((line) => line.isNotEmpty)
      .toList();

  // Parse the decklist.
  UnitCard? leader;
  BaseCard? base;
  final cards = <PlayableCard, int>{};

  Card? findCard(String name, {bool leader = false}) {
    return cardSet.cards.firstWhereOrNull((card) {
      if (card.name != name) {
        return false;
      }
      if (!leader) {
        return card is UnitCard;
      }
      return true;
    });
  }

  // Regular expression to parse a line in the decklist.
  final lineRegex = RegExp(r'^(.+?)\s+\(x(\d+)\)$');

  for (final line in deckList) {
    if (line.trim().isEmpty) {
      continue;
    }

    // Parse the line into a card name and quantity.
    // i.e. the format Name (x1)
    final match = lineRegex.firstMatch(line);
    if (match == null) {
      stderr.writeln('Invalid line: $line');
      exit(1);
    }

    // Find the card by name.
    final name = match.group(1)!;
    final quantity = int.parse(match.group(2)!);
    final card = findCard(name, leader: leader == null);

    if (card == null) {
      stderr.writeln('Unknown card: $name');
      exit(1);
    }

    if (leader == null) {
      if (card is! LeaderCard || quantity != 1) {
        stderr.writeln('Expected a leader card, but got: $card (x$quantity)');
        exit(1);
      }
      leader = card;
      continue;
    }

    if (base == null) {
      if (card is! BaseCard || quantity != 1) {
        stderr.writeln('Expected a base card, but got: $card (x$quantity)');
        exit(1);
      }
      base = card;
      continue;
    }

    if (card is! PlayableCard || quantity < 1) {
      stderr.writeln('Expected a playable card, but got: $card (x$quantity)');
      exit(1);
    }

    cards[card] = quantity;
  }

  String genFind(Card card, [int quantity = 1]) {
    // Convert "Spark of Rebellion" into "sparkOfRebellion".
    var name = card.cardSet.fullName
        .toLowerCase()
        .split(' ')
        .map((word) => word.substring(0, 1).toUpperCase() + word.substring(1))
        .join();
    name = name.substring(0, 1).toLowerCase() + name.substring(1);

    final String quoted;
    if (card.name.contains("'")) {
      quoted = '"${card.name}"';
    } else {
      quoted = "'${card.name}'";
    }

    final output = StringBuffer(
      '$name.find(${card.orderInSet}, '
      '$quoted)',
    );

    if (quantity == 1) {
      return output.toString();
    }

    // ignore: noop_primitive_operations
    return ''
        '...${output.toString().replaceAll('find', 'find<DeckCard>')}'
        '.duplicate($quantity)';
  }

  // Now on stdout, we'll generate some Dart code.
  // There is an expectation Dart format will be run on this code.
  // This is not a full Dart generator, but it's good enough for now.
  stdout.writeln('Deck(');
  stdout.writeln('  leader: ${genFind(leader!)},');
  stdout.writeln('  base: ${genFind(base!)},');
  stdout.writeln('  cards: [');
  for (final entry in cards.entries) {
    final card = entry.key;
    final quantity = entry.value;
    stdout.writeln('    ${genFind(card, quantity)},');
  }
  stdout.writeln('  ],');
  stdout.writeln(')');
  stdout.writeln();
}
