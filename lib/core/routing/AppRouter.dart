import 'package:ecommerce_app/core/routing/AppRoutes.dart';
import 'package:ecommerce_app/ui/product/pages/cart_page.dart';
import 'package:ecommerce_app/ui/product/pages/favourite_page.dart';
import 'package:ecommerce_app/ui/product/pages/product_details_page.dart';
import 'package:ecommerce_app/ui/product/pages/recommendations_page.dart';
import 'package:ecommerce_app/ui/product/pages/reviews_page.dart';
import 'package:ecommerce_app/others/sign_pages/SignInPage.dart';
import 'package:ecommerce_app/others/sign_pages/SignUpPage.dart';
import 'package:ecommerce_app/others/sign_pages/forget_password/ForgetPasswordPage.dart';
import 'package:ecommerce_app/others/widgets_folder/BottomBar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final goRouter = GoRouter(
  initialLocation: AppRoutes.bottomNavBar,
  //-------------------------------------------------------------------------- errorPAge
  // errorBuilder: (context, state) => ErrorScreen(state: state),
  routes: [
    //-------------------------------------------------------------------------- bottomBar
    GoRoute(
      path: AppRoutes.bottomNavBar,
      pageBuilder: (context, state) => const MaterialPage(child: BottomBar()),
    ),

    //-------------------------------------------------------------------------- Sign In
    GoRoute(
      path: AppRoutes.signIn,
      pageBuilder: (context, state) => const MaterialPage(child: SignInPage()),
    ),

    //-------------------------------------------------------------------------- Sign Up
    GoRoute(
      path: AppRoutes.signUp,
      pageBuilder: (context, state) => const MaterialPage(child: SignUpPage()),
    ),

    //-------------------------------------------------------------------------- Forget Password
    GoRoute(
      path: AppRoutes.forgetPassword,
      pageBuilder: (context, state) =>
          const MaterialPage(child: ForgetPasswordPage()),
    ),

    //-------------------------------------------------------------------------- Product
    GoRoute(
      path: AppRoutes.favourite,
      pageBuilder: (context, state) =>
          const MaterialPage(child: FavouritesPage()),
    ),
    GoRoute(
      path: AppRoutes.cart,
      pageBuilder: (context, state) => const MaterialPage(child: CartPage()),
    ),
    GoRoute(
      path: AppRoutes.productDetail,
      pageBuilder: (context, state) {
        final productId = int.parse(state.pathParameters['productId']!);
        return MaterialPage(child: ProductDetailsPage(productId: productId));
      },
      // redirect: (context, state) {
      //   final cubit = context.read<ProductCubit>();
      //   final newProductId = int.parse(state.pathParameters['productId']!);

      //   // Force reload if product ID changed
      //   if (cubit.state is ProductLoaded) {
      //     final currentProduct = (cubit.state as ProductLoaded).currentProduct;
      //     if (currentProduct?.id != newProductId) {
      //       cubit.loadProductDetails(newProductId);
      //     }
      //   }

      //   return null;
      // },
    ),
    GoRoute(
      path: AppRoutes.recommendation,
      pageBuilder: (context, state) {
        final productId = int.parse(state.pathParameters['productId']!);
        return MaterialPage(child: RecommendationsPage(productId: productId));
      },
    ),
    GoRoute(
      path: AppRoutes.review,
      pageBuilder: (context, state) {
        final productId = int.parse(state.pathParameters['productId']!);
        return MaterialPage(child: ReviewsPage(productId: productId));
      },
    ),
  ],
);
