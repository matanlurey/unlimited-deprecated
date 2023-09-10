part of '../schema.dart';

/// A card within the game.
///
/// ## Equality
///
/// A card's equality is solely based on its [cardSet], [orderInSet], [isToken].
@immutable
sealed class Card with ToDebugString {
  /// The set the card belongs to.
  @nonVirtual
  final CardSet cardSet;

  /// Within the set, the card's number from `1` to [CardSet.totalCards].
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
  @nonVirtual
  final Set<Aspect> aspects;

  /// Whether the card is unique.
  @nonVirtual
  final bool unique;

  /// Whether the card is a token upgrade.
  ///
  /// These cards are not part of the main deck, but are instead used to
  /// represent ephemeral upgrades, such as "Experience" or "Shield". Tokens do
  /// not have [aspects], are treated separate from other cards with the same
  /// [orderInSet] and always have a cost of `0`.
  @nonVirtual
  final bool isToken;

  /// Creates a card with the given [cardSet], [orderInSet], [name], [aspects].
  ///
  /// ## Restrictions
  ///
  /// An error is thrown if any field is invalid.
  Card({
    required this.cardSet,
    required this.orderInSet,
    required this.name,
    required this.aspects,
    this.unique = false,
    this.isToken = false,
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
  int get hashCode => Object.hash(cardSet, orderInSet, isToken);

  @override
  @nonVirtual
  bool operator ==(Object other) {
    return other is Card &&
        cardSet == other.cardSet &&
        orderInSet == other.orderInSet &&
        isToken == other.isToken;
  }

  @override
  String toDebugString() {
    final orderInSet = this.orderInSet.toString().padLeft(3, '0');
    return '$Card <${cardSet.abbreviation}$orderInSet: $name>';
  }
}

/// A card that can be played, i.e. anything but a [BaseCard].
///
/// Most of these cards can be included in a deck, except [UpgradeCard.token].
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
  /// ## Restrictions
  ///
  /// If any field is invalid, an error is thrown.
  PlayableCard({
    required super.cardSet,
    required super.orderInSet,
    required super.name,
    required super.aspects,
    required this.cost,
    required this.traits,
    super.unique,
    super.isToken,
  }) {
    RangeError.checkNotNegative(cost, 'cost');
    RangeError.checkValueInInterval(
      traits.length,
      1,
      4,
      'traits.length',
    );
  }

  /// Whether the card is valid in a deck.
  ///
  /// This is `true` for all cards except [UpgradeCard.token].
  bool get isValidInDeck => true;
}
