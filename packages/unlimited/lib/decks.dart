/// Inlines two starter decks, i.e. [lukeDeck] and [vaderDeck].
///
/// This library is a convenience for applications that want to provide some
/// pre-built decks without having to manage external resources or build their
/// own.
///
/// ## Example
///
/// ```dart
/// // It's recommended to import the library with a prefix.
/// import 'package:unlimited/decks.dart' as decks;
///
/// void main() {
///  final lukeDeck = decks.lukeDeck;
///  final vaderDeck = decks.vaderDeck;
///
///  // ...
/// }
library;

import 'package:unlimited/cards.dart';
import 'package:unlimited/schema.dart';
import 'package:unlimited/state.dart';

/// [sparkOfRebellion] starter deck with Luke Skywalker.
final lukeDeck = Deck(
  leader: sparkOfRebellion.find(5, 'Luke Skywalker'),
  base: sparkOfRebellion.find(29, "Administrator's Tower"),
  cards: [
    sparkOfRebellion.find(59, '2-1B Surgical Droid'),
    ...sparkOfRebellion.find<PlayableCard>(236, 'R2-D2').duplicate(3),
    ...sparkOfRebellion.find<PlayableCard>(238, 'C-3PO').duplicate(3),
    sparkOfRebellion.find(239, 'Rebel Pathfinder'),
    ...sparkOfRebellion.find<PlayableCard>(237, 'Alliance X-Wing').duplicate(3),
    ...sparkOfRebellion.find<PlayableCard>(44, 'Restored ARC-170').duplicate(2),
    ...sparkOfRebellion.find<PlayableCard>(189, 'Leia Organa').duplicate(3),
    sparkOfRebellion.find(194, 'Rogue Operative'),
    ...sparkOfRebellion
        .find<PlayableCard>(240, 'Fleet Lieutenant')
        .duplicate(3),
    sparkOfRebellion.find(241, 'Wing Leader'),
    sparkOfRebellion.find(45, 'Yoda'),
    sparkOfRebellion.find(63, 'Cloud City Wing Guard'),
    sparkOfRebellion.find(66, 'System Patrol Craft'),
    ...sparkOfRebellion
        .find<PlayableCard>(46, 'Consular Security Force')
        .duplicate(3),
    sparkOfRebellion.find(195, 'Auzituck Liberator Gunship'),
    sparkOfRebellion.find(242, 'General Dodonna'),
    sparkOfRebellion.find(244, 'Snowspeeder'),
    sparkOfRebellion.find(196, 'Chewbacca'),
    sparkOfRebellion.find(48, 'Vigilant Honor Guards'),
    sparkOfRebellion.find(49, 'Obi-Wan Kenobi'),
    sparkOfRebellion.find(198, 'Han Solo'),
    sparkOfRebellion.find(69, 'Resilient'),
    ...sparkOfRebellion
        .find<PlayableCard>(53, "Luke's Lightsaber")
        .duplicate(3),
    sparkOfRebellion.find(217, 'Shoot First'),
    ...sparkOfRebellion.find<PlayableCard>(74, 'Repair').duplicate(2),
    ...sparkOfRebellion
        .find<PlayableCard>(218, 'Asteroid Sanctuary')
        .duplicate(2),
    ...sparkOfRebellion.find<PlayableCard>(220, 'Surprise Strike').duplicate(2),
    ...sparkOfRebellion.find<PlayableCard>(222, 'Waylay').duplicate(2),
    ...sparkOfRebellion.find<PlayableCard>(78, 'Vanquish').duplicate(3),
  ],
);

/// [sparkOfRebellion] starter deck with Darth Vader.
final vaderDeck = Deck(
  leader: sparkOfRebellion.find(10, 'Darth Vader'),
  base: sparkOfRebellion.find(23, 'Command Center'),
  cards: [
    ...sparkOfRebellion.find<PlayableCard>(225, 'TIE/LN Fighter').duplicate(2),
    ...sparkOfRebellion
        .find<PlayableCard>(128, 'Death Star Stormtrooper')
        .duplicate(3),
    ...sparkOfRebellion
        .find<PlayableCard>(130, 'First Legion Snowtrooper')
        .duplicate(2),
    sparkOfRebellion.find(129, 'Admiral Ozzel'),
    ...sparkOfRebellion.find<PlayableCard>(226, 'Admiral Motti').duplicate(3),
    ...sparkOfRebellion
        .find<PlayableCard>(227, 'Snowtrooper Lieutenant')
        .duplicate(2),
    ...sparkOfRebellion
        .find<PlayableCard>(228, 'Viper Probe Droid')
        .duplicate(2),
    sparkOfRebellion.find(79, 'Admiral Piett'),
    ...sparkOfRebellion
        .find<PlayableCard>(83, 'Superlaser Technician')
        .duplicate(3),
    ...sparkOfRebellion
        .find<PlayableCard>(229, 'Cell Block Guard')
        .duplicate(3),
    sparkOfRebellion.find(230, 'General Veers'),
    ...sparkOfRebellion
        .find<PlayableCard>(84, 'Grand Moff Tarkin')
        .duplicate(3),
    ...sparkOfRebellion
        .find<PlayableCard>(132, 'Imperial Interceptor')
        .duplicate(3),
    sparkOfRebellion.find(231, 'TIE Advanced'),
    sparkOfRebellion.find(86, 'Gladiator Star Destroyer'),
    sparkOfRebellion.find(135, 'Emperor Palpatine'),
    sparkOfRebellion.find(88, 'Blizzard Assault AT-AT'),
    sparkOfRebellion.find(89, 'Relentless'),
    ...sparkOfRebellion
        .find<PlayableCard>(136, "Vader's Lightsaber")
        .duplicate(3),
    sparkOfRebellion.find(123, 'Recruit'),
    sparkOfRebellion.find(139, 'Force Choke'),
    sparkOfRebellion.find(126, 'Resupply'),
    ...sparkOfRebellion.find<PlayableCard>(172, 'Open Fire').duplicate(3),
    ...sparkOfRebellion
        .find<PlayableCard>(233, 'I Am Your Father')
        .duplicate(3),
    sparkOfRebellion.find(234, 'Maximum Firepower'),
    sparkOfRebellion.find(92, 'Overwhelming Barrage'),
  ],
);
