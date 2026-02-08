part of 'product_cubit.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductEntity> products;
  final Set<int> favouriteIds;
  final ProductEntity? currentProduct;

  ProductLoaded({
    required this.products,
    required this.favouriteIds,
    this.currentProduct,
  });

  ProductLoaded copyWith({
    List<ProductEntity>? products,
    Set<int>? favouriteIds,
    ProductEntity? currentProduct,
  }) {
    return ProductLoaded(
      products: products ?? this.products,
      favouriteIds: favouriteIds ?? this.favouriteIds,
      currentProduct: currentProduct ?? this.currentProduct,
    );
  }
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}
