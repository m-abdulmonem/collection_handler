import 'package:collection_handler/collection_handler.dart';

import '../../domain/models/random_model.dart';
import 'dart:math';

extension CustomListExtensions on List {
  Collection get toCollection => Collection(this);

  dynamic get randomIndex {
    if (isNotEmpty) {
      return Random().nextInt(length);
    }
    return null;
  }

  dynamic get randomItem {
    if (isNotEmpty) {
      return this[Random().nextInt(length)];
    }
    return null;
  }

  RandomModel get random {
    int index = randomIndex;

    return RandomModel(index: index, item: this[index]);
  }

  List get keysFromWhere {
    List keys = [];
    for (Map key in this) {
      keys.add(key.keys.single);
    }
    return keys;
  }
}

extension Unique<E, Id> on List<E> {
  List<E> unique([Id Function(E element)? id, bool inplace = true]) {
    final ids = Set();
    var list = inplace ? this : List<E>.from(this);
    list.retainWhere((x) => ids.add(id != null ? id(x) : x as Id));
    return list;
  }
}
