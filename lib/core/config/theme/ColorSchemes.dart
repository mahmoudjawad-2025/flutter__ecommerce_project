import 'package:flutter/material.dart';
import 'package:ecommerce_app/core/config/theme/ThemeUtils.dart';

ColorScheme buildColorScheme(Color seed) {
  final isDark = ThemeUtils.isDarkColor(seed);

  return ColorScheme.fromSeed(seedColor: seed).copyWith(
    // main
    primary: seed,
    // background
    surface: isDark ? const Color.fromARGB(255, 245, 240, 240) : Colors.black,
    // error
    error: Colors.red,
    // static in sort : white, black, transparent, other
    onSurface: seed, // forced to set this = seed
    onPrimary: isDark ? Colors.white : Colors.black,
    onSecondary: isDark ? Colors.black : Colors.white,
    onInverseSurface: Colors.transparent,
  );
}
