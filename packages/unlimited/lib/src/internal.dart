/// Meta/utilities internal to the package.
library;

import 'package:meta/meta.dart';

/// Whether assertions are enabled.
///
/// This is `true` in debug mode (i.e. assertions enabled), and `false` in
/// release mode, and can be used to conditionally enable debug-only code and/or
/// for tree-shaking:
///
/// ```dart
/// if (isDebugMode) {
///  // Debug-only code.
/// }
/// ```
bool get isDebugMode {
  var enabled = false;
  assert(enabled = true, 'Always true in debug mode');
  return enabled;
}

/// Checks that [value] is not empty, and throws an [ArgumentError] if it is.
void checkNotEmpty({required String value, required String name}) {
  if (value.isEmpty) {
    throw ArgumentError.value(
      value,
      name,
      '$name cannot be empty',
    );
  }
}

/// Checks that [value] is at least `1`, and throws a [RangeError] if it is not.
void checkPositive(int value, String name) {
  if (value < 1) {
    throw RangeError.value(value, name, '$name must be >= 1');
  }
}

/// Checks that [value] is not `null`, and throws a [FormatException] if it is.
T checkValidNotNull<T>(T? value, String name) {
  if (value == null) {
    throw FormatException('Invalid $name: $value');
  }
  return value;
}

/// Converts [values] to a map, using the [EnumName.name] as the key.
///
/// In debug mode, throws if not in alphabetical order by name.
Map<String, T> mapFromEnumValues<T extends Enum>(Iterable<T> values) {
  return {
    for (final value in values) value.name: value,
  };
}

/// Provides a [toString] that invokes [toDebugString] in debug mode.
///
/// Override [toDebugString] to provide a debug string representation:
///
/// ```dart
/// @override
/// String toDebugString() {
///  return 'MyClass($field1, $field2)';
/// }
/// ```
mixin ToDebugString {
  @nonVirtual
  @override
  String toString() {
    if (isDebugMode) {
      return toDebugString();
    }
    return super.toString();
  }

  /// Returns a string representation of this object, suitable for debugging.
  ///
  /// The returned string may contain newlines.
  @useResult
  String toDebugString();
}
