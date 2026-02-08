import 'package:device_preview/device_preview.dart';
import 'package:ecommerce_app/core/services/service_locator.dart';
import 'package:ecommerce_app/others/back/app_global/core_folder/CoreCubit.dart';
import 'package:ecommerce_app/others/back/app_global/front_end/BottomBarCubit.dart';
import 'package:ecommerce_app/others/back/app_global/front_end/app_bar/AppBarCubit.dart';
import 'package:ecommerce_app/others/back/sign_pages/forget_password/ForgetPasswordCubit.dart';
import 'package:ecommerce_app/others/back/sign_pages/sign_in/SignInPageCubit.dart';
import 'package:ecommerce_app/others/back/sign_pages/sign_out/SignUpPageCubit.dart';
import 'package:ecommerce_app/logic/product/cart_logic/CartCubit.dart';
import 'package:ecommerce_app/logic/product/product_details_logic/product_details_cubit.dart';
import 'package:ecommerce_app/logic/product/product_logic/product_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecommerce_app/others/back/app_global/front_end/LocalProvider.dart';
import 'package:ecommerce_app/others/back/app_global/front_end/ThemeProvider.dart';
import 'package:ecommerce_app/core/config/l10n/app_localizations.dart';
import 'package:ecommerce_app/core/utils/AppConstants.dart';
import 'package:ecommerce_app/core/routing/AppRouter.dart';
import 'package:ecommerce_app/core/config/theme/AppThemes.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// you now just need :  convert old files to use new arch (and check their content in general) + if want change structure of logic of product later to more simple + finally (theme + language)

//-------------------------------------------------------------------------- main

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await initServiceLocator();
    runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => MultiProvider(
          providers: [
            // global
            ChangeNotifierProvider(create: (_) => LocaleProvider()),
            ChangeNotifierProvider(create: (_) => ThemeProvider()),
            BlocProvider(create: (_) => getIt<CoreCubit>()),
            // initial
            BlocProvider(create: (_) => getIt<SignInPageCubit>()),
            BlocProvider(create: (_) => getIt<SignUpPageCubit>()),
            BlocProvider(create: (_) => getIt<ForgetPasswordCubit>()),
            BlocProvider(create: (_) => getIt<AppBarCubit>()),
            BlocProvider(create: (_) => getIt<BottomBarCubit>()),
            //product
            BlocProvider(create: (_) => getIt<CartCubit>()),
            BlocProvider(create: (_) => getIt<ProductDetailsCubit>()),
            BlocProvider(create: (_) => getIt<ProductCubit>()..loadProducts()),
          ],
          child: const MyApp(),
        ),
      ),
    );
  } catch (e) {
    throw Exception(e);
  }
}

//-------------------------------------------------------------------------- MyApp
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //-------------------------------------------------------------------------- main sec
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        AppConstants.setDeviceSize(context);
        final locale = context.watch<LocaleProvider>().locale;
        final seedColor = context.watch<ThemeProvider>().seedColor;
        final theme = AppThemes.themeFrom(seedColor);
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: AppConstants.appName,
          builder: DevicePreview.appBuilder,
          theme: theme,
          locale: locale,
          supportedLocales: const [Locale('en'), Locale('ar')],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          routerConfig: goRouter,
        );
      },
    );
  }
}
