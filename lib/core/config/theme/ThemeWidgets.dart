// ignore_for_file: deprecated_member_use

import 'package:ecommerce_app/core/config/theme/ThemeExtentions.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/core/config/AppSizes.dart';
import 'package:ecommerce_app/core/config/theme/ThemeUtils.dart';

//-------------------------------------------------------------------------- inputs
InputDecorationTheme inputDecorationTheme(
  ColorScheme colorScheme,
  TextTheme textTheme,
) {
  final border = AppBorderTheme.outline(colorScheme);
  return InputDecorationTheme(
    border: border.enabledBorder,
    enabledBorder: border.enabledBorder,
    focusedBorder: border.focusedBorder,
    errorBorder: border.errorBorder,
    focusedErrorBorder: border.focusedErrorBorder,
    disabledBorder: border.disabledBorder,

    labelStyle: MaterialStateTextStyle.resolveWith((states) {
      if (states.contains(MaterialState.error)) {
        return textTheme.bodyMedium!.copyWith(color: colorScheme.error);
      }
      if (states.contains(MaterialState.focused)) {
        return textTheme.bodyMedium!.copyWith(color: colorScheme.onSecondary);
      }
      return textTheme.bodyMedium!.copyWith(color: colorScheme.onSecondary);
    }),
    floatingLabelStyle: MaterialStateTextStyle.resolveWith((states) {
      if (states.contains(MaterialState.error)) {
        return textTheme.bodyMedium!.copyWith(color: colorScheme.error);
      }
      if (states.contains(MaterialState.focused)) {
        return textTheme.bodyMedium!.copyWith(color: colorScheme.onSurface);
      }
      return textTheme.bodyMedium!.copyWith(color: colorScheme.onSurface);
    }),

    prefixIconColor: _getIconTheme(colorScheme).color, // default icon color
    prefixIconConstraints: BoxConstraints(
      minWidth: AppSizes.iconSize(), // 👈 expand tap area / spacing
      minHeight: AppSizes.iconSize(), // 👈 makes it taller
    ),
    errorStyle: textTheme.bodyMedium?.copyWith(color: colorScheme.error),
    contentPadding: EdgeInsets.all(AppSizes.paddingSmall()),
    counterStyle: textTheme.labelMedium,
  );
}
//-------------------------------------------------------------------------- drawer, bars, indicator, dialog

DrawerThemeData drawerTheme(ColorScheme colorScheme, TextTheme textTheme) {
  return DrawerThemeData(
    width: AppSizes.drawerWidth(),
    backgroundColor: colorScheme.onPrimary,
    elevation: 8.0,
    shadowColor: colorScheme.shadow,
    surfaceTintColor: colorScheme.surfaceTint,
    // Scrim color (background when drawer is open)
    scrimColor: ThemeUtils.black,

    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.horizontal(right: Radius.circular(16.0)),
    ),

    // End drawer (right side) - same as start drawer by default
    endShape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.horizontal(left: Radius.circular(16.0)),
    ),
  );
}

NavigationBarThemeData navigationBarTheme(
  ColorScheme colorScheme,
  TextTheme textTheme,
) {
  final iconSizeGlobal = _getIconTheme(colorScheme).size;
  return NavigationBarThemeData(
    height: AppSizes.bottomBarHeight(),
    // Icon theme for different states
    iconTheme: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return _getIconTheme(
          colorScheme,
        ).copyWith(color: colorScheme.onPrimary, size: iconSizeGlobal! * 1.3);
      }
      return _getIconTheme(
        colorScheme,
      ).copyWith(color: colorScheme.onPrimary, size: iconSizeGlobal!);
    }),
    backgroundColor: colorScheme.primary,
    indicatorColor: ThemeUtils.transparent,
    indicatorShape: const CircleBorder(),

    surfaceTintColor: ThemeUtils.transparent,
    labelBehavior:
        NavigationDestinationLabelBehavior.alwaysHide, // Hides labels
  );
}

