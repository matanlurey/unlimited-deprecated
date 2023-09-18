part of '../state.dart';

/// Represents a pre-made or custom deck of 52+ cards.
///
/// Each deck includes:
///
/// - 1 [leader]
/// - 1 [base]
/// - At least 50 other [UnitCard]s, [EventCard]s, and [UpgradeCard]s.
///
/// A deck doesn't include more than 3 cppies of any card.
@immutable
final class Deck {
  /// The leader of this deck.
  final UnitCard leader;

  /// The base of this deck.
  final BaseCard base;

  /// The _other_ cards in this deck.
  ///
  /// This should:
  ///
  /// - Not be a [TokenCard].
  /// - Exclude [leader] or any other leader cards.
  /// - Have at least 48 cards.
  /// - No more than 3 are copies of the same card.
  final List<PlayableCard> cards;

  /// Creates a new deck with the given [leader], [base], and other [cards].
  ///
  /// {@macro errors_thrown_if_invalid}
  factory Deck({
    required UnitCard leader,
    required BaseCard base,
    required List<PlayableCard> cards,
  }) {
    // At least 48 cards.
    if (cards.length < 48) {
      throw ArgumentError.value(
        cards.length,
        'cards.length',
        'must contain at least 48 cards (i.e. 50 including leader and base)',
      );
    }

    // Ensure that there are no leaders in the deck and <= 3 copies.
    final count = <Card, int>{};
    for (final card in cards) {
      switch (card) {
        case TokenCard():
          throw ArgumentError.value(
            card.name,
            'cards',
            'cannot contain token cards',
          );
        case UnitCard() when card is LeaderCard:
          throw ArgumentError.value(
            card.name,
            'cards',
            'cannot contain a leader card',
          );
        case _:
          final total = count.update(
            card,
            (value) => value + 1,
            ifAbsent: () => 1,
          );
          if (total > 3) {
            throw ArgumentError.value(
              card.name,
              'cards',
              'cannot contain more than 3 copies of the same card',
            );
          }
      }
    }

    return Deck._(
      leader: leader,
      base: base,
      cards: List.unmodifiable(cards),
    );
  }

  Deck._({
    required this.leader,
    required this.base,
    required this.cards,
  });

  /// All aspects in this deck (i.e. inherited from both [leader] and [base]).
  late final Set<Aspect> aspects = {
    ...leader.aspects,
    ...base.aspects,
  };

  @override
  int get hashCode {
    return Object.hash(base, leader, Object.hashAllUnordered(cards));
  }

  @override
  bool operator ==(Object other) {
    if (other is! Deck || other.cards.length != cards.length) {
      return false;
    }
    if (other.leader != leader || other.base != base) {
      return false;
    }
    final a = _countCards(cards);
    final b = _countCards(other.cards);
    for (final card in a.keys) {
      if (a[card] != b[card]) {
        return false;
      }
    }
    return true;
  }

  static Map<Card, int> _countCards(List<Card> cards) {
    final count = <Card, int>{};
    for (final card in cards) {
      count.update(
        card,
        (value) => value + 1,
        ifAbsent: () => 1,
      );
    }
    return count;
  }

  @override
  String toString() => 'Deck<$leader, $base, ${cards.length} cards>';
}
