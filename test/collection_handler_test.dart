import 'package:collection_handler/core/extensions/custom_list_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:collection_handler/collection_handler.dart';

void main() {
  test('adds one to input values', () {
    List list = [
      'ana',
      'mohamed',
      {
        'ana' : "try map"
      }
    ];

    Collection extCollection = list.toCollection;

    print(extCollection.where("ana").get);

    // expect(calculator.addOne(2), 3);
    // expect(collection.getIndex(1, ), matcher)

  });
}
