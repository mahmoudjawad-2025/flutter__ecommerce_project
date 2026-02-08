import 'package:ecommerce_app/others/back/app_global/front_end/app_bar/AppBarCubit.dart';
import 'package:ecommerce_app/others/widgets_folder/LanguageSelector.dart';
import 'package:ecommerce_app/others/widgets_folder/ThemeSwitcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/core/config/AppSizes.dart';
import 'package:ecommerce_app/core/config/l10n/app_localizations.dart';

// ignore: must_be_immutable
class AppBar1 extends StatelessWidget {
  bool isSignPage = false;
  AppBar1({super.key, required this.isSignPage});

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    final iconColor = Theme.of(context).colorScheme.onPrimary;
    return !isSignPage
        ? Container(
            color: Theme.of(context).colorScheme.primary,
            child: Center(
              child: Padding(
                padding: EdgeInsetsGeometry.all(AppSizes.appBarPadding()),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //-------------------------------------------------------------------------- toggledrawer
                    Builder(
                      builder: (context) {
                        return IconButton(
                          icon: const Icon(Icons.menu),
                          style: Theme.of(context).iconButtonTheme.style
                              ?.copyWith(
                                iconColor: WidgetStateProperty.all(iconColor),
                              ),
                          onPressed: () {
                            context
                                .read<AppBarCubit>()
                                .key
                                .currentState
                                ?.openDrawer();
                          },
                        );
                      },
                    ),

                    //-------------------------------------------------------------------------- Title
                    Center(
                      child: Text(
                        tr.generalSignIn,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [ThemeSelector(), LanguageSelector()],
                    ),
                  ],
                ),
              ),
            ),
          )
        //-------------------------------------------------------------------------- theme + lang
        : Container(
            color: Theme.of(context).colorScheme.primary,
            child: Padding(
              padding: EdgeInsetsGeometry.all(AppSizes.appBarPadding()),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [ThemeSelector(), LanguageSelector()],
              ),
            ),
          );
  }
}
