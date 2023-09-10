part of '../state.dart';

/// A mutable builder for [CardCollection].
///
/// This class is intended to be used to incrementally build a [CardCollection].
///
/// To create a [CardCollection], see [build].
final class CardCollectionBuilder {
  // For each card set, a map of cards to the number of copies of that card.
  final Map<CardSet, Map<Card, int>> _cards;

  const CardCollectionBuilder._(this._cards);

  /// Creates a new [CardCollection] from the cards in this builder.
  CardCollection build() {
    // Create a deep copy of the internal map of maps.
    final map = <CardSet, Map<Card, int>>{};
    for (final entry in _cards.entries) {
      map[entry.key] = Map.of(entry.value);
    }
    return CardCollection._(map);
  }

  /// Returns the number of copies of [card] in this collection.
  ///
  /// This is an alias for [count].
  int operator [](Card card) => count(card);

  /// Sets the number of copies of [card] in this collection to [count].
  ///
  /// If [count] is zero, then [card] is removed from this collection.
  ///
  /// This an alias for [setCount].
  void operator []=(Card card, int count) {}

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

  /// Sets the number of copies of [card] in this collection to [count].
  ///
  /// If [count] is zero, then [card] is removed from this collection.
  ///
  /// This an alias for `operator[]=`.
  void setCount(Card card, int count) {
    RangeError.checkNotNegative(count, 'count');

    if (count == 0) {
      removeAll(card);
      return;
    }

    final cardSet = _cards.putIfAbsent(card.cardSet, () => {});
    cardSet[card] = count;
  }

  /// Returns whether this collection contains at least one copy of [card].
  @useResult
  bool contains(Card card) => count(card) > 0;

  /// Clears all cards from this collection.
  void clear() {
    _cards.clear();
  }

  /// Adds a copy of [card] to this collection.
  ///
  /// A [count] may be provided to add multiple copies of [card].
  void insert(Card card, {int count = 1}) {
    checkPositive(count, 'count');
    final cardSet = _cards.putIfAbsent(card.cardSet, () => {});
    cardSet.update(card, (current) => current + count, ifAbsent: () => count);
  }

  /// Adds all of the given [cards] to this collection.
  ///
  /// If multiple copies of a card are provided, then that number of copies will
  /// be added to this collection. Alternatively, see [insertAllWithCount].
  void insertAll(Iterable<Card> cards) {
    for (final card in cards) {
      insert(card);
    }
  }

  /// Adds all of the given [cards] to this collection.
  ///
  /// The tuple that is provided is a pair of the card and the number of copies
  /// of that card to add to this collection. For example:
  ///
  /// ```dart
  /// final cards = [
  ///   (vader, 2),
  ///   (palpatine, 1),
  /// ];
  ///
  /// builder.insertAllWithCount(cards);
  /// ```
  void insertAllWithCount(Iterable<(Card card, int count)> cards) {
    for (final card in cards) {
      insert(card.$1, count: card.$2);
    }
  }

  /// Removes a single copy of [card] from this collection.
  ///
  /// Returns the removed card, or `null` if [card] was not in this collection.
  Card? remove(Card card) {
    final cardSet = _cards[card.cardSet];
    if (cardSet == null) {
      return null;
    }
    final count = cardSet[card];
    if (count == null) {
      return null;
    }
    if (count == 1) {
      cardSet.remove(card);
    } else {
      cardSet[card] = count - 1;
    }
    return card;
  }

  /// Clears all copies of the given [card] from this collection.
  ///
  /// Returns the number of copies of [card] that were removed.
  int removeAll(Card card) {
    final cardSet = _cards[card.cardSet];
    if (cardSet == null) {
      return 0;
    }
    final count = cardSet.remove(card);
    return count ?? 0;
  }
}
