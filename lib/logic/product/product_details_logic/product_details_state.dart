part of 'product_details_cubit.dart';

class ProductDetailsState {
  final int quantity;
  final int mainImageIndex;

  ProductDetailsState({required this.quantity, required this.mainImageIndex});

  ProductDetailsState copyWith({int? quantity, int? mainImageIndex}) {
    return ProductDetailsState(
      quantity: quantity ?? this.quantity,
      mainImageIndex: mainImageIndex ?? this.mainImageIndex,
    );
  }
}
