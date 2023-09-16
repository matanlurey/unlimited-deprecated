part of '../schema.dart';

/// Traits a card can have.
///
/// {@macro unstable_enum}
enum Trait with ToDebugString {
  /// Armor.
  armor,

  /// Capital ship.
  capitalShip,

  /// Droid.
  droid,

  /// Fighter.
  fighter,

  /// Force.
  force,

  /// Fringe.
  fringe,

  /// Gambit.
  gambit,

  /// Imperial.
  imperial,

  /// Innate.
  innate,

  /// Item.
  item,

  /// Jedi.
  jedi,

  /// Learned.
  learned,

  /// Lightsaber.
  lightsaber,

  /// Official.
  official,

  /// Rebel.
  rebel,

  /// Speeder.
  speeder,

  /// Sith.
  sith,

  /// Supply.
  supply,

  /// Tactics.
  tactic,

  /// Trick.
  trick,

  /// Trooper.
  trooper,

  /// Underworld.
  underworld,

  /// Vehicle.
  vehicle,

  /// Walker.
  walker,

  /// Weapon.
  weapon,

  /// Wookiee.
  wookiee;

  static final _nameToValue = mapFromEnumValues(values);

  /// Given a [name], returns the corresponding [Trait] value.
  ///
  /// Returns `null` if [name] has no corresponding [Trait] value.
  @useResult
  static Trait? tryParse(String name) => _nameToValue[name];

  /// Given a [name], returns the corresponding [Trait] value.
  ///
  /// Throws a [FormatException] if [name] has no corresponding [Trait] value.
  factory Trait.parse(String name) {
    return checkValidNotNull(tryParse(name), 'Trait');
  }

  @override
  String toDebugString() => '$Trait <$name>';
}
