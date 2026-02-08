import 'package:flutter/material.dart';
import 'package:ecommerce_app/core/config/AppSizes.dart';

class AppTextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) {
    return TextTheme(
      //-------------------------------------------------------------------------- display
      // displayLarge: TextStyle(
      //   fontSize: 32.sp,
      //   fontWeight: FontWeight.bold,
      //   color: colorScheme.onBackground,
      // ),
      displayMedium: TextStyle(
        fontSize: AppSizes.displayMedium(),
        fontWeight: FontWeight.bold,
        foreground: Paint()
          ..shader = const LinearGradient(
            colors: <Color>[Colors.blue, Colors.purple, Colors.pink],
          ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
        shadows: [
          Shadow(
            offset: const Offset(4.0, 4.0), // Creates a 3D effect
            blurRadius: 4.0,
            color: Colors.black.withAlpha(5),
          ),
        ],
      ),
      // displaySmall: TextStyle(
      //   fontSize: 24.sp,
      //   fontWeight: FontWeight.w600,
      //   color: colorScheme.onBackground,
      // ),

      //-------------------------------------------------------------------------- Headline
      headlineLarge: TextStyle(
        fontSize: AppSizes.headlineLarge(),
        fontWeight: FontWeight.bold,
        color: colorScheme.primary,
      ),
      headlineMedium: TextStyle(
        fontSize: AppSizes.headlineMedium(),
        fontWeight: FontWeight.w500,
        color: colorScheme.onPrimary,
      ),
      // headlineSmall: TextStyle(
      //   fontSize: 18.sp,
      //   fontWeight: FontWeight.w500,
      //   color: colorScheme.onBackground,
      // ),

      //-------------------------------------------------------------------------- Title
      // titleLarge: TextStyle(
      //   fontSize: 16.sp,
      //   fontWeight: FontWeight.w600,
      //   color: colorScheme.onBackground,
      // ),
      // titleMedium: TextStyle(
      //   fontSize: 14.sp,
      //   fontWeight: FontWeight.w500,
      //   color: colorScheme.onBackground,
      // ),
      // titleSmall: TextStyle(
      //   fontSize: 12.sp,
      //   fontWeight: FontWeight.w500,
      //   color: colorScheme.onBackground,
      // ),

      //-------------------------------------------------------------------------- Body
      // bodyLarge: TextStyle(
      //   fontSize: 16.sp,
      //   fontWeight: FontWeight.normal,
      //   color: colorScheme.onSurface,
      // ),
      bodyMedium: TextStyle(
        fontSize: AppSizes.bodyMedium(),
        fontWeight: FontWeight.normal,
        color: colorScheme.onSecondary,
      ),
      // bodySmall: TextStyle(
      //   fontSize: 90,
      //   fontWeight: FontWeight.normal,
      //   color: colorScheme.onSurfaceVariant,
      // ),

      //-------------------------------------------------------------------------- Label
      labelLarge: TextStyle(
        fontSize: AppSizes.labelLarge(),
        color: colorScheme.onSecondary,
      ),
      labelMedium: TextStyle(
        fontSize: AppSizes.labelMedium(),
        fontWeight: FontWeight.w500,
        color: colorScheme.primary,
      ),
      // labelSmall: TextStyle(
      //   fontSize: 10.sp,
      //   fontWeight: FontWeight.w400,
      //   color: colorScheme.primary,
      // ),
    );
  }
}
