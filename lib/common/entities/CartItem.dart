import 'package:ecommerce_app/common/entities/ProductEntity.dart';

class CartItem {
  final ProductEntity product;
  int quantity;
  CartItem({required this.product, this.quantity = 1});
}
