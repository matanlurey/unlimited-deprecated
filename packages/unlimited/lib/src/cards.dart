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
    // TODO: Add check to make sure no duplicate orderInSet.
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
  /// If the card is found, but is not of type [T], throws a [StateError]. For
  /// example, if you call `tryFind<UnitCard>(1)` on a collection that contains
  /// a [BaseCard] at order `1`, an error will be thrown.
  ///
  /// If [debugAssertName] is provided, in debug mode (assertions enabled) the
  /// card's name will be checked against it, exactly as written. This is useful
  /// for debugging, but should not be relied upon.
  ///
  /// **NOTE**: This method is _not_ highly optimized.
  T find<T extends Card>(int orderInSet, [String? debugAssertName]) {
    final result = tryFind<T>(orderInSet, debugAssertName);
    if (result != null) {
      return result;
    }
    throw StateError('Card not found: $orderInSet');
  }

  /// Looks up a card in this collection by its [orderInSet].
  ///
  /// If the card is not found, returns `null`.
  ///
  /// If the card is found, but is not of type [T], throws a [StateError]. For
  /// example, if you call `tryFind<UnitCard>(1)` on a collection that contains
  /// a [BaseCard] at order `1`, an error will be thrown.
  ///
  /// **NOTE**: This method is _not_ highly optimized.
  T? tryFind<T extends Card>(int orderInSet, [String? debugAssertName]) {
    for (final card in cards) {
      if (card.orderInSet == orderInSet) {
        if (card is! T) {
          throw StateError('Card is not a $T: $card');
        }
        assert(
          debugAssertName == null || card.name == debugAssertName,
          'Expected $debugAssertName, got ${card.name}',
        );
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
