import 'package:flutter/material.dart';

extension BuildContextGetters on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get screenSize => mediaQuery.size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  EdgeInsets get safeArea => mediaQuery.padding;

  ThemeData get theme => Theme.of(this);
  ColorScheme get colors => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;
  Brightness get brightness => theme.brightness;
  bool get isDark => brightness == Brightness.dark;

  NavigatorState get navigator => Navigator.of(this);
  ScaffoldState get scaffold => Scaffold.of(this);
}
