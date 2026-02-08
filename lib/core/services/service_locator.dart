import 'package:ecommerce_app/core/services/api_c;ient.dart';
import 'package:ecommerce_app/data/product/ProductApi.dart';
import 'package:ecommerce_app/data/product/domain/IProductRepository.dart';
import 'package:ecommerce_app/data/product/domain/ProductService.dart';
import 'package:ecommerce_app/others/back/app_global/core_folder/CoreCubit.dart';
import 'package:ecommerce_app/others/back/app_global/front_end/BottomBarCubit.dart';
import 'package:ecommerce_app/others/back/app_global/front_end/app_bar/AppBarCubit.dart';
import 'package:ecommerce_app/others/back/sign_pages/forget_password/ForgetPasswordCubit.dart';
import 'package:ecommerce_app/others/back/sign_pages/sign_in/SignInPageCubit.dart';
import 'package:ecommerce_app/others/back/sign_pages/sign_out/SignUpPageCubit.dart';
import 'package:ecommerce_app/logic/product/cart_logic/CartCubit.dart';
import 'package:ecommerce_app/data/product/ProductRepository.dart';
import 'package:ecommerce_app/logic/product/product_logic/product_cubit.dart';
import 'package:ecommerce_app/logic/product/product_details_logic/product_details_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> initServiceLocator() async {
  //-------------------------------------------------------------------------- Core
  getIt.registerLazySingleton(
    () => ApiClient(baseUrl: 'https://your-api-url.com'),
  );

  //-------------------------------------------------------------------------- Data
  getIt.registerLazySingleton(() => ProductApi(client: getIt(), useFake: true));
  getIt.registerLazySingleton<IProductRepository>(
    () => ProductRepository(api: getIt()),
  );

  //-------------------------------------------------------------------------- Usecases
  getIt.registerLazySingleton(() => ProductService(getIt()));
  getIt.registerLazySingleton(() => GetProductByIdUseCase(getIt()));
  getIt.registerLazySingleton(() => GetRecommendedProductsUseCase(getIt()));
  getIt.registerLazySingleton(() => GetReviewsProductsUseCase(getIt()));

  //-------------------------------------------------------------------------- Cubits (you usually register them as factories)
  // global
  getIt.registerFactory(() => CoreCubit());
  // initial
  getIt.registerFactory(() => SignInPageCubit());
  getIt.registerFactory(() => SignUpPageCubit());
  getIt.registerFactory(() => ForgetPasswordCubit());
  getIt.registerFactory(() => BottomBarCubit());
  getIt.registerFactory(() => AppBarCubit());
  // product
  getIt.registerFactory(() => CartCubit());
  getIt.registerFactory(() => ProductDetailsCubit());
  getIt.registerFactory(
    () => ProductCubit(
      getProducts: getIt(),
      getProductById: getIt(),
      getRecommended: getIt(),
      getReviews: getIt(),
    ),
  );
}
