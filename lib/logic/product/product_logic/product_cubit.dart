import 'package:ecommerce_app/common/entities/ReviewEntity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/common/entities/ProductEntity.dart';
import 'package:ecommerce_app/data/product/domain/ProductService.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  //-------------------------------------------------------------------------- use cases
  final ProductService getProducts;
  final GetProductByIdUseCase getProductById;
  final GetRecommendedProductsUseCase getRecommended;
  final GetReviewsProductsUseCase getReviews;

  ProductCubit({
    required this.getProducts,
    required this.getProductById,
    required this.getRecommended,
    required this.getReviews,
  }) : super(ProductInitial());

  //-------------------------------------------------------------------------- Prodduct details
  // Future<void> loadProductDetails(int productId) async {
  //   emit((state as ProductLoaded).copyWith(currentProduct: null));
  //   try {
  //     final product = await getProductById(productId);
  //     emit((state as ProductLoaded).copyWith(currentProduct: product));
  //   } catch (e) {
  //     emit(ProductError('Failed to load product details'));
  //   }
  // }
  Future<void> loadProductDetails(int productId) async {
    try {
      final product = await getProductById(productId);
      final s = state as ProductLoaded;
      emit(s.copyWith(currentProduct: product));
    } catch (e) {
      emit(ProductError('Failed to load product details'));
    }
  }

  //-------------------------------------------------------------------------- load
  Future<void> loadProducts() async {
    emit(ProductLoading());
    try {
      final products = await getProducts();
      emit(ProductLoaded(products: products, favouriteIds: {}));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  //-------------------------------------------------------------------------- toggle favourite
  void toggleFavourite(int productId) {
    if (state is! ProductLoaded) return;
    final s = state as ProductLoaded;

    final favs = Set<int>.from(s.favouriteIds);
    favs.contains(productId) ? favs.remove(productId) : favs.add(productId);

    emit(s.copyWith(favouriteIds: favs));
  }

  //-------------------------------------------------------------------------- Products list
  List<ProductEntity> get products {
    if (state is! ProductLoaded) return [];
    return (state as ProductLoaded).products;
  }

  //-------------------------------------------------------------------------- favourite helper
  bool isFavourite(int productId) {
    if (state is! ProductLoaded) return false;
    return (state as ProductLoaded).favouriteIds.contains(productId);
  }

  //-------------------------------------------------------------------------- Favourites list
  List<ProductEntity> get favourites {
    if (state is! ProductLoaded) return [];
    final s = state as ProductLoaded;
    return s.products.where((p) => s.favouriteIds.contains(p.id)).toList();
  }

  //-------------------------------------------------------------------------- Recommended list
  Future<List<ProductEntity>> getRecommendedForProduct(int productId) async {
    return await getRecommended(productId);
  }

  //-------------------------------------------------------------------------- Review list
  Future<List<ReviewEntity>> getReviewsForProduct(int productId) async {
    return await getReviews(productId);
  }
}
