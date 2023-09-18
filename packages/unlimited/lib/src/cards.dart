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

  /// An indexed lookup table for the cards in this collection.
  final List<Card?> _lookupCards;

  /// An indexed lookup table for the tokens in this collection.
  final List<TokenCard?> _lookupTokens;

  /// The card set that every card in [cards] belongs to.
  final CardSet cardSet;

  /// Creates a new [CardSetInventory] for the given [cards] in [belongsTo].
  ///
  /// If [belongsTo] is not specified, the first card's [Card.cardSet] is used.
  ///
  /// While [cards] does not need to be _all_ the cards in [cardSet] (i.e. due
  /// to partial releases), every card in [cards] must belong to [cardSet] or an
  /// error will be thrown.
  factory CardSetInventory(Set<Card> cards, {CardSet? belongsTo}) {
    if (belongsTo == null) {
      if (cards.isEmpty) {
        throw ArgumentError.value(
          '<empty set>',
          'cards',
          'Must specify belongsTo if cards is empty',
        );
      }
      belongsTo = cards.first.cardSet;
    }

    // Create an indexed lookup table for the cards in the set.
    final lookupCards = List<Card?>.filled(belongsTo.totalCards, null);
    final lookupTokens = List<TokenCard?>.filled(belongsTo.totalCards, null);
    for (final card in cards) {
      if (card.cardSet != belongsTo) {
        throw ArgumentError.value(
          card,
          'cards',
          'Card does not belong to $belongsTo',
        );
      }
      if (card is TokenCard) {
        lookupTokens[card.orderInSet - 1] = card;
      } else {
        lookupCards[card.orderInSet - 1] = card;
      }
    }

    return CardSetInventory._(
      cards,
      belongsTo,
      lookupCards,
      lookupTokens,
    );
  }

  CardSetInventory._(
    Set<Card> cards,
    this.cardSet,
    this._lookupCards,
    this._lookupTokens,
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
  T find<T extends Card>(int orderInSet, [String? debugAssertName]) {
    final result = tryFind<T>(orderInSet, debugAssertName);
    if (result != null) {
      return result;
    }
    throw StateError('Card not found: $orderInSet');
  }

  /// Looks up a token in this collection by its [orderInSet].
  ///
  /// If the card is not found, throws a [StateError].
  ///
  /// If [debugAssertName] is provided, in debug mode (assertions enabled) the
  /// card's name will be checked against it, exactly as written. This is useful
  /// for debugging, but should not be relied upon.
  TokenCard findToken(int orderInSet, [String? debugAssertName]) {
    final result = tryFindToken(orderInSet, debugAssertName);
    if (result != null) {
      return result;
    }
    throw StateError('Token not found: $orderInSet');
  }

  /// Looks up a card in this collection by its [orderInSet].
  ///
  /// If the card is not found, returns `null`.
  ///
  /// If the card is found, but is not of type [T], throws a [StateError]. For
  /// example, if you call `tryFind<UnitCard>(1)` on a collection that contains
  /// a [BaseCard] at order `1`, an error will be thrown.
  T? tryFind<T extends Card>(int orderInSet, [String? debugAssertName]) {
    final card = _lookupCards[orderInSet - 1];
    if (card == null) {
      return null;
    }
    assert(
      debugAssertName == null || card.name == debugAssertName,
      'Expected $debugAssertName, got ${card.name}',
    );
    if (card is T) {
      return card;
    }
    throw StateError('Expected $T, got ${card.runtimeType}');
  }

  /// Looks up a token in this collection by its [orderInSet].
  ///
  /// If the card is not found, returns `null`.
  ///
  /// If [debugAssertName] is provided, in debug mode (assertions enabled) the
  /// card's name will be checked against it, exactly as written. This is useful
  /// for debugging, but should not be relied upon.
  TokenCard? tryFindToken(int orderInSet, [String? debugAssertName]) {
    final card = _lookupTokens[orderInSet - 1];
    if (card == null) {
      return null;
    }
    assert(
      debugAssertName == null || card.name == debugAssertName,
      'Expected $debugAssertName, got ${card.name}',
    );
    return card;
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
