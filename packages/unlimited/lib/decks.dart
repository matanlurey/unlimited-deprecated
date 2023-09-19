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
import 'package:unlimited/persist.dart';
import 'package:unlimited/schema.dart';

/// [sparkOfRebellion] starter deck with Luke Skywalker.
final lukeDeck = allCardSets.decodeDeck([
  // Luke Skywalker
  CardReference(CardSet.sparkOfRebellion, 005),
  // Administrator's Tower
  CardReference(CardSet.sparkOfRebellion, 029),
  // 2-1B Surgical Droid
  CardReference(CardSet.sparkOfRebellion, 059),
  // R2-D2
  CardReference(CardSet.sparkOfRebellion, 236, 3),
  // C-3PO
  CardReference(CardSet.sparkOfRebellion, 238, 3),
  // Rebel Pathfinder
  CardReference(CardSet.sparkOfRebellion, 239),
  // Alliance X-Wing
  CardReference(CardSet.sparkOfRebellion, 237, 3),
  // Restored ARC-170
  CardReference(CardSet.sparkOfRebellion, 044, 2),
  // Leia Organa
  CardReference(CardSet.sparkOfRebellion, 189, 3),
  // Rogue Operative
  CardReference(CardSet.sparkOfRebellion, 194),
  // Fleet Lieutenant
  CardReference(CardSet.sparkOfRebellion, 240, 3),
  // Wing Leader
  CardReference(CardSet.sparkOfRebellion, 241),
  // Yoda
  CardReference(CardSet.sparkOfRebellion, 045),
  // Cloud City Wing Guard
  CardReference(CardSet.sparkOfRebellion, 063),
  // System Patrol Craft
  CardReference(CardSet.sparkOfRebellion, 066),
  // Consular Security Force
  CardReference(CardSet.sparkOfRebellion, 046, 3),
  // Auzituck Liberator Gunship
  CardReference(CardSet.sparkOfRebellion, 195),
  // General Dodonna
  CardReference(CardSet.sparkOfRebellion, 242),
  // Snowspeeder
  CardReference(CardSet.sparkOfRebellion, 244),
  // Chewbacca
  CardReference(CardSet.sparkOfRebellion, 196),
  // Vigilant Honor Guards
  CardReference(CardSet.sparkOfRebellion, 048),
  // Obi-Wan Kenobi
  CardReference(CardSet.sparkOfRebellion, 049),
  // Han Solo
  CardReference(CardSet.sparkOfRebellion, 198),
  // Resilient
  CardReference(CardSet.sparkOfRebellion, 069),
  // Luke's Lightsaber
  CardReference(CardSet.sparkOfRebellion, 053, 3),
  // Shoot First
  CardReference(CardSet.sparkOfRebellion, 217),
  // Repair
  CardReference(CardSet.sparkOfRebellion, 074, 2),
  // Asteroid Sanctuary
  CardReference(CardSet.sparkOfRebellion, 218, 2),
  // Surprise Strike
  CardReference(CardSet.sparkOfRebellion, 220, 2),
  // Waylay
  CardReference(CardSet.sparkOfRebellion, 222, 2),
  // Vanquish
  CardReference(CardSet.sparkOfRebellion, 078, 3),
]);

/// [sparkOfRebellion] starter deck with Darth Vader.
final vaderDeck = allCardSets.decodeDeck([
  // Darth Vader
  CardReference(CardSet.sparkOfRebellion, 010),
  // Command Center
  CardReference(CardSet.sparkOfRebellion, 023),
  // TIE/LN Fighter
  CardReference(CardSet.sparkOfRebellion, 225, 2),
  // Death Star Stormtrooper
  CardReference(CardSet.sparkOfRebellion, 128, 3),
  // First Legion Snowtrooper
  CardReference(CardSet.sparkOfRebellion, 130, 2),
  // Admiral Ozzel
  CardReference(CardSet.sparkOfRebellion, 129),
  // Admiral Motti
  CardReference(CardSet.sparkOfRebellion, 226, 3),
  // Snowtrooper Lieutenant
  CardReference(CardSet.sparkOfRebellion, 227, 2),
  // Viper Probe Droid
  CardReference(CardSet.sparkOfRebellion, 228, 2),
  // Admiral Piett
  CardReference(CardSet.sparkOfRebellion, 079),
  // Superlaser Technician
  CardReference(CardSet.sparkOfRebellion, 083, 3),
  // Cell Block Guard
  CardReference(CardSet.sparkOfRebellion, 229, 3),
  // General Veers
  CardReference(CardSet.sparkOfRebellion, 230),
  // Grand Moff Tarkin
  CardReference(CardSet.sparkOfRebellion, 084, 3),
  // Imperial Interceptor
  CardReference(CardSet.sparkOfRebellion, 132, 3),
  // TIE Advanced
  CardReference(CardSet.sparkOfRebellion, 231),
  // Gladiator Star Destroyer
  CardReference(CardSet.sparkOfRebellion, 086),
  // Emperor Palpatine
  CardReference(CardSet.sparkOfRebellion, 135),
  // Blizzard Assault AT-AT
  CardReference(CardSet.sparkOfRebellion, 088),
  // Relentless
  CardReference(CardSet.sparkOfRebellion, 089),
  // Vader's Lightsaber
  CardReference(CardSet.sparkOfRebellion, 136, 3),
  // Recruit
  CardReference(CardSet.sparkOfRebellion, 123),
  // Force Choke
  CardReference(CardSet.sparkOfRebellion, 139),
  // Resupply
  CardReference(CardSet.sparkOfRebellion, 126),
  // Open Fire
  CardReference(CardSet.sparkOfRebellion, 172, 3),
  // I Am Your Father
  CardReference(CardSet.sparkOfRebellion, 233, 3),
  // Maximum Firepower
  CardReference(CardSet.sparkOfRebellion, 234),
  // Overwhelming Barrage
  CardReference(CardSet.sparkOfRebellion, 092),
]);
