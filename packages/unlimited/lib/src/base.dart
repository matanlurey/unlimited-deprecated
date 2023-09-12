/// Base classes and types that are used throughout the library.
///
/// In some cases, you should not need to import this library directly, as it's
/// type inference should be enough. For example, when creating a `BaseCard`:
///
/// ```dart
/// import 'package:unlimited/schema.dart';
///
/// void main() {
///   // If you program can't handle errors, you can just use 'unwrap':
///   final result = BaseCard(
///     cardSet: CardSet.sparkOfRebellion,
///     orderInSet: 1,
///     name: 'Jedi Temple',
///     location: 'Coruscant',
///     // Forgot to add at least one aspect.
///     aspects: const {},
///   ).unwrap();
///
///   // An error is thrown if the result was not successful.
///
///   // At this point, the type of 'result' is 'BaseCard'.
///   print('Name: ${result.name}');
/// }
/// ```
///
/// If you do import this library, it's recommended to import it with a prefix:
///
/// ```dart
/// import 'package:unlimited/base.dart' as u;
/// import 'package:unlimited/schema.dart';
///
/// void main() {
///   final result = BaseCard(
///     cardSet: CardSet.sparkOfRebellion,
///     orderInSet: 1,
///     name: 'Jedi Temple',
///     location: 'Coruscant',
///     // Forgot to add at least one aspect.
///     aspects: const {},
///   );
///
///   switch (result) {
///     case u.Ok(: final value):
///       print('Name: ${value.name}');
///     case u.Error(: final error):
///       print('Error: ${error.message}');
///   }
/// }
/// ```
library;

/// A result that is either a value [T] or an exception [E].
///
/// Used to represent a computation that may fail, but is intended to be caught
/// and handled by the caller. This type is used anywhere that an [Exception]
/// might be thrown in classical Dart code.
sealed class Result<T, E extends Object> {
  /// Creates a new [Result] that is an failure [error].
  const factory Result.error(E error) = Error._;

  /// Creates a new [Result] that is a successful [value].
  const factory Result.ok(T value) = Ok._;

  const Result._();
}

/// A successful result.
final class Ok<T, E extends Object> extends Result<T, E> {
  /// Successful result.
  final T value;

  const Ok._(this.value) : super._();
}

/// A failed result.
final class Error<T, E extends Object> extends Result<T, E> {
  /// The error that occurred.
  final E error;

  const Error._(this.error) : super._();
}
