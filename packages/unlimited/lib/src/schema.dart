/// Contains the core classes of the game.
library;

import 'package:meta/meta.dart';
import 'package:unlimited/src/internal.dart';

// We use `@macro` in this file, and it references non-existent members.
// ignore_for_file: comment_references

part 'schema/arena.dart';
part 'schema/aspect.dart';
part 'schema/card.dart';
part 'schema/cards/base.dart';
part 'schema/cards/event.dart';
part 'schema/cards/unit.dart';
part 'schema/cards/upgrade.dart';
part 'schema/set.dart';
part 'schema/trait.dart';

/// This is only used to provide `@macro` support for Dartdoc.
///
/// See <https://pub.dev/packages/dartdoc#macros>.
///
/// {@template unstable_enum}
/// [values] is always in alphabetical order (using [EnumName.name]).
///
/// **NOTE**: As a result, the [index] of values in the enum are unstable and
/// may change between package versions without a breaking change version bump.
/// To persist, store [name] instead and use [parse] or [tryParse] to retrieve
/// the enum value.
/// {@endtemplate}
///
/// {@template errors_thrown_if_invalid}
/// ## Errors
///
/// This class is not intended to be used with user-provided input, and as such
/// does not provide any error handling. If any of the fields are invalid, an
/// error will be thrown.
/// {@endtemplate}
extension _DartDocMacros on Never {}
