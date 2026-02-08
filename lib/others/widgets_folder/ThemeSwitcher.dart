import 'package:ecommerce_app/core/config/l10n/app_localizations.dart';
import 'package:ecommerce_app/others/back/app_global/front_end/ThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:ecommerce_app/core/config/AppSizes.dart';
import 'package:ecommerce_app/core/config/theme/ThemeUtils.dart';
import 'package:ecommerce_app/core/utils/AppConstants.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ThemeSelector extends StatelessWidget {
  const ThemeSelector({super.key});

  void _openColorPicker(BuildContext context) {
    Color tempColor = context.read<ThemeProvider>().seedColor;
    final tr = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: SingleChildScrollView(
          child: SizedBox(
            //-------------------------------------------------------------------------- width + height + theme
            width: AppSizes.themeSelecterDialogSize().width,
            height: AppSizes.themeSelecterDialogSize().height,
            child: Theme(
              data: Theme.of(context).copyWith(
                primaryTextTheme: const TextTheme(
                  titleSmall: TextStyle(
                    color: ThemeUtils.black,
                  ), // affects dropdown
                ),
              ),
              //-------------------------------------------------------------------------- colorPicker
              child: ColorPicker(
                pickerColor: tempColor,
                onColorChanged: (color) => tempColor = color,
                enableAlpha: false,
                // ignore: deprecated_member_use
                labelTextStyle: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
                colorPickerWidth: AppSizes.colorPickerWidth(),
              ),
            ),
            // ),
          ),
        ),
        //-------------------------------------------------------------------------- buttons
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: Text(tr.generalCancel),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<ThemeProvider>().setColor(tempColor);
              context.pop();
            },
            child: Text(tr.generalApply),
          ),
        ],
      ),
    );
  }

  //-------------------------------------------------------------------------- main build method
  @override
  Widget build(BuildContext context) {
    AppConstants.setDeviceSize(context);
    final color = Theme.of(context).colorScheme.onPrimary;
    return IconButton(
      icon: const Icon(Icons.color_lens),
      style: Theme.of(context).iconButtonTheme.style?.copyWith(
        iconColor: WidgetStateProperty.all(color),
      ),
      onPressed: () => _openColorPicker(context),
    );
  }
}
