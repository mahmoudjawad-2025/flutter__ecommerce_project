import 'package:ecommerce_app/common/models/ListTile1.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/core/config/AppSizes.dart';
import 'package:ecommerce_app/core/config/theme/ThemeUtils.dart';
import 'package:ecommerce_app/core/utils/AppConstants.dart';
import 'package:ecommerce_app/core/config/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class Drawer1 extends StatelessWidget {
  const Drawer1({super.key});
  @override
  Widget build(BuildContext context) {
    AppConstants.setDeviceSize(context);
    final tr = AppLocalizations.of(context)!;

    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          SizedBox(
            height: AppSizes.drawerHeaderHeight(),
            //-------------------------------------------------------------------------- Header
            child: DrawerHeader(
              decoration: const BoxDecoration(
                color: ThemeUtils.displayMediumColor,
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Motorcycles',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
            ),
          ),
          //-------------------------------------------------------------------------- elements
          ListTile1(
            text: tr.textDoYouHaveAccount,
            function: () => context.pop(),
            icon: Icons.login, // Custom icon for each item
          ),
          ListTile1(
            text: 'Home',
            function: () => context.pop(),
            icon: Icons.home,
          ),
          ListTile1(
            text: 'Settings',
            function: () => context.pop(),
            icon: Icons.settings,
          ),
        ],
      ),
    );
  }
}
