part of '../../schema.dart';

/// An upgrade card.
@immutable
final class UpgradeCard extends PlayableCard {
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
    this.bonusPower = 0,
    this.bonusHp = 0,
  });

  /// Creates an upgrade _token_ card with the given properties.
  ///
  /// {@macro errors_thrown_if_invalid}
  ///
  /// See also [isToken], which has different validation rules for some fields.
  UpgradeCard.token({
    required super.cardSet,
    required super.orderInSet,
    required super.name,
    required super.traits,
    this.bonusPower = 0,
    this.bonusHp = 0,
  }) : super(aspects: const {}, cost: 0, unique: false, isToken: true);

  @override
  bool get isValidInDeck => !isToken;

  @override
  void _checkOrderInSet() {
    if (isToken) {
      RangeError.checkValueInInterval(
        orderInSet,
        1,
        cardSet.totalTokens,
        'orderInSet',
      );
    }
    return super._checkOrderInSet();
  }

  @override
  void _checkAspectsLength() {
    if (!isToken) {
      return super._checkAspectsLength();
    }
  }

  @override
  String toDebugString() {
    if (isToken) {
      final orderInSet = this.orderInSet.toString().padLeft(2, '0');
      return '$Card <${cardSet.abbreviation}T$orderInSet: $name>}';
    }
    return super.toDebugString();
  }
}