ProgressIndicatorThemeData progressIndicatorTheme(ColorScheme colorScheme) {
  return ProgressIndicatorThemeData(
    color: colorScheme.primary, // Default color
    circularTrackColor: ThemeUtils.transparent, // Background track
    linearTrackColor: ThemeUtils.transparent,
  );
}

DialogThemeData dialogTheme(ColorScheme colorScheme, TextTheme textTheme) {
  return DialogThemeData(
    backgroundColor: colorScheme.onPrimary,
    elevation: 6.0,
    // shadowColor: colorScheme.shadow,
    // surfaceTintColor: colorScheme.primary.withOpacity(0.1),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    // titleTextStyle: textTheme.titleLarge?.copyWith(
    //   color: colorScheme.onSurface,
    //   fontWeight: FontWeight.bold,
    // ),
    contentTextStyle: textTheme.bodyMedium?.copyWith(
      color: colorScheme.onSecondary,
    ),
    alignment: Alignment.center,
    iconColor: colorScheme.primary,
    titleTextStyle: textTheme.headlineLarge?.copyWith(
      color: colorScheme.onSecondary,
    ),
  );
}

SnackBarThemeData snackBarThemeData(
  ColorScheme colorScheme,
  TextTheme textTheme,
) {
  return SnackBarThemeData(
    // Background color
    backgroundColor: colorScheme.onSecondary,
    // Content text style
    contentTextStyle: textTheme.bodyMedium?.copyWith(
      color: colorScheme.onPrimary,
      fontWeight: FontWeight.w500,
    ),

    elevation: 6.0,
    behavior: SnackBarBehavior.fixed,
    insetPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    closeIconColor: colorScheme.onPrimary.withOpacity(0.8),
    actionTextColor: colorScheme.onPrimary,

    // Action overflow behavior
    actionOverflowThreshold: 0.25,
    showCloseIcon: true,
    // Disabled action text color
    disabledActionTextColor: colorScheme.onSurface.withOpacity(0.38),
  );
}
//-------------------------------------------------------------------------- Menue , lists,

PopupMenuThemeData popupMenuTheme(
  ColorScheme colorScheme,
  TextTheme textTheme,
) => PopupMenuThemeData(
  labelTextStyle: WidgetStateProperty.all(
    textTheme.bodyMedium?.copyWith(color: colorScheme.onSecondary),
  ),
  iconColor: _getIconTheme(colorScheme).color,
  color: colorScheme.onPrimary, // background
  textStyle: textTheme.labelLarge?.copyWith(
    color: colorScheme.onSecondary,
  ), //colorScheme.onSecondary),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
    side: BorderSide(color: colorScheme.outline.withOpacity(0.1)),
  ),
  // Menu-level padding
  menuPadding: EdgeInsets.all(AppSizes.paddingSmall()),
  // Item-level styling
  position: PopupMenuPosition.under,
  elevation: 4.0,
  shadowColor: colorScheme.shadow,
);

ListTileThemeData listTileTheme(ColorScheme colorScheme, TextTheme textTheme) {
  return ListTileThemeData(
    dense: true,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    selectedTileColor: colorScheme.primary.withOpacity(0.1),
    // selectedColor: colorScheme.primary,
    iconColor: colorScheme.primary,
    // text styles theme set it inline not here because here can't control font size
    tileColor: ThemeUtils.transparent,
    // textColor: colorScheme.primary,
    titleTextStyle: textTheme.bodyMedium?.copyWith(fontSize: 100),
    // ?? const TextStyle(
    //   color: Colors.amber,
    //   fontSize: 1,
    // ),
    subtitleTextStyle: textTheme.bodyMedium?.copyWith(fontSize: 100),
    // ?? const TextStyle(
    //   color: Colors.red,
    //   fontSize: 54,
    // ),
    mouseCursor: const WidgetStatePropertyAll(SystemMouseCursors.click),
    horizontalTitleGap: 16.0,
    minVerticalPadding: 12.0,
    minLeadingWidth: 24.0,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    enableFeedback: true,
  );
}

