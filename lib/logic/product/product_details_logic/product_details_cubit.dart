import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final PageController pageController = PageController();

  ProductDetailsCubit()
    : super(ProductDetailsState(quantity: 1, mainImageIndex: 0));
  //-------------------------------------------------------------------------- inc
  void increaseQuantity() => emit(state.copyWith(quantity: state.quantity + 1));

  //-------------------------------------------------------------------------- dec
  void decreaseQuantity() {
    if (state.quantity > 1) {
      emit(state.copyWith(quantity: state.quantity - 1));
    }
  }

  //-------------------------------------------------------------------------- set img
  void setMainImage(int index) => emit(state.copyWith(mainImageIndex: index));

  // method to animate page
  void animateToPage(int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  @override
  Future<void> close() {
    pageController.dispose(); // Don't forget to dispose!
    return super.close();
  }
}
