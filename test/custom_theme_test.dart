import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/custom_theme.dart';

void main() {
  group('get<T>()', () {
    test('should return data of type', () {
      final data1 = _TestThemeData1();
      final data2 = _TestThemeData2();
      final storage = CustomThemes(
        data: [data1, data2],
        child: Container(),
      );

      expect(storage.get<_TestThemeData1>(), data1);
      expect(storage.get<_TestThemeData2>(), data2);
    });

    test('should return data not just once', () {
      final data1 = _TestThemeData1();
      final storage = CustomThemes(
        data: [
          _TestThemeData2(),
          data1,
        ],
        child: Container(),
      );

      expect(storage.get<_TestThemeData1>(), data1);
      expect(storage.get<_TestThemeData1>(), data1);
    });

    test('should return null if there is no data for type', () {
      final storage = CustomThemes(
        data: [
          _TestThemeData2(),
          _TestThemeData3(),
        ],
        child: Container(),
      );

      expect(storage.get<_TestThemeData1>(), null);
    });

//    test('should throw exception if multiple data for type', () {
//      final storage = CustomThemes(
//        data: [
//          _TestThemeData2(),
//          _TestThemeData2(),
//          _TestThemeData3(),
//        ],
//        child: Container(),
//      );
//
//      expect(() => storage.get<_TestThemeData2>(), throwsStateError);
//    });
  });
}

class _TestThemeData1 extends CustomThemeData {}

class _TestThemeData2 extends CustomThemeData {}

class _TestThemeData3 extends CustomThemeData {}
