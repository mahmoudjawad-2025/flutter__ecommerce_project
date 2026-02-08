part of 'CartCubit.dart';

class CartState {
  final List<CartItem> items;
  CartState(this.items);

  double get totalPrice =>
      items.fold(0, (sum, item) => sum + item.product.price * item.quantity);
}
