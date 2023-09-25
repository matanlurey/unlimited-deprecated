// After editing this file, run `dart tool/format_cards.dart` to update.
//
// In particular, the "// SOR ..." comments are automatically generated and some
// checks are performed to ensure that the file is valid (i.e. no duplicate card
// numbers, they are in order, etc).

import 'package:unlimited/src/schema.dart';
import 'package:unlimited/src/state.dart';

/// The Spark of Rebellion card set, as previewed so far by September 1, 2023.
final sparkOfRebellion = CardSetInventory(belongsTo: CardSet.sparkOfRebellion, {
  // SOR T01
  TokenCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 1,
    name: 'Experience',
    traits: const {Trait.learned},
    bonusPower: 1,
    bonusHealth: 1,
  ),
  // SOR T02
  TokenCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 2,
    name: 'Shield',
    traits: const {Trait.armor},
  ),
  // SOR 001
  LeaderCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 1,
    name: 'Director Krennic',
    title: 'Aspiring to Authority',
    aspects: const [Aspect.vigilance, Aspect.villainy],
    cost: 5,
    traits: const {Trait.imperial, Trait.official},
    power: 2,
    health: 7,
  ),
  // SOR 002: TBD
  // SOR 003
  LeaderCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 3,
    name: 'Chewbacca',
    title: 'Walking Carpet',
    aspects: const [Aspect.vigilance, Aspect.heroism],
    cost: 7,
    traits: const {Trait.underworld, Trait.wookiee},
    power: 2,
    health: 9,
  ),
  // SOR 004: TBD
  // SOR 005
  LeaderCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 5,
    name: 'Luke Skywalker',
    title: 'Faithful Friend',
    aspects: const [Aspect.vigilance, Aspect.heroism],
    cost: 6,
    traits: const {Trait.force, Trait.rebel},
    power: 4,
    health: 7,
  ),
  // SOR 006: TBD
  // SOR 007: TBD
  // SOR 008: TBD
  // SOR 009
  LeaderCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 9,
    name: 'Leia Organa',
    title: 'Alliance General',
    aspects: const [Aspect.command, Aspect.heroism],
    cost: 5,
    traits: const {Trait.rebel, Trait.official},
    power: 3,
    health: 6,
  ),
  // SOR 010
  LeaderCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 10,
    name: 'Darth Vader',
    title: 'Dark Lord of the Sith',
    aspects: const [Aspect.aggression, Aspect.villainy],
    cost: 7,
    traits: const {Trait.force, Trait.imperial, Trait.sith},
    power: 5,
    health: 8,
  ),
  // SOR 011: TBD
  // SOR 012: TBD
  // SOR 013: TBD
  // SOR 014: TBD
  // SOR 015: TBD
  // SOR 016: TBD
  // SOR 017: TBD
  // SOR 018: TBD
  // SOR 019: TBD
  // SOR 020: TBD
  // SOR 021
  BaseCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 21,
    name: 'Dagobah Swamp',
    location: 'Dagobah',
    aspects: const [Aspect.vigilance],
  ),
  // SOR 022
  BaseCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 22,
    name: 'Energy Conversion Lab',
    location: 'Eadu',
    aspects: const [Aspect.command],
  ),
  // SOR 023
  BaseCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 23,
    name: 'Command Center',
    location: 'Death Star',
    aspects: const [Aspect.command],
  ),
  // SOR 024: TBD
  // SOR 025: TBD
  // SOR 026
  BaseCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 26,
    name: 'Catacombs of Cadera',
    location: 'Jedha',
    aspects: const [Aspect.aggression],
  ),
  // SOR 027: TBD
  // SOR 028: TBD
  // SOR 029
  BaseCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 29,
    name: "Administrator's Tower",
    location: 'Cloud City',
    aspects: const [Aspect.cunning],
  ),
  // SOR 030: TBD
  // SOR 031: TBD
  // SOR 032: TBD
  // SOR 033: TBD
  // SOR 034: TBD
  // SOR 035: TBD
  // SOR 036: TBD
  // SOR 037: TBD
  // SOR 038: TBD
  // SOR 039: TBD
  // SOR 040: TBD
  // SOR 041: TBD
  // SOR 042: TBD
  // SOR 043: TBD
  // SOR 044
  UnitCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 44,
    arena: Arena.space,
    name: 'Restored ARC-170',
    aspects: const [Aspect.vigilance, Aspect.heroism],
    cost: 2,
    traits: const {Trait.vehicle, Trait.fighter},
    power: 2,
    health: 3,
  ),
  // SOR 045
  UnitCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 45,
    name: 'Yoda',
    aspects: const [Aspect.vigilance, Aspect.heroism],
    cost: 3,
    traits: const {Trait.force, Trait.jedi},
    power: 2,
    health: 4,
  ),
  // SOR 046
  UnitCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 46,
    name: 'Consular Security Force',
    aspects: const [Aspect.vigilance, Aspect.heroism],
    cost: 4,
    traits: const {Trait.rebel, Trait.trooper},
    power: 3,
    health: 7,
  ),
  // SOR 047: TBD
  // SOR 048
  UnitCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 48,
    name: 'Vigilant Honor Guards',
    aspects: const [Aspect.vigilance, Aspect.heroism],
    cost: 5,
    traits: const {Trait.rebel},
    power: 4,
    health: 6,
  ),
  // SOR 049: TBD
  // SOR 050: TBD
  // SOR 051: TBD
  // SOR 052: TBD
  UnitCard.unique(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 49,
    name: 'Obi-Wan Kenobi',
    title: 'Following Fate',
    aspects: const [Aspect.vigilance, Aspect.heroism],
    cost: 6,
    traits: const {Trait.force, Trait.jedi},
    power: 4,
    health: 6,
  ),
  // SOR 053
  UpgradeCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 53,
    name: "Luke's Lightsaber",
    unique: true,
    aspects: const [Aspect.vigilance, Aspect.heroism],
    cost: 2,
    traits: const {Trait.item, Trait.weapon, Trait.lightsaber},
    bonusHealth: 3,
    bonusPower: 1,
  ),
  // SOR 054: TBD
  // SOR 055: TBD
  // SOR 056: TBD
  // SOR 057: TBD
  // SOR 058: TBD
  // SOR 059
  UnitCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 59,
    name: '2-1B Surgical Droid',
    aspects: const [Aspect.vigilance],
    cost: 1,
    traits: const {Trait.droid},
    power: 1,
    health: 3,
  ),
  // SOR 060
  UnitCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 60,
    name: 'Distant Patroller',
    arena: Arena.space,
    aspects: const [Aspect.vigilance],
    cost: 2,
    traits: const {Trait.fringe, Trait.vehicle, Trait.fighter},
    power: 2,
    health: 1,
  ),
  // SOR 061: TBD
  // SOR 062: TBD
  // SOR 063
  UnitCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 63,
    name: 'Cloud City Wing Guard',
    aspects: const [Aspect.vigilance],
    cost: 3,
    traits: const {Trait.fringe, Trait.trooper},
    power: 2,
    health: 4,
  ),
  // SOR 064: TBD
  // SOR 065: TBD
  // SOR 066
  UnitCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 66,
    arena: Arena.space,
    name: 'System Patrol Craft',
    aspects: const [Aspect.vigilance],
    cost: 4,
    traits: const {Trait.vehicle, Trait.fighter},
    power: 3,
    health: 4,
  ),
  // SOR 067: TBD
  // SOR 068: TBD
  // SOR 069
  UpgradeCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 69,
    name: 'Resilient',
    aspects: const [Aspect.vigilance],
    cost: 1,
    traits: const {Trait.innate},
    bonusPower: 3,
  ),
  // SOR 070: TBD
  // SOR 071: TBD
  // SOR 072
  UpgradeCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 72,
    name: 'Entrenched',
    aspects: const [Aspect.vigilance],
    cost: 2,
    traits: const {Trait.condition},
    bonusPower: 3,
    bonusHealth: 3,
  ),
  // SOR 073: TBD
  // SOR 074
  EventCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 74,
    name: 'Repair',
    aspects: const [Aspect.vigilance],
    cost: 1,
    traits: const {Trait.supply},
  ),
  // SOR 075: TBD
  // SOR 076: TBD
  // SOR 077: TBD
  // SOR 078
  EventCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 78,
    name: 'Vanquish',
    aspects: const [Aspect.vigilance],
    cost: 5,
    traits: const {Trait.tactic},
  ),
  // SOR 079: TBD
  // SOR 080: TBD
  // SOR 081: TBD
  UnitCard.unique(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 79,
    name: 'Admiral Piett',
    title: 'Capitan of the Executor',
    aspects: const [Aspect.command, Aspect.villainy],
    cost: 2,
    traits: const {Trait.imperial, Trait.official},
    power: 1,
    health: 4,
  ),
  // SOR 082
  UnitCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 82,
    name: "Emperor's Royal Guard",
    aspects: const [Aspect.command, Aspect.villainy],
    cost: 3,
    traits: const {Trait.imperial},
    power: 3,
    health: 4,
  ),
  // SOR 083
  UnitCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 83,
    name: 'Superlaser Technician',
    aspects: const [Aspect.command, Aspect.villainy],
    cost: 3,
    traits: const {Trait.imperial},
    power: 2,
    health: 1,
  ),
  // SOR 084: TBD
  // SOR 085: TBD
  UnitCard.unique(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 84,
    name: 'Grand Moff Tarkin',
    title: 'Death Star Overseer',
    aspects: const [Aspect.command, Aspect.villainy],
    cost: 4,
    traits: const {Trait.imperial, Trait.official},
    power: 2,
    health: 3,
  ),
  // SOR 086
  UnitCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 86,
    name: 'Gladiator Star Destroyer',
    arena: Arena.space,
    aspects: const [Aspect.command, Aspect.villainy],
    cost: 6,
    traits: const {Trait.imperial, Trait.vehicle, Trait.capitalShip},
    power: 5,
    health: 6,
  ),
  // SOR 087: TBD
  // SOR 088
  UnitCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 88,
    name: 'Blizzard Assault AT-AT',
    aspects: const [Aspect.command, Aspect.villainy],
    cost: 8,
    traits: const {Trait.imperial, Trait.vehicle, Trait.walker},
    power: 9,
    health: 9,
  ),
  // SOR 089: TBD
  // SOR 090: TBD
  // SOR 091: TBD
  UnitCard.unique(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 89,
    name: 'Relentless',
    title: "Konstantine's Folly",
    aspects: const [Aspect.command, Aspect.villainy],
    cost: 9,
    traits: const {Trait.imperial, Trait.vehicle, Trait.capitalShip},
    power: 8,
    health: 8,
  ),
  // SOR 092
  EventCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 92,
    name: 'Overwhelming Barrage',
    aspects: const [Aspect.command, Aspect.villainy],
    cost: 5,
    traits: const {Trait.tactic},
  ),
  // SOR 093: TBD
  // SOR 094: TBD
  // SOR 095: TBD
  // SOR 096: TBD
  // SOR 097: TBD
  // SOR 098: TBD
  // SOR 099: TBD
  // SOR 100: TBD
  // SOR 101: TBD
  // SOR 102: TBD
  // SOR 103: TBD
  // SOR 104: TBD
  // SOR 105: TBD
  // SOR 106: TBD
  UnitCard.unique(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 97,
    name: 'Admiral Ackbar',
    title: 'Brilliant Strategist',
    aspects: const [Aspect.command, Aspect.heroism],
    cost: 3,
    traits: const {Trait.rebel, Trait.official},
    power: 1,
    health: 4,
  ),
  UnitCard.unique(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 102,
    name: 'Home One',
    title: 'Alliance Flagship',
    arena: Arena.space,
    aspects: const [Aspect.command, Aspect.heroism],
    cost: 8,
    traits: const {Trait.rebel, Trait.vehicle, Trait.capitalShip},
    power: 7,
    health: 7,
  ),
  // SOR 107
  EventCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 107,
    name: 'Command',
    aspects: const [Aspect.command, Aspect.command],
    cost: 4,
    traits: const {Trait.innate},
  ),
  // SOR 108: TBD
  // SOR 109: TBD
  // SOR 110: TBD
  // SOR 111: TBD
  // SOR 112: TBD
  // SOR 113: TBD
  // SOR 114: TBD
  // SOR 115: TBD
  // SOR 116: TBD
  // SOR 117: TBD
  // SOR 118: TBD
  // SOR 119: TBD
  // SOR 120: TBD
  UnitCard.unique(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 109,
    name: 'Colonel Yularen',
    title: 'ISB Director',
    aspects: const [Aspect.command],
    cost: 2,
    traits: const {Trait.imperial, Trait.official},
    power: 2,
    health: 3,
  ),
  UnitCard.unique(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 115,
    name: 'Agent Kallus',
    title: 'Seeking the Rebels',
    aspects: const [Aspect.command],
    cost: 5,
    traits: const {Trait.imperial, Trait.trooper},
    power: 4,
    health: 4,
  ),
  // SOR 121
  UpgradeCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 121,
    name: 'Hardpoint Heavy Blaster',
    aspects: const [Aspect.command],
    cost: 2,
    traits: const {Trait.modification, Trait.weapon},
    bonusPower: 2,
    bonusHealth: 2,
  ),
  // SOR 122: TBD
  // SOR 123
  EventCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 123,
    name: 'Recruit',
    aspects: const [Aspect.command],
    cost: 1,
    traits: const {Trait.supply},
  ),
  // SOR 124: TBD
  // SOR 125
  EventCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 125,
    name: 'Prepare for Takeoff',
    aspects: const [Aspect.command],
    cost: 2,
    traits: const {Trait.plan},
  ),
  // SOR 126
  EventCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 126,
    name: 'Resupply',
    aspects: const [Aspect.command],
    cost: 3,
    traits: const {Trait.supply},
  ),
  // SOR 127: TBD
  // SOR 128
  UnitCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 128,
    name: 'Death Star Stormtrooper',
    aspects: const [Aspect.aggression, Aspect.villainy],
    cost: 1,
    traits: const {Trait.imperial, Trait.trooper},
    power: 3,
    health: 1,
  ),
  // SOR 129: TBD
  UnitCard.unique(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 129,
    name: 'Admiral Ozzel',
    title: 'Overconfident',
    aspects: const [Aspect.aggression, Aspect.villainy],
    cost: 2,
    traits: const {Trait.imperial, Trait.official},
    power: 2,
    health: 3,
  ),
  // SOR 130
  UnitCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 130,
    name: 'First Legion Snowtrooper',
    aspects: const [Aspect.aggression, Aspect.villainy],
    cost: 2,
    traits: const {Trait.imperial, Trait.trooper},
    power: 2,
    health: 3,
  ),
  // SOR 131: TBD
  // SOR 132
  UnitCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 132,
    arena: Arena.space,
    name: 'Imperial Interceptor',
    aspects: const [Aspect.aggression, Aspect.villainy],
    cost: 4,
    traits: const {Trait.imperial, Trait.vehicle, Trait.fighter},
    power: 3,
    health: 2,
  ),
  // SOR 133: TBD
  // SOR 134: TBD
  // SOR 135: TBD
  UnitCard.unique(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 135,
    name: 'Emperor Palpatine',
    title: 'Master of the Dark Side',
    aspects: const [Aspect.aggression, Aspect.villainy],
    cost: 8,
    traits: const {Trait.imperial, Trait.sith, Trait.official},
    power: 6,
    health: 6,
  ),
  // SOR 136
  UpgradeCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 136,
    name: "Vader's Lightsaber",
    aspects: const [Aspect.aggression, Aspect.villainy],
    cost: 2,
    traits: const {Trait.item, Trait.weapon, Trait.lightsaber},
    bonusPower: 3,
    bonusHealth: 1,
  ),
  // SOR 137: TBD
  // SOR 138: TBD
  // SOR 139
  EventCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 139,
    name: 'Force Choke',
    aspects: const [Aspect.aggression, Aspect.villainy],
    cost: 2,
    traits: const {Trait.force},
  ),
  // SOR 140: TBD
  // SOR 141: TBD
  // SOR 142: TBD
  // SOR 143: TBD
  // SOR 144: TBD
  // SOR 145: TBD
  // SOR 146: TBD
  // SOR 147: TBD
  // SOR 148: TBD
  // SOR 149: TBD
  // SOR 150: TBD
  // SOR 151: TBD
  // SOR 152: TBD
  // SOR 153: TBD
  // SOR 154: TBD
  // SOR 155: TBD
  // SOR 156: TBD
  // SOR 157: TBD
  // SOR 158: TBD
  // SOR 159: TBD
  // SOR 160: TBD
  // SOR 161: TBD
  // SOR 162: TBD
  // SOR 163: TBD
  // SOR 164: TBD
  // SOR 165: TBD
  // SOR 166: TBD
  // SOR 167: TBD
  // SOR 168: TBD
  // SOR 169: TBD
  // SOR 170: TBD
  // SOR 171: TBD
  // SOR 172
  EventCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 172,
    name: 'Open Fire',
    aspects: const [Aspect.aggression],
    cost: 3,
    traits: const {Trait.tactic},
  ),
  // SOR 173: TBD
  // SOR 174: TBD
  // SOR 175: TBD
  // SOR 176: TBD
  // SOR 177: TBD
  // SOR 178: TBD
  // SOR 179: TBD
  // SOR 180: TBD
  // SOR 181: TBD
  // SOR 182: TBD
  // SOR 183: TBD
  // SOR 184: TBD
  // SOR 185: TBD
  // SOR 186: TBD
  // SOR 187: TBD
  // SOR 188: TBD
  // SOR 189: TBD
  // SOR 190: TBD
  // SOR 191: TBD
  // SOR 192: TBD
  // SOR 193: TBD
  UnitCard.unique(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 179,
    name: 'Boba Fett',
    title: 'Disintegrator',
    aspects: const [Aspect.cunning, Aspect.villainy],
    cost: 3,
    traits: const {Trait.underworld, Trait.bountyHunter},
    power: 3,
    health: 5,
  ),
  UnitCard.unique(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 184,
    name: "Fett's Firespray",
    title: 'Pursuing the Bounty',
    aspects: const [Aspect.cunning, Aspect.villainy],
    cost: 6,
    traits: const {Trait.underworld, Trait.vehicle, Trait.transport},
    power: 5,
    health: 6,
  ),
  UnitCard.unique(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 189,
    name: 'Leia Organa',
    title: 'Defiant Princess',
    aspects: const [Aspect.cunning, Aspect.heroism],
    cost: 2,
    traits: const {Trait.rebel, Trait.official},
    power: 2,
    health: 2,
  ),
  // SOR 194
  UnitCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 194,
    name: 'Rogue Operative',
    aspects: const [Aspect.cunning, Aspect.heroism],
    cost: 3,
    traits: const {Trait.rebel, Trait.trooper},
    power: 2,
    health: 4,
  ),
  // SOR 195
  UnitCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 195,
    arena: Arena.space,
    name: 'Auzituck Liberator Gunship',
    aspects: const [Aspect.cunning, Aspect.heroism],
    cost: 4,
    traits: const {Trait.vehicle, Trait.fighter},
    power: 3,
    health: 4,
  ),
  // SOR 196: TBD
  // SOR 197: TBD
  // SOR 198: TBD
  // SOR 199: TBD
  // SOR 200: TBD
  // SOR 201: TBD
  // SOR 202: TBD
  // SOR 203: TBD
  // SOR 204: TBD
  // SOR 205: TBD
  // SOR 206: TBD
  // SOR 207: TBD
  // SOR 208: TBD
  // SOR 209: TBD
  // SOR 210: TBD
  // SOR 211: TBD
  // SOR 212: TBD
  // SOR 213: TBD
  // SOR 214: TBD
  // SOR 215: TBD
  // SOR 216: TBD
  UnitCard.unique(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 196,
    name: 'Chewbacca',
    title: 'Loyal Companion',
    aspects: const [Aspect.cunning, Aspect.heroism],
    cost: 5,
    traits: const {Trait.underworld, Trait.wookiee},
    power: 3,
    health: 6,
  ),
  UnitCard.unique(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 198,
    name: 'Han Solo',
    title: 'Reluctant Hero',
    aspects: const [Aspect.cunning, Aspect.heroism],
    cost: 7,
    traits: const {Trait.underworld},
    power: 6,
    health: 6,
  ),
  // SOR 217
  EventCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 217,
    name: 'Shoot First',
    aspects: const [Aspect.cunning],
    cost: 1,
    traits: const {Trait.trick},
  ),
  // SOR 218
  EventCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 218,
    name: 'Asteroid Sanctuary',
    aspects: const [Aspect.cunning],
    cost: 2,
    traits: const {Trait.trick},
  ),
  // SOR 219: TBD
  // SOR 220
  EventCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 220,
    name: 'Surprise Strike',
    aspects: const [Aspect.cunning],
    cost: 2,
    traits: const {Trait.tactic},
  ),
  // SOR 221: TBD
  // SOR 222
  EventCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 222,
    name: 'Waylay',
    aspects: const [Aspect.cunning],
    cost: 3,
    traits: const {Trait.trick},
  ),
  // SOR 223: TBD
  // SOR 224: TBD
  // SOR 225
  UnitCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 225,
    arena: Arena.space,
    name: 'TIE/LN Fighter',
    aspects: const [Aspect.villainy],
    cost: 1,
    traits: const {Trait.imperial, Trait.vehicle, Trait.fighter},
    power: 2,
    health: 1,
  ),
  // SOR 226: TBD
  UnitCard.unique(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 226,
    name: 'Admiral Motti',
    title: 'Brazen and Scornful',
    aspects: const [Aspect.villainy],
    cost: 2,
    traits: const {Trait.imperial, Trait.official},
    power: 1,
    health: 1,
  ),
  // SOR 227
  UnitCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 227,
    name: 'Snowtrooper Lieutenant',
    aspects: const [Aspect.villainy],
    cost: 2,
    traits: const {Trait.imperial, Trait.trooper},
    power: 2,
    health: 2,
  ),
  // SOR 228
  UnitCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 228,
    name: 'Viper Probe Droid',
    aspects: const [Aspect.villainy],
    cost: 2,
    traits: const {Trait.imperial, Trait.droid},
    power: 3,
    health: 2,
  ),
  // SOR 229
  UnitCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 229,
    name: 'Cell Block Guard',
    aspects: const [Aspect.villainy],
    cost: 3,
    traits: const {Trait.imperial, Trait.trooper},
    power: 3,
    health: 3,
  ),
  // SOR 230: TBD
  UnitCard.unique(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 230,
    name: 'General Veers',
    title: 'Blizzard Force Commander',
    aspects: const [Aspect.villainy],
    cost: 3,
    traits: const {Trait.imperial, Trait.official},
    power: 3,
    health: 3,
  ),
  // SOR 231
  UnitCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 231,
    arena: Arena.space,
    name: 'TIE Advanced',
    aspects: const [Aspect.villainy],
    cost: 4,
    traits: const {Trait.imperial, Trait.vehicle, Trait.fighter},
    power: 3,
    health: 2,
  ),
  // SOR 232
  UnitCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 232,
    name: 'AT-ST',
    aspects: const [Aspect.villainy],
    cost: 6,
    traits: const {Trait.imperial, Trait.vehicle, Trait.walker},
    power: 6,
    health: 7,
  ),
  // SOR 233
  EventCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 233,
    name: 'I Am Your Father',
    aspects: const [Aspect.villainy],
    cost: 3,
    traits: const {Trait.gambit},
  ),
  // SOR 234
  EventCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 234,
    name: 'Maximum Firepower',
    aspects: const [Aspect.villainy],
    cost: 4,
    traits: const {Trait.imperial, Trait.tactic},
  ),
  // SOR 235
  EventCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 235,
    name: 'Galactic Ambition',
    aspects: const [Aspect.villainy],
    cost: 7,
    traits: const {Trait.innate},
  ),
  // SOR 236: TBD
  UnitCard.unique(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 236,
    name: 'R2-D2',
    title: 'Ignoring Protocol',
    aspects: const [Aspect.heroism],
    cost: 1,
    traits: const {Trait.rebel, Trait.droid},
    power: 1,
    health: 4,
  ),
  // SOR 237
  UnitCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 237,
    arena: Arena.space,
    name: 'Alliance X-Wing',
    aspects: const [Aspect.heroism],
    cost: 2,
    traits: const {Trait.rebel, Trait.vehicle, Trait.fighter},
    power: 2,
    health: 3,
  ),
  // SOR 238: TBD
  UnitCard.unique(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 238,
    name: 'C-3PO',
    title: 'Protocol Droid',
    aspects: const [Aspect.heroism],
    cost: 2,
    traits: const {Trait.rebel, Trait.droid},
    power: 1,
    health: 4,
  ),
  // SOR 239
  UnitCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 239,
    name: 'Rebel Pathfinder',
    aspects: const [Aspect.heroism],
    cost: 2,
    traits: const {Trait.rebel, Trait.trooper},
    power: 2,
    health: 3,
  ),
  // SOR 240
  UnitCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 240,
    name: 'Fleet Lieutenant',
    aspects: const [Aspect.heroism],
    cost: 3,
    traits: const {Trait.rebel, Trait.trooper},
    power: 3,
    health: 3,
  ),
  // SOR 241
  UnitCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 241,
    arena: Arena.space,
    name: 'Wing Leader',
    aspects: const [Aspect.heroism],
    cost: 3,
    traits: const {Trait.rebel, Trait.vehicle, Trait.fighter},
    power: 2,
    health: 1,
  ),
  // SOR 242: TBD
  // SOR 243: TBD
  UnitCard.unique(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 242,
    name: 'General Dodonna',
    title: 'Massassi Group Commander',
    aspects: const [Aspect.heroism],
    cost: 4,
    traits: const {Trait.rebel, Trait.official},
    power: 4,
    health: 4,
  ),
  // SOR 244
  UnitCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 244,
    name: 'Snowspeeder',
    aspects: const [Aspect.heroism],
    cost: 5,
    traits: const {Trait.rebel, Trait.vehicle, Trait.speeder},
    power: 3,
    health: 6,
  ),
  // SOR 245: TBD
  // SOR 246
  EventCard(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 246,
    name: "You're My Only Hope",
    aspects: const [Aspect.heroism],
    cost: 3,
    traits: const {Trait.gambit},
  ),
  // SOR 247: TBD
  // SOR 248: TBD
  // SOR 249: TBD
  // SOR 250: TBD
  // SOR 251: TBD
  // SOR 252: TBD
});
