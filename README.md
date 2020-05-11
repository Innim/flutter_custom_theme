# custom_theme

[![pub package](https://img.shields.io/pub/v/flutter_custom_theme)](https://pub.dartlang.org/packages/flutter_custom_theme)

Flutter package for managing custom themes.
Make your own custom theme for custom components. Easily share it between projects and customize.

![](https://raw.githubusercontent.com/Innim/flutter_custom_theme/master/readme_images/demo.gif)

## Usage

To use this plugin:

 1. add `custom_theme` as a [dependency in your pubspec.yaml file](https://flutter.dev/platform-plugins/);
 2. [define custom theme](#define-custom-theme);
 3. [use this theme in your widget](#use-theme-in-widget);
 4. [create custom theme instance in the application](#customize-for-application).

### Define custom theme

Define custom theme for your widget. It should extends `CustomThemeData`:

```dart
class CustomWidgetThemeData extends CustomThemeData {
  const CustomWidgetThemeData();
}
```

For easy access to this theme define static `of(BuildContext)` method:

```dart
class CustomWidgetThemeData extends CustomThemeData {
  static CustomWidgetThemeData of(BuildContext context) =>
      CustomThemes.of(context);

  const CustomWidgetThemeData();
}
```

**Note:** if your theme is not exists in `context` than `null` will be returned.
You may want to define `default` theme instance to avoid that:

```dart
class CustomWidgetThemeData extends CustomThemeData {
  static final _default = const CustomWidgetThemeData();

  static CustomWidgetThemeData of(BuildContext context) =>
      CustomThemes.of(context) ?? _default;

  const CustomWidgetThemeData();
}
```

Now you can add any properties you need to customize appearance of your widget:

```dart
class CustomWidgetThemeData extends CustomThemeData {
  static final _default = const CustomWidgetThemeData();

  static CustomWidgetThemeData of(BuildContext context) =>
      CustomThemes.of(context) ?? _default;

  final TextStyle textStyle;
  final TextAlign textAlign;
  final Color backgroundColor;

  const CustomWidgetThemeData(
      {this.textStyle, this.textAlign, this.backgroundColor});
}
```

### Use theme in widget

To use theme in widget just get instance with `CustomWidgetThemeData.of(context);`.

```dart
class CustomWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get theme
    final theme = CustomWidgetThemeData.of(context);

    return Container(
      color: theme.backgroundColor,
      child: Text(
        'My custom widget',
        style: theme.textStyle,
        textAlign: theme.textAlign,
      ),
    );
  }
}
```

### Customize for application

To provide theme for all underlying `CustomWidget` instances wrap it with `CustomThemes`:
```dart
@override
  Widget build(BuildContext context) {
    return CustomThemes(
      data: [
        // Custom theme for application
        const CustomWidgetThemeData(
          textStyle: TextStyle(
            fontSize: 20,
            color: Colors.indigo,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
          backgroundColor: Colors.lightBlueAccent,
        )
      ],
      child: MaterialApp(
        title: 'Flutter Custom Theme Demo',
        theme: ThemeData(),
        home: MyHomePage(),
      ),
    );
  }
```

## When to use

Use it if your share widgets or even whole features between the projects.

For example: you create widget `TextButton` and want to use it in multiple projects.
Of cause this button should look different in different projects and Flutter theme settings
not always (or even always not) enough for customize it. As a solution you can create
different widgets with custom appearance in each project, but it's just waste of time.

Another example: you want to share whole feature. It can include multiple screens and
some business logic, but only difference from project to project - it's how it look like.
This is a really big problem. You must write a lot of useless and repeating code to do this.
All benefits of sharing feature are fall away.

With [flutter_custom_theme](https://pub.dev/packages/flutter_custom_theme) you can easily
define your own theme and share widgets or feature between the project.
Now you just wrap all with `CustomThemes` with required themes instances and it's done.