import 'package:ecommerce_app/core/config/theme/ThemeExtentions.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/core/config/theme/ColorSchemes.dart';
import 'package:ecommerce_app/core/config/theme/ThemeTexts.dart';
import 'ThemeWidgets.dart';

class AppThemes {
  static ThemeData themeFrom(Color seed) {
    final colorScheme = buildColorScheme(seed);
    final textTheme = AppTextThemes.textTheme(colorScheme);

    return ThemeData(
      //-------------------------------------------------------------------------- main
      useMaterial3: true,
      scaffoldBackgroundColor: colorScheme.surface,
      colorScheme: colorScheme,
      textTheme: textTheme,
      iconTheme: iconTheme(colorScheme),
      iconButtonTheme: iconButtonTheme(colorScheme),
      drawerTheme: drawerTheme(colorScheme, textTheme),
      dialogTheme: dialogTheme(colorScheme, textTheme),
      navigationBarTheme: navigationBarTheme(colorScheme, textTheme),

      //-------------------------------------------------------------------------- widgets
      popupMenuTheme: popupMenuTheme(colorScheme, textTheme),
      listTileTheme: listTileTheme(colorScheme, textTheme),
      textButtonTheme: textButtonTheme(colorScheme, textTheme),
      outlinedButtonTheme: outlinedButtonTheme(colorScheme, textTheme),
      elevatedButtonTheme: elevatedButtonTheme(colorScheme, textTheme),
      progressIndicatorTheme: progressIndicatorTheme(colorScheme),
      snackBarTheme: snackBarThemeData(colorScheme, textTheme),
      inputDecorationTheme: inputDecorationTheme(colorScheme, textTheme),

      //-------------------------------------------------------------------------- extentions
      extensions: [
        AppAnimationTheme.light,
        AppBorderTheme.outline(colorScheme),
      ],
    );
  }
}
