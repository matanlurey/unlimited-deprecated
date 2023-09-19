# CHANGELOG

This is an _early_ release of the `unlimited` package, and is likely to rapidly
change. We use [semantic versioning](https://dart.dev/tools/pub/versioning),
which in sort means that the version number is incremented to represent
breaking/non-breaking changes to the API.

_ℹ️ **NOTE**: While the package is in development, the version number is
`0.J.I`, where `J` is incremented when there is a breaking change to the API,
and `I` is incremented when there is a non-breaking change to the API. If bug
fixes are needed, an additional `+X` is appended to the version number._

## Unreleased

**`cards.dart`**:

- Added additional cards.

**`schema.dart`**:

- Changed `Card.aspects` to be a `List<Aspect>` instead of a `Set<Aspect>`.

  There is at least one card that has multiple of the same aspect.

- Renamed `AttachmentCard.bonusHp` to `bonusHealth`, for consistency.

- Added a number of missing `Trait`s.

## 0.3.0

**`cards.dart`**:

- Added a top-level `allCardSets`, a `Collection` of all cards in the game.

  > **ℹ️ NOTE**: This is just `sparkOfRebellion` for now.

- Moved `CardSetInventory` to `state.dart`, since it's a representation of
  state.

- Fixed a number of typos in the cards database, and added additional cards.

**`decks.dart`**:

- A new library, that inlines two starter decks as a sample for apps/libraries:

  - `lukeDeck` is a deck that focuses on Luke Skywalker from Spark of Rebellion.
  - `vaderDeck` is a deck that focuses on Darth Vader from Spark of Rebellion.

**`persist.dart`**:

- A new library, that provides conveniences for persisting game/deck state.

  For example, `DeckDecoder` provides `decodeDeck` to convert a list of cards:

  ```dart
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
    // ... snip ... see `decks.dart` for the full list.
  ]);
  ```

**`schema.dart`**:

- `Card.isToken` was removed. There is now a base type called `AttachmentCard`,
  which is used for cards that are attached to other cards (such as
  `UpgradeCard`, but also `TokenCard`). All references to `isToken` were
  removed.

  ```diff
  -UpgradeCard.token(
  +TokenCard(
    /* ... */
  )
  ```

- `Card.hp` was renamed `Card.health`.

  Every card that has health now inherits from `TargetCard`. In practice,
  this is `UnitCard`, `LeaderCard`, and `BaseCard`.

- `UnitCard.isLeader` was removed. There is now a base type called `EntityCard`,
  which is used for cards that are entities (such as `UnitCard`, but also
  `LeaderCard`). All references to `isLeader` were removed.

  ```diff
  -UnitCard.leader(
  +LeaderCard(
    /* ... */
  )
  ```

- `UnitCard.unique` was added, instead of just having an optional `title`.

  ```diff
  -UnitCard.leader(
  +UnitCard(
    /* ... */
    title: 'Dark Lord of the Sith',
  )
  ```

- Added `Trait.capitalShip`.

**`state.dart`**:

- Added `extension CardDuplicator<T extends Card> on T`, which provides the
  method `duplicate` to conveniently create multiple copies of a card.

  ```dart
  import 'package:unlimited/schema.dart';
  import 'package:unlimited/state.dart';

  void example(Card card) {
    // Will print the card 3 times.
    for (final copy in card.duplicate(3)) {
      print(copy);
    }
  }
  ```

- Added `DeployedCard`, that tracks a card in play, including state such as
  damage:

  ```dart
  import 'package:unlimited/schema.dart';
  import 'package:unlimited/state.dart';

  void example(TargetCard card) {
    DeployedCard(card, damage: 1);
  }
  ```

  There is also `DeployedUnit`, which includes upgrades, and `DeployedBase`.

- Added `Area`, which represents all of the cards associated to a player:

  - `totalResources`, `availableResources`
  - `base`
  - `leader`
  - `hand`
  - `deck`
  - `discard`
  - `arena`

- `CardSetInventory` now optionally takes `belongsTo`, or infers it:

  ```dart
  // Both of these calls are identical.

  CardSetInventory(
    belongsTo: CardSet.sparkOfRebellion,
    { /* ... cards ... */ }
  );

  CardSetInventory(
    { /* ... cards that all originate from sparkOfRebellion ... */ }
  );
  ```

- Fixed a bug where `Deck` could allow invalid cards, and required too many.

## 0.2.0

**`cards.dart`**:

- Added `CardSetInventory`, which wraps a `CardSet` and provides a list (well,
  really a `Set`) of all the cards in the set (or at least as many that have
  been previewed so far).

- Changed `sparkOfRebellion` to be a `CardSetInventory` instead of a
  `Set<Card>` (which is still available as the `.cards` property).

**`schema.dart`**:

- Removed `CardType`, it was redundant with the `Card` class and subclasses.

**`state.dart`**:

Added an additional library, `pacakge:unlimited/state.dart`, which contains representations of game state or card collections. For example, creating a deck:

```dart
import 'package:unlimited/state.dart';

void createDeck(BaseCard base, UnitCard leader, List<Card> cards) {
  final deck = Deck(
    base: base
    leader: leader
    cards: [
      ...cards,
    ],
  );
}
```

## 0.0.1+1

_No changes, update is merely for pub.dev._

## 0.0.1

**Initial release. Woohoo!**

Two libraries are available:

- `package:unlimited/schema.dart` defines the schema for the cards in the game.

  The game's card model is defined as a set of Dart classes, such as:

  ```dart
  // SOR 010.
  UnitCard.leader(
    cardSet: CardSet.sparkOfRebellion,
    orderInSet: 10,
    name: 'DarthVader',
    title: 'Dark Lord of the Sith',
    aspects: const {Aspect.aggression, Aspect.villainy},
    cost: 7,
    traits: const {Trait.force, Trait.imperial, Trait.sith},
    power: 5,
    hp: 8,
  );
  ```

  Some key classes are:

  - `Card`; either a `BaseCard`, `EventCard`, `UnitCard`, or `UpgradeCard`.
  - `CardSet`, which defines each set of cards in the game.
  - Other classes such as `Aspect`, `Trait`, and more.

- `package:unlimited/cards.dart` contains an inlined copy of the cards database.

  While applications are likely to want to fetch/update the cards database from
  an external datasource (i.e. as JSON or similar), this library is provided as
  a convenience, as well to validate that (a) the schema is correct and (b) the
  schema contains all the information needed to encapsulate the cards database.

  ```dart
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
        print('Base:  ${card.name}: ${card.location}');
      case final UnitCard card:
        print('Unit:    ${card.name}: ${card.title ?? '<No title>'}');
      case final EventCard card:
        print('Event: ${card.name}');
      case final UpgradeCard card:
        print('Upgrade: ${card.name}');
    }
  }
  ```

## 0.0.0

Initial empty package as a placeholder.
