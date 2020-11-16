import 'package:meta/meta.dart';

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
    with StorageByTypeMixin {
  ComplexCustomThemeData(List<CustomThemeData> nested) {
    setData(nested.where((item) => item != null), recursive: true);
  }
}

/// Set of [CustomThemeData]'s for light and dark themes.
class CustomThemeDataSet<T extends CustomThemeData> extends CustomThemeData
    implements StorageByType {
  final T data;
  final T dataDark;

  const CustomThemeDataSet({@required this.data, @required this.dataDark})
      : assert(data != null),
        assert(dataDark != null);

  @override
  E get<E>([func]) {
    if (E == T) {
      return data as E;
    }

    if (func != null && data is StorageByType) {
      return func.call(data as StorageByType);
    }

    return null;
  }

  @override
  Iterable<Type> get types sync* {
    yield T;
  }
}
