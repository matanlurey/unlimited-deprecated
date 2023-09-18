// It's recommended to import the library with a prefix.
import 'package:unlimited/cards.dart' as cards;
import 'package:unlimited/schema.dart';

void main() {
  final vader = cards.sparkOfRebellion.find(10);

  // Pattern match to get the card's type.
  switch (vader) {
    case final BaseCard card:
      print('Base:    ${card.name}: ${card.location}');
    case final EntityCard card:
      print('Unit:    ${card.name}: ${card.title ?? '<No title>'}');
    case final EventCard card:
      print('Event:   ${card.name}');
    case final AttachmentCard card:
      print('Upgrade: ${card.name}');
  }
}
