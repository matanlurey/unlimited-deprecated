part of '../../schema.dart';

/// An attachment card, either a [TokenCard] or a [PlayableCard].
@immutable
sealed class AttachmentCard extends PlayableCard {
  /// Amount of power added to a unit.
  ///
  /// Always a non-negative integer, i.e. `>= 0`.
  @nonVirtual
  final int bonusPower;

  /// Amount of health added to a unit.
  ///
  /// Always a non-negative integer, i.e. `>= 0`.
  @nonVirtual
  final int bonusHp;

  /// Creates an attachment card with the given properties.
  ///
  /// {@macro errors_thrown_if_invalid}
  AttachmentCard({
    required super.cardSet,
    required super.orderInSet,
    required super.name,
    required super.aspects,
    required super.cost,
    required super.traits,
    super.unique,
    this.bonusPower = 0,
    this.bonusHp = 0,
  });
}

/// An upgrade card.
final class UpgradeCard extends AttachmentCard {
  /// Creates an upgrade card with the given properties.
  ///
  /// {@macro errors_thrown_if_invalid}
  UpgradeCard({
    required super.cardSet,
    required super.orderInSet,
    required super.name,
    required super.aspects,
    required super.cost,
    required super.traits,
    super.unique,
    super.bonusPower,
    super.bonusHp,
  });
}

/// A token card.
///
/// These cards are not part of the main deck, but are instead used to
/// represent ephemeral upgrades, such as "Experience" or "Shield". Tokens do
/// not have [aspects], are treated separate from other cards with the same
/// [orderInSet] and always have a cost of `0`.
final class TokenCard extends AttachmentCard {
  /// Creates a token card with the given properties.
  ///
  /// {@macro errors_thrown_if_invalid}
  TokenCard({
    required super.cardSet,
    required super.orderInSet,
    required super.name,
    required super.traits,
    super.bonusPower,
    super.bonusHp,
  }) : super(aspects: const {}, cost: 0);

  @override
  void _checkOrderInSet() {
    RangeError.checkValueInInterval(
      orderInSet,
      1,
      cardSet.totalTokens,
      'orderInSet',
    );
    return super._checkOrderInSet();
  }

  @override
  void _checkAspectsLength() {
    // Tokens have no aspects.
  }

  @override
  String toDebugString() {
    final orderInSet = this.orderInSet.toString().padLeft(2, '0');
    return '$Card <${cardSet.abbreviation}T$orderInSet: $name>}';
  }
}
