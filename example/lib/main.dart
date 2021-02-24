import 'package:flutter/material.dart';
import 'package:flutter_custom_theme/flutter_custom_theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _customThemeOn = false;

  @override
  Widget build(BuildContext context) {
    return CustomThemes(
      data: <CustomThemeData>[
        if (_customThemeOn)
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
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(
          value: _customThemeOn,
          onValueChanged: (value) {
            setState(() {
              _customThemeOn = value;
            });
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.value, this.onValueChanged})
      : super(key: key);

  final bool value;
  final ValueChanged<bool> onValueChanged;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Theme Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Switch(
                  value: widget.value,
                  onChanged: widget.onValueChanged,
                ),
                const Text('Custom theme')
              ],
            ),
            const CustomWidget()
          ],
        ),
      ),
    );
  }
}

/// Custom widget supported custom themes.
class CustomWidget extends StatelessWidget {
  const CustomWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = CustomWidgetThemeData.of(context);
    return Container(
      color: theme.backgroundColor,
      padding: const EdgeInsets.all(10),
      child: Text(
        'My custom widget',
        style: theme.textStyle,
        textAlign: theme.textAlign,
      ),
    );
  }
}

/// Theme data for [CustomWidget].
class CustomWidgetThemeData extends CustomThemeData {
  static CustomWidgetThemeData of(BuildContext context) => CustomThemes.of(
        context,
        mainDefault: const CustomWidgetThemeData(),
        darkDefault: const CustomWidgetThemeData.dark(),
      );

  final TextStyle textStyle;
  final TextAlign textAlign;
  final Color backgroundColor;

  const CustomWidgetThemeData(
      {this.textStyle, this.textAlign, this.backgroundColor});

  const CustomWidgetThemeData.dark(
      {this.textStyle, this.textAlign, this.backgroundColor = Colors.blueGrey});
}
