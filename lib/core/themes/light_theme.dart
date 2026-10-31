import 'package:flutter/material.dart';
import 'package:pocket_flow/core/gen/fonts.gen.dart';
import 'package:pocket_flow/core/themes/app_colors.dart';

abstract final class LightTheme {
  static const _colorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.violet100Dark,
    onPrimary: AppColors.white,
    primaryContainer: AppColors.violet100,
    onPrimaryContainer: AppColors.violet100Dark,
    secondary: AppColors.violet80,
    onSecondary: AppColors.white,
    secondaryContainer: AppColors.violet20,
    onSecondaryContainer: AppColors.violet100Dark,
    error: AppColors.red,
    onError: AppColors.white,
    surface: AppColors.white,
    onSurface: AppColors.dark,
    onSurfaceVariant: AppColors.light20,
    outline: AppColors.light20,
  );

  static final _textTheme =
      const TextTheme(
        headlineMedium: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          height: 1.2,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          height: 1.5,
        ),
        titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ).apply(
        fontFamily: FontFamily.instrumentSans,
        bodyColor: _colorScheme.onSurface,
        displayColor: _colorScheme.onSurface,
      );

  static OutlineInputBorder _inputBorder(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(color: color),
  );

  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    colorScheme: _colorScheme,
    scaffoldBackgroundColor: _colorScheme.surface,
    fontFamily: FontFamily.instrumentSans,
    textTheme: _textTheme,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _colorScheme.secondaryContainer,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      hintStyle: _textTheme.bodyLarge?.copyWith(
        color: _colorScheme.onSurfaceVariant,
      ),
      errorStyle: _textTheme.bodySmall?.copyWith(color: _colorScheme.error),
      border: _inputBorder(_colorScheme.primaryContainer),
      enabledBorder: _inputBorder(_colorScheme.primaryContainer),
      focusedBorder: _inputBorder(_colorScheme.primary),
      errorBorder: _inputBorder(_colorScheme.error),
      focusedErrorBorder: _inputBorder(_colorScheme.error),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: _colorScheme.primary,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: _colorScheme.primary,
        foregroundColor: _colorScheme.onPrimary,
        minimumSize: const Size.fromHeight(56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: _textTheme.titleMedium,
      ),
    ),
  );
}
