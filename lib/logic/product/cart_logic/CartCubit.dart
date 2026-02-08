import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/common/entities/CartItem.dart';
import 'package:ecommerce_app/common/entities/ProductEntity.dart';
part 'CartState.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState([]));

  //-------------------------------------------------------------------------- add
  void addToCart(ProductEntity product, {int quantity = 1}) {
    final items = [...state.items];
    final index = items.indexWhere((e) => e.product.id == product.id);

    if (index != -1) {
      items[index].quantity += quantity;
    } else {
      items.add(CartItem(product: product, quantity: quantity));
    }
    emit(CartState(items));
  }

  //-------------------------------------------------------------------------- decrease
  void decreaseQuantity(ProductEntity product) {
    final items = [...state.items];
    final index = items.indexWhere((e) => e.product.id == product.id);
    if (index != -1) {
      if (items[index].quantity > 1) {
        items[index].quantity -= 1;
      } else {
        items.removeAt(index);
      }
      emit(CartState(items));
    }
  }

  //-------------------------------------------------------------------------- remove
  void removeItem(ProductEntity product) {
    final items = [...state.items]
      ..removeWhere((e) => e.product.id == product.id);
    emit(CartState(items));
  }

  //-------------------------------------------------------------------------- clear
  void clearCart() => emit(CartState([]));
}
