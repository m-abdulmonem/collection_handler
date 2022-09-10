library collection_handler;

import 'core/extensions/custom_list_extensions.dart';

class Collection {
  List<dynamic>? list = [];
  final List<dynamic> _result = [];

  Collection([this.list]);

  List<dynamic> _data(data) => data != null ? list = data : list;

  int randomIndex([List? list]) {
    list = _data(list);

    return list.randomIndex;
  }

  dynamic random([bool isIndex = false]) {
    if (isIndex) {
      return _result.randomIndex;
    }

    return _result.randomItem;
  }

  dynamic randomItem({List? data}) {
    list = _data(data);

    return list?.randomItem;
  }

  Collection set(dynamic key, dynamic value, [List<dynamic>? data]) {
    list = _data(data);

    if (toMap.containsKey(key)) {
      _result[key] = value;
    }

    return this;
  }

  Collection put(dynamic key, dynamic value, [List<dynamic>? data]) {
    list = _data(data);

    _result.add({key: value});

    return this;
  }

  Collection add(dynamic value, [List<dynamic>? data]) {
    list = _data(data);

    list?.add(value);

    return this;
  }

  Collection whereIn(dynamic keys, [List<dynamic>? data]) {
    list = _data(data);
    if (keys is List) {
      for (var key in keys) {
        _result.add(where(key));
      }
    } else {
      _result.add(where(keys));
    }
    return this;
  }

  Collection whereNotIn(dynamic keys, [List<dynamic>? data]) {
    list = _data(data);
    if (keys is List) {
      removeWhereIn(keys);
    } else {
      remove(keys);
    }

    return this;
  }

  Collection getItem(dynamic key, [List<dynamic>? data]) {
    list = _data(data);

    where(key);

    return this;
  }

  dynamic getIndex(dynamic search, [List<dynamic>? data]) {
    list = _data(data);

    return where(search).get[0];
  }

  Collection where(dynamic search, [List<dynamic>? data]) {
    list = _data(data);

    _result.addAll(_where(search));

    return this;
  }

  List _where(dynamic search, [List<dynamic>? data]) {
    list = _data(data);
    List values = [];

    if ((search is int) && search <= list!.length) {
      values.add({search: list?[search]});
    }

    for (int i = 0; i < list!.length; i++) {
      if (list?[i] is Map) {
        Map map = list?[i];

        if (map.containsKey(search)) {
          values.add({
            i: {search: map[search]}
          });
        }

        if (map.containsValue(search)) {
          var key = map.keys.firstWhere((element) => map[element] == search);
          values.add({
            i: {key: map[key]}
          });
        }
      }

      if (list?[i] == search) {
        values.add({i: list?[i]});
      }
    }

    return values;
  }

  Iterable? whereMap(Function(dynamic) callback, [List<dynamic>? data]) {
    list = _data(data);

    return list?.map(callback);
  }

  Collection remove(dynamic index) {
    List foundKeysMoreThanOne = _where(index).keysFromWhere;

    if (foundKeysMoreThanOne.length > 1) {
      removeWhereIn(foundKeysMoreThanOne);
    }

    if (_result.isEmpty) {
      _result.addAll(list!);
      _remove(index);
    } else {
      _remove(index);
    }

    return this;
  }

  void _remove(index) {
    if (index is int && _result.asMap().containsKey(index)) {
      _result.removeAt(index);
    } else {
      _result.remove(index);
    }
  }

  Collection removeWhereNotIn(List<dynamic> keys) {
    _result.addAll(list!);
    List values = [];

    for (int key in keys) {
      if (_result.asMap().containsKey(key)) values.add(_result[key]);
    }
    _result.clear();
    _result.addAll(values);
    return this;
  }

  Collection removeWhereIn(List<dynamic> keys) {
    _result.addAll(list!);

    List values = [];

    for (var key in keys) {
      if (_result.asMap().containsKey(key)) {
        values.add(_result[key]);
      }
    }

    for (var value in values) {
      _result.remove(value);
    }

    return this;
  }


  List<dynamic> splitKeys(Pattern pattern){
    dynamic map(dynamic key) {
      List newList = [];
      if (key is Map){
        key.forEach((k,v) => newList.add(k.split(pattern)));
      }else{

        newList.add(key.toString().split(pattern));
      }
      return newList[0];
    }

    return unique.asMap().keys.map(map).toList();
  }

  List<dynamic> splitValues(Pattern pattern){
    dynamic map(dynamic key) {
      List newList = [];
      if (key is Map){
        key.forEach((k,v) => newList.add(k.split(pattern)));
      }else{

        newList.add(key.split(pattern));
      }
      return newList[0];
    }

    return unique.asMap().values.map(map).toList();
  }

  Collection get clear {
    _result.clear();
    list?.clear();

    return this;
  }

  List<dynamic> get unique {
    _result.addAll(list!);

    return _result.unique();
  }

  Collection merge(dynamic newList) {
    _result.addAll(list!);

    _result.addAll(newList);
    return this;
  }

  Collection sort([int Function(dynamic, dynamic)? compare]) {
    get.sort(compare);
    return this;
  }

  bool isKeyExists(dynamic key) {
    return _where(key).isNotEmpty;
  }

  bool isContainsValue(dynamic key) {
    return _where(key).isNotEmpty;
  }

  dynamic get first => get.first;
  dynamic get last => get.last;

  bool get isNotEmpty => get.isNotEmpty;

  bool get isEmpty => get.isEmpty;

  Iterable get reversed => get.reversed;

  Map get toMap => get.asMap();

  Iterable get values => get.asMap().values;

  Iterable get entries => get.asMap().entries;

  dynamic get test => get.asMap();

  Iterable get keys => get.asMap().keys;

  int get length => _result.length;

  List<dynamic> get get => (_result.isEmpty ? list! : _result).unique();
}
