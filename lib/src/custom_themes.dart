import 'package:flutter/widgets.dart';
import 'package:flutter_custom_theme/src/storage_by_type.dart';
import 'custom_theme.dart';
import 'package:list_ext/list_ext.dart';

/// Storage for custom themes data.
class CustomThemes extends InheritedWidget with StorageByTypeMixin {
  /// Obtains the nearest CustomThemes.
  static CustomThemes _of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CustomThemes>();
  }

  /// Obtains the theme data of given type from the nearest storage.
  ///
  /// If [CustomThemes] storage is not found than returns `null`.
  static T of<T extends CustomThemeData>(BuildContext context) {
    return _of(context)?.get<T>();
  }

  /// List of custom themes data.
  final List<CustomThemeData> data;

  CustomThemes({
    Key key,
    @required this.data,
    @required Widget child,
  })  : assert(data != null),
        super(key: key, child: child) {
    setData(data, recursive: true);
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    if (oldWidget is CustomThemes)
      return !oldWidget.data.isUnorderedEquivalent(data);
    return true;
  }
}
