part of '../../schema.dart';

/// An event card.
@immutable
final class EventCard extends PlayableCard {
  /// Creates an event card with the given properties.
  ///
  /// {@macro errors_thrown_if_invalid}
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
