import 'package:flutter/material.dart';
import 'package:pocket_flow/core/themes/light_theme.dart';

abstract final class AppTheme {
  static ThemeData get light => LightTheme.theme;
}
