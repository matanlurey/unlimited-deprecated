part of '../../schema.dart';

/// An event card.
@immutable
final class EventCard extends PlayableCard {
  /// Creates an event card with the given properties.
  ///
  /// ## Restrictions
  ///
  /// If any field is invalid, an error is thrown.
  EventCard({
    required super.cardSet,
    required super.orderInSet,
    required super.name,
    required super.aspects,
    required super.cost,
    required super.traits,
    super.unique,
  });
}
