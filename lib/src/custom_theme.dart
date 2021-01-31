import 'package:flutter_custom_theme/flutter_custom_theme.dart';

import 'storage_by_type.dart';

/// Interface for custom theme data implementation.
///
/// If you want to use other [CustomThemeData] as part of
/// this theme data and this other data should be available
/// through [CustomThemes.of] - use [ComplexCustomThemeData].
abstract class CustomThemeData {
  const CustomThemeData();
}

/// Interface for custom theme data with nested [CustomThemeData].
///
/// All nested [CustomThemeData] will be available through [CustomThemes.of].
abstract class ComplexCustomThemeData extends CustomThemeData
    with StorageByTypeMixin<CustomThemeData> {
  ComplexCustomThemeData(Iterable<CustomThemeData> nested) {
    setData(nested, recursive: true);
  }

  ComplexCustomThemeData.by(Iterable<CustomThemeData?> nested) {
    setData(
      nested.where((item) => item != null).map<CustomThemeData>((e) => e!),
      recursive: true,
    );
  }
}

/// Set of [CustomThemeData]'s for light and dark themes.
class CustomThemeDataSet<T extends CustomThemeData> extends CustomThemeData
    implements StorageByType {
  final T data;
  final T dataDark;

  const CustomThemeDataSet({required this.data, required this.dataDark});

  @override
  Iterable<Type> get types sync* {
    yield T;
  }

  @override
  E? get<E>([GetFromSubStorage<E>? func]) => _get<E>(data, func);

  E? getDark<E>([GetFromSubStorage<E>? func]) => _get<E>(dataDark, func);

  E? _get<E>(T data, GetFromSubStorage<E>? func) {
    if (E == T) {
      return data as E;
    }

    if (data is StorageByType) {
      final storage = data as StorageByType;
      if (func != null) {
        return func.call(storage);
      } else {
        return storage.get<E>();
      }
    }

    return null;
  }
}
