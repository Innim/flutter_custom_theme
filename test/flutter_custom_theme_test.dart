import 'package:flutter/cupertino.dart';
import 'package:flutter_custom_theme/flutter_custom_theme.dart';
import 'package:flutter_custom_theme/src/storage_by_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CustomThemes', () {
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
//        ],n
//        child: Container(),
//      );
//
//      expect(() => storage.get<_TestThemeData2>(), throwsStateError);
//    });

      test('should return instance from sub storage', () {
        final data1 = _TestThemeData1();
        final data2 = _TestThemeData2();
        final data3 = _TestThemeDataWithNested(data1, data2);
        final storage = CustomThemes(
          data: [
            data3,
          ],
          child: Container(),
        );

        expect(storage.get<_TestThemeDataWithNested>(), data3);
        expect(storage.get<_TestThemeData1>(), data1);
        expect(storage.get<_TestThemeData2>(), data2);
        expect(storage.get<_TestThemeData3>(), null);
      });
    });
  });

  group('StorageByType', () {
    group('get<E>()', () {
      test('should return instance or null', () {
        final data1 = _TestThemeData1();
        final data2 = _TestThemeData2();
        final storage = StorageByTypeImpl();

        storage.setData([data1, data2]);

        expect(storage.get<_TestThemeData1>(), data1);
        expect(storage.get<_TestThemeData2>(), data2);
        expect(storage.get<_TestThemeData3>(), null);
      });

      test('should return instance from sub storage if recursive', () {
        final data1 = _TestThemeData1();
        final data2 = _TestThemeData2();
        final data3 = _TestThemeDataWithNested(data1, data2);
        final storage = StorageByTypeImpl();

        storage.setData([data3], recursive: true);

        expect(storage.get<_TestThemeDataWithNested>(), data3);
        expect(storage.get<_TestThemeData1>(), data1);
        expect(storage.get<_TestThemeData2>(), data2);
        expect(storage.get<_TestThemeData3>(), null);
      });

      test('should return instance from sub storage if not recursive', () {
        final data1 = _TestThemeData1();
        final data2 = _TestThemeData2();
        final data3 = _TestThemeDataWithNested(data1, data2);
        final storage = StorageByTypeImpl();

        storage.setData([data3]);

        expect(storage.get<_TestThemeDataWithNested>(), data3);
        expect(storage.get<_TestThemeData1>(), null);
        expect(storage.get<_TestThemeData2>(), null);
        expect(storage.get<_TestThemeData3>(), null);
      });
    });
  });

  group('ComplexCustomThemeData', () {
    test('should ignore null values', () {
      final data1 = _TestThemeData1();
      final data3 = _TestThemeDataWithNested(data1, null);
      final storage = CustomThemes(
        data: [data3],
        child: Container(),
      );

      expect(storage.get<_TestThemeData1>(), data1);
      expect(storage.get<_TestThemeDataWithNested>(), data3);
    });
  });
}

class _TestThemeData1 extends CustomThemeData {}

class _TestThemeData2 extends CustomThemeData {}

class _TestThemeData3 extends CustomThemeData {}

class _TestThemeDataWithNested extends ComplexCustomThemeData {
  final CustomThemeData subtheme1;
  final CustomThemeData subtheme2;

  _TestThemeDataWithNested(this.subtheme1, this.subtheme2)
      : super([subtheme1, subtheme2]);
}