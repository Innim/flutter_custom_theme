import 'package:flutter/widgets.dart';
import 'custom_theme.dart';
import 'package:list_ext/list_ext.dart';

/// Storage for custom themes data.
class CustomThemes extends InheritedWidget {
  /// Obtains the nearest CustomThemes.
  static CustomThemes _of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CustomThemes>();
  }

  /// Obtains the theme data of given type from the nearest storage.
  static T of<T extends CustomThemeData>(BuildContext context) {
    return _of(context).get<T>();
  }

  /// List of custom themes data.
  final List<CustomThemeData> data;

  const CustomThemes({
    Key key,
    @required this.data,
    @required Widget child,
  })  : assert(data != null),
        super(key: key, child: child);

  /// Obtains the theme data of given type.
  ///
  /// If there is no theme data for type, then `null` will be returned.
  T get<T extends CustomThemeData>() =>
      data.firstWhereOrNull((e) => e.runtimeType == T);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    if (oldWidget is CustomThemes)
      return !oldWidget.data.isUnorderedEquivalent(data);
    return true;
  }
}