//-------------------------------------------------------------------------- buttons
ElevatedButtonThemeData elevatedButtonTheme(
  ColorScheme colorScheme,
  TextTheme textTheme,
) {
  return ElevatedButtonThemeData(
    style: ButtonStyle(
      // padding: WidgetStateProperty.all(
      //   EdgeInsets.all(AppSizes.paddingSmall() * 20),
      // ),
      backgroundColor: WidgetStateProperty.all(colorScheme.primary),
      foregroundColor: WidgetStateProperty.all(colorScheme.onPrimary),
      textStyle: WidgetStateProperty.all(
        textTheme.bodyMedium?.copyWith(
          color: colorScheme.onPrimary, // ensure text color is applied
        ),
      ),
      // padding: WidgetStateProperty.all(EdgeInsets.all(10.sp)),
    ),
  );
}

TextButtonThemeData textButtonTheme(
  ColorScheme colorScheme,
  TextTheme textTheme,
) {
  return TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(colorScheme.primary),
      textStyle: WidgetStateProperty.all(
        textTheme.bodyMedium?.copyWith(
          color: colorScheme.onPrimary, // ensure text color is applied
        ),
      ),
    ),
  );
}

OutlinedButtonThemeData outlinedButtonTheme(
  ColorScheme colorScheme,
  TextTheme textTheme,
) {
  return OutlinedButtonThemeData(
    style: ButtonStyle(
      padding: WidgetStateProperty.all(
        EdgeInsets.all(AppSizes.paddingSmall() * 3),
      ),
      side: WidgetStateProperty.all(
        BorderSide(color: colorScheme.primary, width: 1.5),
      ),
      foregroundColor: WidgetStateProperty.all(colorScheme.onSecondary),
      textStyle: WidgetStateProperty.all(
        textTheme.bodyMedium?.copyWith(
          color: colorScheme.onPrimary, // ensure text color is applied
        ),
      ),
    ),
  );
}

//-------------------------------------------------------------------------- icons, iconButtonTheme

// Helper function to get the global icon theme
IconThemeData _getIconTheme(ColorScheme colorScheme) {
  return IconThemeData(color: colorScheme.primary, size: AppSizes.iconSize());
}

IconThemeData iconTheme(ColorScheme colorScheme) {
  return _getIconTheme(colorScheme);
}

IconButtonThemeData iconButtonTheme(ColorScheme colorScheme) {
  return IconButtonThemeData(
    style: ButtonStyle(
      // Icon color for different states
      iconColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return _getIconTheme(colorScheme).color?.withOpacity(0.35);
        }
        return _getIconTheme(colorScheme).color;
      }),
      // Icon size - can match your IconTheme size
      iconSize: WidgetStateProperty.all(AppSizes.iconSize()),

      // Background color for different states
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return ThemeUtils.transparent;
        }
        if (states.contains(WidgetState.pressed)) {
          return _getIconTheme(colorScheme).color?.withOpacity(0.12);
        }
        if (states.contains(WidgetState.hovered)) {
          return
          // Colors.red;
          colorScheme.onPrimary.withOpacity(0.1);
        }
        if (states.contains(WidgetState.focused)) {
          return _getIconTheme(colorScheme).color?.withOpacity(0.12);
        }
        return ThemeUtils.transparent;
      }),
      padding: WidgetStateProperty.all(EdgeInsets.all(AppSizes.paddingSmall())),
      // minimumSize: WidgetStateProperty.all(const Size(48.0, 48.0)),
      // maximumSize: WidgetStateProperty.all(const Size(48.0, 48.0)),
      // Shape (circular for Material 3)
      shape: WidgetStateProperty.all(
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24.0)),
        ),
      ),
      // Side/border
      side: WidgetStateProperty.all(BorderSide.none),
      mouseCursor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return SystemMouseCursors.forbidden;
        }
        return SystemMouseCursors.click;
      }),
      visualDensity: VisualDensity.standard,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      animationDuration: const Duration(milliseconds: 200),
      enableFeedback: true,
    ),
  );
}


//-------------------------------------------------------------------------- others

