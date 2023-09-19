part of '../schema.dart';

/// A card within the game.
///
/// ## Equality
///
/// A card's equality is solely based on its [cardSet], [orderInSet]. However,
/// [TokenCard]s are not equal to non-token cards with the same [orderInSet].
@immutable
sealed class Card with ToDebugString {
  /// The set the card belongs to.
  @nonVirtual
  final CardSet cardSet;

  /// Within the set, the card's number from `1` to [CardSet.totalCards].
  ///
  /// If this card is a [TokenCard], this is the token's number from `1` to the
  /// number of tokens in the set, [CardSet.totalTokens].
  @nonVirtual
  final int orderInSet;

  /// The name of the card.
  ///
  /// This is the name of the card as it appears on the card in US English.
  ///
  /// It is always:
  ///
  /// - Non-empty.
  /// - Unique within the set.
  /// - Title-cased.
  @nonVirtual
  final String name;

  /// Aspects that the card belongs to.
  ///
  /// Always contains at least one aspect, and up to two aspects.
  ///
  /// Aspects can be repeated, e.g. two [Aspect.command] aspects.
  @nonVirtual
  final List<Aspect> aspects;

  /// Whether the card is unique.
  @nonVirtual
  final bool unique;

  /// Creates a card with the given [cardSet], [orderInSet], [name], [aspects].
  ///
  /// {@macro errors_thrown_if_invalid}
  Card({
    required this.cardSet,
    required this.orderInSet,
    required this.name,
    required this.aspects,
    this.unique = false,
  }) {
    _checkOrderInSet();
    _checkAspectsLength();
    checkNotEmpty(value: name, name: 'name');
  }

  void _checkOrderInSet() {
    RangeError.checkValueInInterval(
      orderInSet,
      1,
      cardSet.totalCards,
      'orderInSet',
    );
  }

  void _checkAspectsLength() {
    RangeError.checkValueInInterval(
      aspects.length,
      1,
      2,
      'aspects.length',
    );
  }

  @override
  @nonVirtual
  int get hashCode => Object.hash(cardSet, orderInSet, this is TokenCard);

  @override
  @nonVirtual
  bool operator ==(Object other) {
    return other is Card &&
        cardSet == other.cardSet &&
        orderInSet == other.orderInSet &&
        this is TokenCard == other is TokenCard;
  }

  @override
  String toDebugString() {
    final orderInSet = this.orderInSet.toString().padLeft(3, '0');
    return '$Card <${cardSet.abbreviation}$orderInSet: $name>';
  }
}

/// A card that can be played, i.e. anything but a [BaseCard].
///
/// Most of these cards can be included in a deck, except [TokenCard].
@immutable
sealed class PlayableCard extends Card {
  /// The cost of the card.
  ///
  /// Always a non-negative integer, i.e. `>= 0`.
  @nonVirtual
  final int cost;

  /// Traits that the card has.
  ///
  /// Always contains at least one trait, and up to four traits.
  @nonVirtual
  final Set<Trait> traits;

  /// Creates a playable card with the given properties.
  ///
  /// {@macro errors_thrown_if_invalid}
  PlayableCard({
    required super.cardSet,
    required super.orderInSet,
    required super.name,
    required super.aspects,
    required this.cost,
    required this.traits,
    super.unique,
  }) {
    RangeError.checkNotNegative(cost, 'cost');
    RangeError.checkValueInInterval(
      traits.length,
      1,
      4,
      'traits.length',
    );
  }
}

/// A card that can be targeted, i.e. a [UnitCard] or [BaseCard].
///
/// **NOTE**: This class should not be
sealed class TargetCard {
  /// The health of the card.
  ///
  /// Always a positive integer, i.e. `>= 1`.
  int get health;
}
