part of '../../schema.dart';

/// A unit card.
@immutable
final class UnitCard extends PlayableCard with TargetCard {
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

  /// Whether the card is a leader unit.
  @nonVirtual
  final bool isLeader;

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
    required this.power,
    required this.health,
    this.arena = Arena.ground,
    this.title,
  })  : isLeader = false,
        super(unique: title != null) {
    if (title != null) {
      checkNotEmpty(value: title!, name: 'title');
    }
    RangeError.checkNotNegative(power, 'power');
    checkPositive(health, 'hp');
  }

  /// Creates a leader unit card with the given properties.
  ///
  /// ## Restrictions
  ///
  /// If any field is invalid, an error is thrown.
  UnitCard.leader({
    required super.cardSet,
    required super.orderInSet,
    required super.name,
    required super.aspects,
    required super.cost,
    required super.traits,
    required String this.title,
    required this.power,
    required this.health,
    this.arena = Arena.ground,
  })  : isLeader = true,
        super(unique: true) {
    checkNotEmpty(value: title!, name: 'title');
    RangeError.checkNotNegative(power, 'power');
    checkPositive(health, 'hp');
  }
}
