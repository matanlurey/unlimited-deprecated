part of '../state.dart';

/// A collection of cards that may span multiple [CardSet]s.
///
/// This class is intended to be used to represent all of the cards that belong
/// to a person or entity, e.g. a collection of all cards owned by a person, or
/// all cards that are legal in a tournament.
///
/// ## Equality
///
/// Two [Collection]s are equal if they contain the same cards, and the number
/// of copies of each card is the same. This is a **deep** equalit check, so it
/// should be used with caution.
@immutable
final class Collection with ToDebugString {
  // For each card set, a map of cards to the number of copies of that card.
  final Map<CardSet, Map<Card, int>> _cards;

  /// Creates a new [Collection] with the given [cards].
  ///
  /// For each copy of a card, the card is added to the collection. For example,
  /// if [cards] contains two copies of "Darth Vader", then the collection will
  /// contain two copies of "Darth Vader".
  factory Collection.fromCards(Iterable<Card> cards) {
    final map = <CardSet, Map<Card, int>>{};
    for (final card in cards) {
      final cardSet = map.putIfAbsent(card.cardSet, () => {});
      cardSet.update(card, (count) => count + 1, ifAbsent: () => 1);
    }
    return Collection._(map);
  }

  static int _defaultCount(Card card) => 1;

  /// Creates a new [Collection] containing the cards from each card set.
  ///
  /// For each copy of a card, a single card is added to the collection. To
  /// set a different number of copies of a card, provide a [count] closure;
  /// note that the number of copies of a card must be greater than zero.
  factory Collection.fromCardSets(
    Iterable<CardSetInventory> cardSets, {
    int Function(Card) count = _defaultCount,
  }) {
    final map = <CardSet, Map<Card, int>>{};
    for (final cardSet in cardSets) {
      for (final card in cardSet.cards) {
        final copies = count(card);
        RangeError.checkNotNegative(copies, 'count');
        if (copies == 0) {
          continue;
        }
        final cardSetMap = map.putIfAbsent(card.cardSet, () => {});
        cardSetMap.update(
          card,
          (count) => count + copies,
          ifAbsent: () => copies,
        );
      }
    }
    return Collection._(map);
  }

  Collection._(this._cards);

  /// Returns all of the cards in this collection.
  ///
  /// Multiple copies of the same card will be returned multiple times.
  ///
  /// To get a unique list of cards, use [toSet].
  late final Iterable<Card> allCards = _cards.values.expand((e) => e.keys);

  /// Looks up a card in this collection by its [cardSet] and [orderInSet].
  ///
  /// If the card is not found, throws a [StateError].
  ///
  /// **NOTE**: This method is _not_ highly optimized.
  Card find(CardSet cardSet, int orderInSet) {
    final result = tryFind(cardSet, orderInSet);
    if (result != null) {
      return result;
    }
    throw StateError('Card not found: $cardSet $orderInSet');
  }

  /// Looks up a card in this collection by its [cardSet] and [orderInSet].
  ///
  /// If the card is not found, returns `null`.
  ///
  /// **NOTE**: This method is _not_ highly optimized.
  Card? tryFind(CardSet cardSet, int orderInSet) {
    return tryFindCopies(cardSet, orderInSet).card;
  }

  /// Looks up a card in this collection by its [cardSet] and [orderInSet].
  ///
  /// If the card is not found, throws a [StateError].
  ///
  /// **NOTE**: This method is _not_ highly optimized.
  ({Card card, int count}) findCopies(CardSet cardSet, int orderInSet) {
    final (:card, :count) = tryFindCopies(cardSet, orderInSet);
    if (card != null) {
      return (card: card, count: count);
    }
    throw StateError('Card not found: $cardSet $orderInSet');
  }

  /// Looks up a card in this collection by its [cardSet] and [orderInSet].
  ///
  /// If the card is found, returns a tuple of the card and the number of
  /// copies of that card in this collection. If the card is not found, returns
  /// a record of `null` and `0`.
  ///
  /// **NOTE**: This method is _not_ highly optimized.
  ({Card? card, int count}) tryFindCopies(CardSet cardSet, int orderInSet) {
    final cardSetMap = _cards[cardSet];
    if (cardSetMap == null) {
      return (card: null, count: 0);
    }
    for (final card in cardSetMap.keys) {
      if (card.orderInSet == orderInSet) {
        return (card: card, count: cardSetMap[card] ?? 0);
      }
    }
    return (card: null, count: 0);
  }

  @override
  int get hashCode {
    // Just return a hash of all of the cards, unordered.
    return Object.hashAllUnordered(
      _cards.values.map((e) {
        return Object.hashAllUnordered(
          e.entries.map((c) => Object.hash(c.key, c.value)),
        );
      }),
    );
  }

  @override
  bool operator ==(Object other) {
    if (other is! Collection) {
      return false;
    }
    if (_cards.length != other._cards.length) {
      return false;
    }
    for (final entry in _cards.entries) {
      final otherEntry = other._cards[entry.key];
      if (otherEntry == null) {
        return false;
      }
      if (entry.value.length != otherEntry.length) {
        return false;
      }
      for (final card in entry.value.keys) {
        if (entry.value[card] != otherEntry[card]) {
          return false;
        }
      }
    }
    return true;
  }

  /// Returns the number of copies of [card] in this collection.
  ///
  /// This is an alias for [count].
  int operator [](Card card) => count(card);

  /// Returns the number of copies of [card] in this collection.
  ///
  /// This is an alias for `operator[]`.
  @useResult
  int count(Card card) {
    final cardSet = _cards[card.cardSet];
    if (cardSet == null) {
      return 0;
    }
    return cardSet[card] ?? 0;
  }

  /// Returns whether this collection contains at least one copy of [card].
  @useResult
  bool contains(Card card) => count(card) > 0;

  /// Returns a map of card sets to the number of cards in that set.
  ///
  /// This method is provided as a convenience, but is not guaranteed to be
  /// cheap to compute. For use in a hot loop, or in a UI (i.e. Flutter
  /// `build()` methods), it's highly recommended to use the methods on this
  /// class instead, or cache the result of this method.
  @useResult
  Map<CardSet, Map<Card, int>> toMap() => Map.unmodifiable(_cards);

  /// Returns a set of all of the cards in this collection.
  ///
  /// This method is provided as a convenience, but is not guaranteed to be
  /// cheap to compute. For use in a hot loop, or in a UI (i.e. Flutter
  /// `build()` methods), it's highly recommended to use the methods on this
  /// class instead, or cache the result of this method.
  @useResult
  Set<Card> toSet() => allCards.toSet();

  @override
  String toDebugString() => 'CardCollection <${_cards.length} sets>';
}
