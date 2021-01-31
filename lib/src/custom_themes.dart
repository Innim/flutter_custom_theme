import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_custom_theme/src/storage_by_type.dart';
import 'custom_theme.dart';
import 'package:list_ext/list_ext.dart';

/// Storage for custom themes data.
class CustomThemes extends InheritedWidget with StorageByTypeMixin {
  /// Obtains the nearest CustomThemes.
  static CustomThemes? _of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CustomThemes>();
  }

  /// Obtains the theme data of given type from the nearest storage.
  ///
  /// If [CustomThemes] storage is not found than returns `null`.
  static T? of<T extends CustomThemeData>(BuildContext context,
      {T? mainDefault, T? darkDefault}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return _of(context)?.get<T>(isDark ? _getDarkFunc<T>() : null) ??
        (isDark && darkDefault != null ? darkDefault : mainDefault);
  }

  static GetFromSubStorage<T> _getDarkFunc<T>() => (storage) {
        if (storage is CustomThemeDataSet) {
          return storage.getDark<T>(_getDarkFunc<T>());
        }

        return storage.get<T>(_getDarkFunc<T>());
      };

  /// List of custom themes data.
  final List<CustomThemeData> data;

  CustomThemes({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child) {
    setData(data, recursive: true);
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    if (oldWidget is CustomThemes) {
      return !oldWidget.data.isUnorderedEquivalent(data);
    }

    return true;
  }
}
