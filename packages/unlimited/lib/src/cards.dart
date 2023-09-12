/// Contains an inlined database of all cards.
library;

import 'package:meta/meta.dart';
import 'package:unlimited/schema.dart';
import 'package:unlimited/src/cards/sor.dart';
import 'package:unlimited/src/state.dart';

export 'cards/sor.dart' show sparkOfRebellion;

/// A collection of [cards] that belongs to a specific [CardSet].
///
/// This class is intended to be used to represent all of the cards that belong
/// to a specific [CardSet], e.g. [sparkOfRebellion]. This is to split the
/// definition of [CardSet] from the cards themselves.
///
/// For a data structure to represent a collection of cards that may span
/// multiple [CardSet]s, see [Collection], or for a specific deck, [Deck].
///
/// ## Equality
///
/// Two [CardSetInventory]s are equal if they reference the same [cardSet];
/// the specific cards in the collection are not considered. For a deep
/// comparison, see [Collection.fromCardSets].
@immutable
final class CardSetInventory {
  /// The cards in this collection.
  final Set<Card> cards;

  /// The card set that every card in [cards] belongs to.
  final CardSet cardSet;

  /// Creates a new [CardSetInventory] for the given [cardSet] with [cards].
  ///
  /// While [cards] does not need to be _all_ the cards in [cardSet] (i.e. due
  /// to partial releases), every card in [cards] must belong to [cardSet] or an
  /// error will be thrown.
  factory CardSetInventory(CardSet cardSet, Set<Card> cards) {
    for (final card in cards) {
      if (card.cardSet != cardSet) {
        throw ArgumentError.value(
          card,
          'cards',
          '$card ({$card.set}) does not belong to $cardSet',
        );
      }
    }
    return CardSetInventory._(
      cardSet,
      cards,
    );
  }

  CardSetInventory._(
    this.cardSet,
    Set<Card> cards,
  ) : cards = Set.unmodifiable(cards);

  /// Looks up a card in this collection by its [orderInSet].
  ///
  /// If the card is not found, throws a [StateError].
  ///
  /// **NOTE**: This method is _not_ highly optimized.
  Card find(int orderInSet) {
    final result = tryFind(orderInSet);
    if (result != null) {
      return result;
    }
    throw StateError('Card not found: $orderInSet');
  }

  /// Looks up a card in this collection by its [orderInSet].
  ///
  /// If the card is not found, returns `null`.
  ///
  /// **NOTE**: This method is _not_ highly optimized.
  Card? tryFind(int orderInSet) {
    for (final card in cards) {
      if (card.orderInSet == orderInSet) {
        return card;
      }
    }
    return null;
  }

  // It's expected that there will not be multiple instances of the same card
  // collection referencing the same card set, so we can use the card set as the
  // hash code.
  @override
  int get hashCode => cardSet.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is! CardSetInventory) {
      return false;
    }
    return cardSet == other.cardSet;
  }
}
