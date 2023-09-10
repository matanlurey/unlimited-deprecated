part of '../state.dart';

/// A collection of cards that may span multiple [CardSet]s.
///
/// This class is intended to be used to represent all of the cards that belong
/// to a person or entity, e.g. a collection of all cards owned by a person, or
/// all cards that are legal in a tournament.
///
/// To incrementally build a [CardCollection], use [CardCollectionBuilder].
///
/// ## Equality
///
/// Two [CardCollection]s are equal if they contain the same cards, and the
/// number of copies of each card is the same. This is a **deep** equality
/// check, so it should be used with caution.
@immutable
final class CardCollection with ToDebugString {
  // For each card set, a map of cards to the number of copies of that card.
  final Map<CardSet, Map<Card, int>> _cards;

  /// Creates a new [CardCollection] with the given [cards].
  ///
  /// For each copy of a card, the card is added to the collection. For example,
  /// if [cards] contains two copies of "Darth Vader", then the collection will
  /// contain two copies of "Darth Vader".
  factory CardCollection.fromCards(Iterable<Card> cards) {
    final map = <CardSet, Map<Card, int>>{};
    for (final card in cards) {
      final cardSet = map.putIfAbsent(card.cardSet, () => {});
      cardSet.update(card, (count) => count + 1, ifAbsent: () => 1);
    }
    return CardCollection._(map);
  }

  static int _defaultCount(Card card) => 1;

  /// Creates a new [CardCollection] containing the cards from each card set.
  ///
  /// For each copy of a card, a single card is added to the collection. To
  /// set a different number of copies of a card, provide a [count] closure;
  /// note that the number of copies of a card must be greater than zero.
  factory CardCollection.fromCardSets(
    Iterable<CardSetCollection> cardSets, {
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
    return CardCollection._(map);
  }

  const CardCollection._(this._cards);

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
    if (other is! CardCollection) {
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

  /// Returns a mutable builder for this collection.
  ///
  /// The original collection is not modified.
  @useResult
  CardCollectionBuilder toBuilder() => CardCollectionBuilder._(_cards);

  /// Returns a map of card sets to the number of cards in that set.
  ///
  /// This method is provided as a convenience, but is not guaranteed to be
  /// cheap to compute. For use in a hot loop, or in a UI (i.e. Flutter
  /// `build()` methods), it's highly recommended to use the methods on this
  /// class instead, or cache the result of this method.
  @useResult
  Map<CardSet, Map<Card, int>> toMap() => Map.unmodifiable(_cards);

  @override
  String toDebugString() => 'CardCollection <${_cards.length} sets>';
}
