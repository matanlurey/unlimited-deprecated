part of '../schema.dart';

/// A collection of cards released together, i.e. [sparkOfRebellion].
///
/// **NOTE**: This enum-like class is unstable and may change between package
/// versions without a breaking change version bump. To persist, store
/// [abbreviation] instead and use [CardSet.parse] or [CardSet.tryParse] to
/// retrieve the class value.
@immutable
final class CardSet with ToDebugString {
  /// All sets of cards present in this package.
  ///
  /// **NOTE**: The position of a card set in this list is intended to be in
  /// the order of release, but this is not guaranteed. See [CardSet] for
  /// persistence support.
  static final Set<CardSet> values = Set.unmodifiable({
    sparkOfRebellion,
  });

  /// Spark of Rebellion (SOR).
  static final sparkOfRebellion = CardSet(
    'Spark of Rebellion',
    totalCards: 252,
    totalTokens: 2,
  );

  /// The abbreviated name of the card set, in US English and all caps.
  ///
  /// For example, [sparkOfRebellion] has the abbreviation "SOR".
  final String abbreviation;

  /// The full name of the card set, in US English.
  ///
  /// For example, [sparkOfRebellion] has the name "Spark of Rebellion".
  final String fullName;

  /// The total number of cards in this set.
  ///
  /// **NOTE**: This is exlusive of [totalTokens].
  final int totalCards;

  /// The total number of token cards in this set.
  final int totalTokens;

  const CardSet._({
    required this.abbreviation,
    required this.fullName,
    required this.totalCards,
    this.totalTokens = 0,
  });

  /// Creates a card set with the given [name] and [abbreviation].
  ///
  /// If [abbreviation] is not provided, it is derived from [name], by using
  /// the first letter of each word in [name], in all caps. For example the
  /// abbreviation of "Spark of Rebellion" is "SOR".
  ///
  /// ## Restrictions
  ///
  /// An error is thrown if any of the following conditions are met:
  ///
  /// - [name] and [abbreviation] is empty.
  /// - [totalCards] is not a positive integer, i.e. `>= 1`.
  /// - [totalTokens] is not a non-negative integer, i.e. `>= 0`.
  factory CardSet(
    String name, {
    required int totalCards,
    String? abbreviation,
    int totalTokens = 0,
  }) {
    checkNotEmpty(value: name, name: 'name');
    abbreviation ??= _abbreviate(name);
    checkNotEmpty(value: abbreviation, name: 'abbreviation');

    checkPositive(totalCards, 'totalCards');
    RangeError.checkNotNegative(totalTokens, 'totalTokens');

    return CardSet._(
      abbreviation: abbreviation,
      fullName: name,
      totalCards: totalCards,
      totalTokens: totalTokens,
    );
  }

  @override
  int get hashCode {
    return abbreviation.hashCode;
  }

  @override
  bool operator ==(Object other) {
    return other is CardSet && other.abbreviation == abbreviation;
  }

  static String _abbreviate(String name) {
    return name.split(' ').map((word) => word[0]).join().toUpperCase();
  }

  static final _abbrToValue = {
    for (final value in values) value.abbreviation: value,
  };

  /// Given an [abbreviation], returns the corresponding [CardSet] value.
  ///
  /// Returns `null` if [abbreviation] has no corresponding [CardSet] value.
  @useResult
  static CardSet? tryParse(String abbreviation) => _abbrToValue[abbreviation];

  /// Given an [abbreviation], returns the corresponding [CardSet] value.
  ///
  /// Throws a [FormatException] if [abbreviation] has no corresponding
  /// [CardSet] value.
  factory CardSet.parse(String abbreviation) {
    return checkValidNotNull(tryParse(abbreviation), 'CardSet');
  }

  @override
  String toDebugString() => '$CardSet <$abbreviation>';
}
