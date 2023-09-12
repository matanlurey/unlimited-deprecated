/// Iterates through every card and makes sure it can be validly created.
library;

import 'package:test/test.dart';
import 'package:unlimited/cards.dart' as cards;
import 'package:unlimited/schema.dart';

void main() {
  test('CardSet.values can be created', () {
    expect(CardSet.values.toList, returnsNormally);
  });

  group(CardSet.sparkOfRebellion.fullName, () {
    test('can be created', () {
      expect(() => cards.sparkOfRebellion, returnsNormally);
    });
  });
}
