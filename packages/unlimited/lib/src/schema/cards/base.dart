part of '../../schema.dart';

/// A base card.
@immutable
final class BaseCard extends Card {
  /// The health of the base.
  ///
  /// Always a positive integer, i.e. `>= 1`.
  @nonVirtual
  final int hp;

  /// The location of the base.
  ///
  /// Always a non-empty string.
  final String location;

  /// Creates a base card with the given properties.
  ///
  /// {@macro errors_thrown_if_invalid}
  BaseCard({
    required super.cardSet,
    required super.orderInSet,
    required super.name,
    required super.aspects,
    required this.location,
    this.hp = 30,
  }) : super(unique: false) {
    checkPositive(hp, 'hp');
    checkNotEmpty(value: location, name: 'location');
  }
}
