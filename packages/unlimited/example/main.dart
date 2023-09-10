// It's recommended to import the library with a prefix.
import 'package:unlimited/cards.dart' as cards;
import 'package:unlimited/schema.dart';

void main() {
  final vader = cards.sparkOfRebellion.firstWhere(
    (card) => card.name == 'Darth Vader',
  );

  // Pattern match to get the card's type.
  switch (vader) {
    case final BaseCard card:
      print('Base:    ${card.name}: ${card.location}');
    case final UnitCard card:
      print('Unit:    ${card.name}: ${card.title ?? '<No title>'}');
    case final EventCard card:
      print('Event:   ${card.name}');
    case final UpgradeCard card:
      print('Upgrade: ${card.name}');
  }
}
