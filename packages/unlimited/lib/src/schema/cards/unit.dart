part of '../../schema.dart';

/// Base class for either [UnitCard] or [LeaderCard].
@immutable
sealed class EntityCard extends PlayableCard implements TargetCard {
  /// The title of the card, if this is [unique].
  ///
  /// This is the title of the card as it appears on the card in US English.
  ///
  /// It is always either `null`, or:
  ///
  /// - Non-empty.
  /// - Title-cased.
  @nonVirtual
  final String? title;

  /// The arena the unit is played in.
  @nonVirtual
  final Arena arena;

  /// The power of the unit.
  ///
  /// Always a non-negative integer, i.e. `>= 0`.
  @nonVirtual
  final int power;

  /// The health of the unit.
  ///
  /// Always a positive integer, i.e. `>= 1`.
  @override
  @nonVirtual
  final int health;

  /// Creates an entity card with the given properties.
  ///
  /// {@macro errors_thrown_if_invalid}
  EntityCard({
    required super.cardSet,
    required super.orderInSet,
    required super.name,
    required super.aspects,
    required super.cost,
    required super.traits,
    required this.power,
    required this.health,
    required this.arena,
    required this.title,
  }) : super(unique: title != null) {
    if (title != null) {
      checkNotEmpty(value: title!, name: 'title');
    }
    RangeError.checkNotNegative(power, 'power');
    checkPositive(health, 'hp');
  }
}

/// A unit card.
@immutable
final class UnitCard extends EntityCard {
  /// Creates a unit card with the given properties.
  ///
  /// {@macro errors_thrown_if_invalid}
  UnitCard({
    required super.cardSet,
    required super.orderInSet,
    required super.name,
    required super.aspects,
    required super.cost,
    required super.traits,
    required super.power,
    required super.health,
    super.arena = Arena.ground,
  }) : super(title: null);

  /// Creates a unique unit card with the given properties.
  ///
  /// {@macro errors_thrown_if_invalid}
  UnitCard.unique({
    required super.cardSet,
    required super.orderInSet,
    required super.name,
    required String title,
    required super.aspects,
    required super.cost,
    required super.traits,
    required super.power,
    required super.health,
    super.arena = Arena.ground,
  }) : super(title: title);
}

/// A leader card.
@immutable
final class LeaderCard extends UnitCard {
  /// Creates a leader card with the given properties.
  ///
  /// {@macro errors_thrown_if_invalid}
  LeaderCard({
    required super.cardSet,
    required super.orderInSet,
    required super.name,
    required super.title,
    required super.aspects,
    required super.cost,
    required super.traits,
    required super.power,
    required super.health,
  }) : super.unique();
}
