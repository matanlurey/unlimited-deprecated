part of '../schema.dart';

/// What type of card.
///
/// {@macro unstable_enum}
enum CardType with ToDebugString {
  /// Base.
  base,

  /// Event.
  event,

  /// Leader.
  leader,

  /// Token.
  token,

  /// Unit.
  unit,

  /// Upgrade.
  upgrade;

  static final _nameToValue = mapFromEnumValues(values);

  /// Given a [name], returns the corresponding [CardType] value.
  ///
  /// Returns `null` if [name] has no corresponding [CardType] value.
  @useResult
  static CardType? tryParse(String name) => _nameToValue[name];

  /// Given a [name], returns the corresponding [CardType] value.
  ///
  /// Throws a [FormatException] if [name] has no corresponding [CardType] value.
  factory CardType.parse(String name) {
    return checkValidNotNull(tryParse(name), 'CardType');
  }

  @override
  String toDebugString() => '$CardType <$name>';
}
