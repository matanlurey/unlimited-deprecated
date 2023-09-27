part of '../state.dart';

/// A card that is in play.
@immutable
sealed class DeployedCard<T extends TargetCard> with ToDebugString {
  /// Details (i.e. the card) about the unit.
  final T card;

  /// Amount of damage this unit has taken.
  ///
  /// Always a non-negative integer, i.e. `>= 0`.
  final int damage;

  // ignore: public_member_api_docs
  DeployedCard({
    required this.card,
    required this.damage,
  }) {
    RangeError.checkValueInInterval(damage, 0, card.health, 'damage');
  }

  @mustBeOverridden
  @override
  int get hashCode;

  @mustBeOverridden
  @override
  bool operator ==(Object other);
}

/// A deployed [UnitCard].
final class DeployedUnit extends DeployedCard<UnitCard> {
  /// Whether the unit is exhausted.
  ///
  /// An exhaisted card can't exhaust again until it is readied.
  final bool exhausted;

  /// Upgrades attached to the unit.
  final List<UpgradeCard> upgrades;

  /// Creates a deployed unit with the given properties.
  ///
  /// {@macro errors_thrown_if_invalid}
  factory DeployedUnit({
    required UnitCard card,
    int damage = 0,
    bool exhausted = false,
    List<UpgradeCard> upgrades = const [],
  }) {
    return DeployedUnit._(
      card: card,
      damage: damage,
      exhausted: exhausted,
      upgrades: upgrades,
    );
  }

  DeployedUnit._({
    required super.card,
    required super.damage,
    required this.exhausted,
    required this.upgrades,
  });

  /// Whether the unit is ready.
  bool get ready => !exhausted;

  @override
  int get hashCode {
    return Object.hash(
      card,
      damage,
      exhausted,
      Object.hashAllUnordered(upgrades),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is DeployedUnit &&
        card == other.card &&
        damage == other.damage &&
        exhausted == other.exhausted &&
        const ListEquality<UpgradeCard>().equals(upgrades, other.upgrades);
  }

  @override
  String toDebugString() {
    // ignore: noop_primitive_operations
    return ''
        'DeployedUnit <$card: '
        '${exhausted ? 'exhausted' : ''}, '
        '$damage damage, ${upgrades.length} upgrades>';
  }
}

/// A deployed [BaseCard].
final class DeployedBase extends DeployedCard<BaseCard> {
  /// Creates a deployed base with the given properties.
  ///
  /// {@macro errors_thrown_if_invalid}
  factory DeployedBase({
    required BaseCard card,
    int damage = 0,
  }) {
    return DeployedBase._(
      card: card,
      damage: damage,
    );
  }

  DeployedBase._({
    required super.card,
    required super.damage,
  });

  @override
  int get hashCode => Object.hash(card, damage);

  @override
  bool operator ==(Object other) {
    if (other is! DeployedBase) {
      return false;
    }
    return card == other.card && damage == other.damage;
  }

  @override
  String toDebugString() {
    return 'DeployedBase <${card.name}: $damage damage>';
  }
}

/// A play area, representing the cards associated with and in play by a player.
@immutable
final class Area with ToDebugString {
  /// Cards converted to resources.
  final List<PlayableCard> totalResources;

  /// The number of resources available to the player.
  ///
  /// This is a number between `0` and `totalResources.length`, accounting for
  /// how many resources have been exhausted. For example, if the player has
  /// 5 resources, and has exhausted 3 of them, then this value is `2`.
  final int availableResources;

  /// The player's base.
  final DeployedBase base;

  /// The player's leader, regardless of whether it is deployed.
  final UnitCard leader;

  /// Cards in the player's hand.
  final List<PlayableCard> hand;

  /// Cards in the player's deck.
  final List<PlayableCard> deck;

  /// Cards in the player's discard pile.
  final List<PlayableCard> discard;

  /// Cards in play.
  final List<DeployedCard> inPlay;

  /// Creates an area with the given properties.
  ///
  /// If [availableResources] is not provided, it defaults to the length of
  /// [resources] (i.e. that no resources have been exhausted).
  ///
  /// {@macro errors_thrown_if_invalid}
  factory Area({
    required DeployedBase base,
    required UnitCard leader,
    List<PlayableCard> resources = const [],
    int? availableResources,
    List<PlayableCard> hand = const [],
    List<PlayableCard> deck = const [],
    List<PlayableCard> discard = const [],
    List<DeployedCard> inPlay = const [],
  }) {
    return Area._(
      totalResources: resources,
      availableResources: availableResources ?? resources.length,
      base: base,
      leader: leader,
      hand: hand,
      deck: deck,
      discard: discard,
      inPlay: inPlay,
    );
  }

  Area._({
    required this.totalResources,
    required this.availableResources,
    required this.base,
    required this.leader,
    required this.hand,
    required this.deck,
    required this.discard,
    required this.inPlay,
  }) {
    RangeError.checkValueInInterval(
      availableResources,
      0,
      totalResources.length,
      'availableResources',
    );
  }

  @override
  int get hashCode {
    return Object.hash(
      totalResources,
      availableResources,
      base,
      leader,
      Object.hashAll(deck),
      Object.hashAllUnordered(hand),
      Object.hashAllUnordered(discard),
      Object.hashAllUnordered(inPlay),
    );
  }

  @override
  bool operator ==(Object other) {
    if (other is! Area) {
      return false;
    }
    const list = ListEquality<void>();
    const unordered = UnorderedIterableEquality<void>();
    return totalResources == other.totalResources &&
        availableResources == other.availableResources &&
        base == other.base &&
        leader == other.leader &&
        list.equals(deck, other.deck) &&
        unordered.equals(hand, other.hand) &&
        unordered.equals(discard, other.discard) &&
        unordered.equals(inPlay, other.inPlay);
  }

  @override
  String toDebugString() {
    final buffer = StringBuffer();
    buffer.writeln('Area:');
    buffer.writeln('  Resources: $availableResources/$totalResources');
    buffer.writeln('  Base:      $base');
    buffer.writeln('  Leader:    ${leader.name}');
    buffer.writeln('  Hand:      ${hand.length} cards');
    buffer.writeln('  Deck:      ${deck.length} cards');
    buffer.writeln('  Discard:   ${discard.length} cards');
    buffer.writeln('  In Play:   ${inPlay.length} cards');
    return buffer.toString();
  }
}

/// Represents a game between two players.
@immutable
final class Game with ToDebugString {
  /// The first player's area.
  final Area player1;

  /// The second player's area.
  final Area player2;

  /// Creates a game with the given properties.
  ///
  /// {@macro errors_thrown_if_invalid}
  factory Game({
    required Area player1,
    required Area player2,
  }) {
    return Game._(
      player1: player1,
      player2: player2,
    );
  }

  Game._({
    required this.player1,
    required this.player2,
  });

  @override
  int get hashCode => Object.hash(player1, player2);

  @override
  bool operator ==(Object other) {
    if (other is! Game) {
      return false;
    }
    return player1 == other.player1 && player2 == other.player2;
  }

  @override
  String toDebugString() {
    final buffer = StringBuffer();
    buffer.writeln('Game:');
    buffer.writeln();
    buffer.writeln('==Player 1==');
    buffer.writeln(player1.toDebugString());
    buffer.writeln();
    buffer.writeln('==Player 2==');
    buffer.writeln(player2.toDebugString());
    return buffer.toString();
  }
}
