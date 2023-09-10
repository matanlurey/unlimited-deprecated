part of '../schema.dart';

/// An arena in which [UnitCard]s are played.
///
/// {@macro unstable_enum}
enum Arena with ToDebugString {
  /// The ground arena.
  ground,

  /// The space arena.
  space;

  static final _nameToValue = mapFromEnumValues(values);

  /// Given a [name], returns the corresponding [Arena] value.
  ///
  /// Returns `null` if [name] has no corresponding [Arena] value.
  @useResult
  static Arena? tryParse(String name) => _nameToValue[name];

  /// Given a [name], returns the corresponding [Arena] value.
  ///
  /// Throws a [FormatException] if [name] has no corresponding [Arena] value.
  factory Arena.parse(String name) {
    return checkValidNotNull(tryParse(name), 'Arena');
  }

  @override
  String toDebugString() => '$Arena <$name>';
}
