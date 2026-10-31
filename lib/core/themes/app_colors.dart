import 'package:flutter/material.dart';

/// Raw palette. Only `lib/core/themes` may reference these directly;
/// screens and widgets must read colors through `Theme.of(context)`.
abstract final class AppColors {
  static const Color violet100 = Color(0xFFEEE5FF);
  static const Color violet20 = Color(0xFFF4EEFF);
  static const Color violet80 = Color(0xFFB18AFF);
  static const Color violet100Dark = Color(0xFF7F3DFF);

  static const Color white = Color(0xFFFFFFFF);
  static const Color dark = Color(0xFF212325);
  static const Color light20 = Color(0xFF91919F);
  static const Color red = Color(0xFFFD3C4A);
}
