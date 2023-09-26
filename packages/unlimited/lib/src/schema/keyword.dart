// ignore_for_file: noop_primitive_operations

part of '../schema.dart';

/// A keyword that can be present on a [Card] or granted as an effect/condition.
///
/// Each keyword can be targeted by their name, for example "units that have the
/// X keyword", and provide 1 or more abilities, often conditionally. For
/// example, the [Saboteur] keyword applies _when the unit attacks_, ignores the
/// defender's [Sentinel] keyword, and defeats the defender's _shield_ tokens.
@immutable
sealed class Keyword {
  /// Provided to allow sub-types to `extends Keyword` and be `const`.
  const Keyword();
}

/// When this unit attacks, ignore [Sentinel] and defeat the defender's shields.
final class Saboteur extends Keyword {
  /// Creates a saboteur keyword.
  @literal
  const Saboteur();

  @override
  String toString() {
    return ''
        "When this unit attacks, ignore Sentinel and defeat the defender's "
        'shields.';
  }
}

/// Units in this arena can't attack your non-[Sentinel] units or your base.
final class Sentinel extends Keyword {
  /// Creates a sentinel keyword.
  @literal
  const Sentinel();

  @override
  String toString() {
    return ''
        "Units in this arena can't attack your non-Sentinel units or your "
        'base.';
  }
}

/// This unit gets +[attack]/+[health] while attacking.
final class Raid extends Keyword {
  /// The amount of attack to gain.
  final int attack;

  /// The amount of health to gain.
  final int health;

  /// Creates a raid keyword.
  const Raid(this.attack, this.health);

  @override
  int get hashCode => Object.hash(Raid, attack, health);

  @override
  bool operator ==(Object other) {
    return other is Raid && attack == other.attack && health == other.health;
  }

  @override
  String toString() {
    return 'This unit gets +$attack/+$health while attacking.';
  }
}

/// When this unit attacks, heal [damage] from your base.
final class Restore extends Keyword {
  /// The amount of damage to heal.
  final int damage;

  /// Creates a restore keyword.
  const Restore(this.damage);

  @override
  int get hashCode => Object.hash(Restore, damage);

  @override
  bool operator ==(Object other) {
    return other is Restore && damage == other.damage;
  }

  @override
  String toString() {
    return 'When this unit attacks, heal $damage from your base.';
  }
}

/// After you play this unit, it may ready and attack an enemy unit.
final class Ambush extends Keyword {
  /// Creates an ambush keyword.
  @literal
  const Ambush();

  @override
  String toString() {
    return 'After you play this unit, it may ready and attack an enemy unit.';
  }
}
