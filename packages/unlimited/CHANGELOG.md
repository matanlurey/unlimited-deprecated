# CHANGELOG

This is an _early_ release of the `unlimited` package, and is likely to rapidly
change. We use [semantic versioning](https://dart.dev/tools/pub/versioning),
which in sort means that the version number is incremented to represent
breaking/non-breaking changes to the API.

_ℹ️ **NOTE**: While the package is in development, the version number is
`0.J.I`, where `J` is incremented when there is a breaking change to the API,
and `I` is incremented when there is a non-breaking change to the API. If bug
fixes are needed, an additional `+X` is appended to the version number._

## 0.2.0

### `cards.dart`

- Added `CardSetInventory`, which wraps a `CardSet` and provides a list (well,
  really a `Set`) of all the cards in the set (or at least as many that have
  been previewed so far).

- Changed `sparkOfRebellion` to be a `CardSetInventory` instead of a
  `Set<Card>` (which is still available as the `.cards` property).

### `schema.dart`

- Removed `CardType`, it was redundant with the `Card` class and subclasses.

### `state.dart`

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
