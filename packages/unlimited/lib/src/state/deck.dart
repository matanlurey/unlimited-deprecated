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
///
///
/// In order to represent a deck that is not complete (i.e. to represent a deck
/// you are in the process of building), use [DeckBuilder], which performs some
/// validation checks but does not enforce 50 cards.
final class Deck {
  /// The leader of this deck.
  final UnitCard leader;

  /// The base of this deck.
  final UnitCard base;

  /// The cards in this deck.
  final List<Card> cards;

  /// TBD.
  const Deck({
    required this.leader,
    required this.base,
    required this.cards,
  });
}

/// ...
///
/// Each valid deck includes:
///
/// - 1 [leader]
/// - 1 [base]
/// - At least 50 other [UnitCard]s, [EventCard]s, and [UpgradeCard]s.
///
/// A deck can't include more than 3 copies of any card.
///
/// Your [leader] and [base] each provide [aspects] that dictate the _colors_ of
/// your deck, for a total 3 of aspects. Most cards in a deck have one or more
/// [Card.aspects]. You can include cards of any aspect, but an aspect penalty
/// of 2 extra resources is applied for each missing aspect.
///
/// A good rule of thumb for a deck is to include 30-40 [UnitCard]s (with a mix
/// of [Arena.ground] and [Arena.space] units), and about 10-20 [EventCard]s and
/// [UpgradeCard]s. You should make sure to include cards with a variety of
/// costs, including plenty of 1-3 cost cards to play early in the game.
final class DeckBuilder {
  /// The leader of this deck.
  UnitCard? leader;

  /// The base of this deck.
  UnitCard? base;
}
