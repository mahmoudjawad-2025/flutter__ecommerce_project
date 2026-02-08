import 'dart:ui';
import 'package:flutter/material.dart';

//-------------------------------------------------------------------------- AppAnimationTheme
@immutable
class AppAnimationTheme extends ThemeExtension<AppAnimationTheme> {
  // 🔹 Core animation presets
  final Duration fastDuration;
  final Duration normalDuration;
  final Duration slowDuration;
  final Curve defaultCurve;

  // 🔹 Specific use cases (optional, extendable)
  final Duration buttonDuration;
  final Curve buttonCurve;
  final Duration cardDuration;
  final Curve cardCurve;

  const AppAnimationTheme({
    required this.fastDuration,
    required this.normalDuration,
    required this.slowDuration,
    required this.defaultCurve,
    required this.buttonDuration,
    required this.buttonCurve,
    required this.cardDuration,
    required this.cardCurve,
  });

  // 🔹 Light theme preset
  static const light = AppAnimationTheme(
    fastDuration: Duration(milliseconds: 150),
    normalDuration: Duration(milliseconds: 300),
    slowDuration: Duration(milliseconds: 600),
    defaultCurve: Curves.easeInOut,
    buttonDuration: Duration(milliseconds: 200),
    buttonCurve: Curves.easeOut,
    cardDuration: Duration(milliseconds: 500),
    cardCurve: Curves.easeInOut,
  );

  // 🔹 Dark theme preset
  // static const dark = AppAnimationTheme(
  //   fastDuration: Duration(milliseconds: 200),
  //   normalDuration: Duration(milliseconds: 350),
  //   slowDuration: Duration(milliseconds: 650),
  //   defaultCurve: Curves.easeOut,
  //   buttonDuration: Duration(milliseconds: 250),
  //   buttonCurve: Curves.easeOut,
  //   cardDuration: Duration(milliseconds: 600),
  //   cardCurve: Curves.easeOut,
  // );

  @override
  AppAnimationTheme copyWith({
    Duration? fastDuration,
    Duration? normalDuration,
    Duration? slowDuration,
    Curve? defaultCurve,
    Duration? buttonDuration,
    Curve? buttonCurve,
    Duration? cardDuration,
    Curve? cardCurve,
  }) {
    return AppAnimationTheme(
      fastDuration: fastDuration ?? this.fastDuration,
      normalDuration: normalDuration ?? this.normalDuration,
      slowDuration: slowDuration ?? this.slowDuration,
      defaultCurve: defaultCurve ?? this.defaultCurve,
      buttonDuration: buttonDuration ?? this.buttonDuration,
      buttonCurve: buttonCurve ?? this.buttonCurve,
      cardDuration: cardDuration ?? this.cardDuration,
      cardCurve: cardCurve ?? this.cardCurve,
    );
  }

  @override
  AppAnimationTheme lerp(ThemeExtension<AppAnimationTheme>? other, double t) {
    if (other is! AppAnimationTheme) return this;

    return AppAnimationTheme(
      fastDuration: Duration(
        milliseconds: lerpDouble(
          fastDuration.inMilliseconds,
          other.fastDuration.inMilliseconds,
          t,
        )!.round(),
      ),
      normalDuration: Duration(
        milliseconds: lerpDouble(
          normalDuration.inMilliseconds,
          other.normalDuration.inMilliseconds,
          t,
        )!.round(),
      ),
      slowDuration: Duration(
        milliseconds: lerpDouble(
          slowDuration.inMilliseconds,
          other.slowDuration.inMilliseconds,
          t,
        )!.round(),
      ),
      defaultCurve: t < 0.5 ? defaultCurve : other.defaultCurve,
      buttonDuration: Duration(
        milliseconds: lerpDouble(
          buttonDuration.inMilliseconds,
          other.buttonDuration.inMilliseconds,
          t,
        )!.round(),
      ),
      buttonCurve: t < 0.5 ? buttonCurve : other.buttonCurve,
      cardDuration: Duration(
        milliseconds: lerpDouble(
          cardDuration.inMilliseconds,
          other.cardDuration.inMilliseconds,
          t,
        )!.round(),
      ),
      cardCurve: t < 0.5 ? cardCurve : other.cardCurve,
    );
  }
}

//-------------------------------------------------------------------------- Borders
@immutable
class AppBorderTheme extends ThemeExtension<AppBorderTheme> {
  final InputBorder enabledBorder;
  final InputBorder focusedBorder;
  final InputBorder errorBorder;
  final InputBorder focusedErrorBorder;
  final InputBorder disabledBorder;

  const AppBorderTheme({
    required this.enabledBorder,
    required this.focusedBorder,
    required this.errorBorder,
    required this.focusedErrorBorder,
    required this.disabledBorder,
  });

  /// Outline variant
  factory AppBorderTheme.outline(ColorScheme colorScheme) {
    OutlineInputBorder outline(Color color, {double width = 1.5}) =>
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: color, width: width),
        );

    return AppBorderTheme(
      enabledBorder: outline(colorScheme.primary),
      focusedBorder: outline(colorScheme.primary, width: 2),
      errorBorder: outline(colorScheme.error),
      focusedErrorBorder: outline(colorScheme.error, width: 2),
      disabledBorder: outline(colorScheme.surfaceContainerHighest),
    );
  }

  /// Underline variant
  // factory AppBorderTheme.underline(ColorScheme scheme) {
  //   UnderlineInputBorder underline(Color color, {double width = 1.5}) =>
  //       UnderlineInputBorder(
  //         borderSide: BorderSide(color: color, width: width),
  //       );

  //   return AppBorderTheme(
  //     enabledBorder: underline(scheme.outline),
  //     focusedBorder: underline(scheme.primary, width: 2),
  //     errorBorder: underline(scheme.error),
  //     focusedErrorBorder: underline(scheme.error, width: 2),
  //     disabledBorder: underline(scheme.surfaceVariant),
  //   );
  // }

  // 🔹 Required for ThemeExtension
  @override
  AppBorderTheme copyWith({
    InputBorder? enabledBorder,
    InputBorder? focusedBorder,
    InputBorder? errorBorder,
    InputBorder? focusedErrorBorder,
    InputBorder? disabledBorder,
  }) {
    return AppBorderTheme(
      enabledBorder: enabledBorder ?? this.enabledBorder,
      focusedBorder: focusedBorder ?? this.focusedBorder,
      errorBorder: errorBorder ?? this.errorBorder,
      focusedErrorBorder: focusedErrorBorder ?? this.focusedErrorBorder,
      disabledBorder: disabledBorder ?? this.disabledBorder,
    );
  }

  @override
  AppBorderTheme lerp(ThemeExtension<AppBorderTheme>? other, double t) {
    if (other is! AppBorderTheme) return this;
    return this;
  }
}
