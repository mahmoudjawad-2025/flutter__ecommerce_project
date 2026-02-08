import 'package:ecommerce_app/others/back/app_global/front_end/LocalProvider.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/core/utils/AppConstants.dart';
import 'package:provider/provider.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    AppConstants.setDeviceSize(context);
    final color = Theme.of(context).colorScheme.onPrimary;
    return PopupMenuButton<Locale>(
      tooltip: "",
      icon: const Icon(Icons.language),
      iconColor: Colors.white,
      style: Theme.of(context).iconButtonTheme.style?.copyWith(
        iconColor: WidgetStateProperty.all(color),
      ),
      // style: ,
      onSelected: (locale) {
        Provider.of<LocaleProvider>(context, listen: false).setLocale(locale);
      },
      itemBuilder: (context) => [
        const PopupMenuItem(value: Locale('en'), child: Text('English')),
        const PopupMenuItem(value: Locale('ar'), child: Text('العربية')),
      ],
    );
  }
}
