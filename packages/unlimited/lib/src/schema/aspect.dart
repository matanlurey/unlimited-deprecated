part of '../schema.dart';

/// A different philosophy or motivation a card can have.
///
/// {@macro unstable_enum}
enum Aspect with ToDebugString {
  /// Aggression.
  aggression,

  /// Command.
  command,

  /// Cunning.
  cunning,

  /// Heroism.
  heroism,

  /// Vigilance.
  vigilance,

  /// Villainy.
  villainy;

  static final _nameToValue = mapFromEnumValues(values);

  /// Given a [name], returns the corresponding [Aspect] value.
  ///
  /// Returns `null` if [name] has no corresponding [Aspect] value.
  @useResult
  static Aspect? tryParse(String name) => _nameToValue[name];

  /// Given a [name], returns the corresponding [Aspect] value.
  ///
  /// Throws a [FormatException] if [name] has no corresponding [Aspect] value.
  factory Aspect.parse(String name) {
    return checkValidNotNull(tryParse(name), 'Aspect');
  }

  @override
  String toDebugString() => '$Aspect <$name>';
}
