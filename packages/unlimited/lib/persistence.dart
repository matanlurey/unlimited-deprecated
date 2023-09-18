/// Provides classes for persistence of game and deck state.
library;

import 'package:meta/meta.dart';
import 'package:unlimited/schema.dart';
import 'package:unlimited/src/internal.dart';
import 'package:unlimited/state.dart';

/// Indirectly refers to a card by its set and order in that set.
///
/// ## Example
///
/// ```dart
/// import 'package:unlimited/cards.dart';
///
/// final vader = CardReference(
///   CardSet.sparkOfRebellion,
///   10,
///   name: 'Darth Vader',
///   x: 1,
/// );
@immutable
final class CardReference {
  /// The set that this card belongs to.
  final CardSet cardSet;

  /// The order of this card in the set.
  final int orderInSet;

  /// The number of copies of this card.
  ///
  /// Must be greater than 0.
  final int quantity;

  /// Creates a new [CardReference] with the given [cardSet] and [orderInSet].
  ///
  /// {@macro errors_thrown_if_invalid}
  CardReference(
    this.cardSet,
    this.orderInSet, [
    this.quantity = 1,
  ]) {
    checkPositive(quantity, 'quantity');
  }

  @override
  int get hashCode => Object.hash(cardSet, orderInSet, quantity);

  @override
  bool operator ==(Object other) {
    return other is CardReference &&
        other.cardSet == cardSet &&
        other.orderInSet == orderInSet &&
        other.quantity == quantity;
  }

  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.write(cardSet.abbreviation);
    buffer.write(' #');
    buffer.write(orderInSet);
    if (quantity > 1) {
      buffer.write(' x$quantity');
    }
    return buffer.toString();
  }
}

/// Convenience extension methods that provides [Deck]-related decoding.
extension DeckDecoder on Collection {
  Card _decodeCard(CardReference card) {
    final decoded = tryFind(card.cardSet, card.orderInSet);
    if (decoded == null) {
      throw ArgumentError.value(
        card,
        'card',
        'Card not found in collection',
      );
    }
    return decoded;
  }

  /// Decodes card references into a deck.
  ///
  /// The first card reference must be a leader, the second must be a base, and
  /// the rest must be cards. A valid [Deck] must be returned, or an error will
  /// be thrown.
  Deck decodeDeck(Iterable<CardReference> references) {
    final refs = references.toList();
    final cards = refs.map(_decodeCard).toList();

    final leader = cards.removeAt(0);
    if (leader is! LeaderCard) {
      throw ArgumentError.value(
        leader,
        'leader',
        'First card must be a leader',
      );
    }
    final base = cards.removeAt(0);
    if (base is! BaseCard) {
      throw ArgumentError.value(
        base,
        'base',
        'Second card must be a base',
      );
    }

    return Deck(
      leader: leader,
      base: base,
      cards: [
        for (var i = 0; i < cards.length; i++)
          for (var j = 0; j < refs[i + 2].quantity; j++)
            cards[i] as PlayableCard,
      ],
    );
  }
}
