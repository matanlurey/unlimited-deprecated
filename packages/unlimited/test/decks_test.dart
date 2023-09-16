/// Iterates through every deck and makes sure it can be validly created.
library;

import 'package:test/test.dart';
import 'package:unlimited/decks.dart' as decks;

void main() {
  test('lukeDeck', () {
    expect(() => decks.lukeDeck, returnsNormally);
  });

  test('vaderDeck', () {
    expect(() => decks.vaderDeck, returnsNormally);
  });
}
