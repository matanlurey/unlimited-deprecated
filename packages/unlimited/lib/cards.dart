/// Inlines a copy of the cards database.
///
/// While some applications will want to store/update the database in a database
/// or storage format (i.e. JSON), this library is provided as a convenience for
/// applications that want to use the cards database without having to manage
/// external resources.
///
/// All known card sets are available as top-level variables:
///
/// - [sparkOfRebellion]
///
/// For a future proof collection of _every_ card set, use [allCardSets].
///
/// ## Example
///
/// ```dart
/// // It's recommended to import the library with a prefix.
/// import 'package:unlimited/cards.dart' as cards;
/// import 'package:unlimited/schema.dart';
///
/// void main() {
///   final vader = cards.sparkOfRebellion.find(10);
///
///   // Pattern match to get the card's type.
///   switch (vader) {
///     case final BaseCard card:
///       print('Base:  ${card.name}: ${card.location}');
///     case final UnitCard card:
///       print('Unit:    ${card.name}: ${card.title ?? '<No title>'}');
///     case final EventCard card:
///       print('Event: ${card.name}');
///     case final UpgradeCard card:
///       print('Upgrade: ${card.name}');
///   }
/// }
/// ```
library;

import 'package:unlimited/src/cards.dart';
import 'package:unlimited/src/state.dart';

export 'src/cards.dart';

/// A collection of every card set in the game.
final allCardSets = Collection.fromCardSets([sparkOfRebellion]);
