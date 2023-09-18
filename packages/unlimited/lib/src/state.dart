import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import 'package:unlimited/schema.dart';
import 'package:unlimited/src/internal.dart';

part 'state/area.dart';
part 'state/deck.dart';
part 'state/collection.dart';
part 'state/inventory.dart';

/// Provides the [duplicate] method for cards.
extension CardDuplicator<T extends Card> on T {
  /// Returns an iterable that yields this card [count] times.
  Iterable<T> duplicate(int count) sync* {
    for (var i = 0; i < count; i++) {
      yield this;
    }
  }
}
