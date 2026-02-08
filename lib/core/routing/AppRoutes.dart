// lib/core/utils/routing/app_routes.dart

class AppRoutes {
  //-------------------------------------------------------------------------- Base paths
  static const String bottomNavBar = '/home';
  static const String signIn = '/signIn';
  static const String signUp = '/signUp';
  static const String forgetPassword = '/forgetPassword';

  // product
  static const String favourite = '/favourite';
  static const String cart = '/cart';

  static const String productDetail = '/product/:productId';
  static String productDetailWithParameters(int productId) =>
      '/product/$productId';

  static String get recommendation => '/recommendation/:productId';
  static String recommendationWithParameters(int productId) =>
      '/recommendation/$productId';

  static String get review => '/review/:productId';
  static String reviewWithParameters(int productId) => '/review/$productId';

  //-------------------------------------------------------------------------- Dynamic paths with parameters
}
