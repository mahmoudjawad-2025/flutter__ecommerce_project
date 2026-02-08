import 'package:ecommerce_app/common/entities/CartItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/logic/product/cart_logic/CartCubit.dart';
import 'package:ecommerce_app/common/models/product_card.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Cart')),
      body: Column(
        children: [
          //-------------------------------------------------------------------------- Cart Items List
          Expanded(
            child: BlocBuilder<CartCubit, CartState>(
              buildWhen: (previous, current) => previous.items != current.items,
              builder: (context, state) {
                if (state.items.isEmpty) {
                  return const Center(child: Text('Cart is empty'));
                }

                return ListView.builder(
                  itemCount: state.items.length,
                  itemBuilder: (context, index) {
                    final item = state.items[index];
                    return _CartItem(item: item);
                  },
                );
              },
            ),
          ),
          //-------------------------------------------------------------------------- Total Price
          BlocBuilder<CartCubit, CartState>(
            buildWhen: (previous, current) => previous.items != current.items,
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Total: \$${state.totalPrice.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

//-------------------------------------------------------------------------- Separate Widget for Cart Item (Prevents rebuild of entire list)
class _CartItem extends StatelessWidget {
  final CartItem item;

  const _CartItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ProductCard(product: item.product),
        Positioned(
          right: 8,
          top: 8,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle),
                onPressed: () {
                  context.read<CartCubit>().decreaseQuantity(item.product);
                },
              ),
              Text('${item.quantity}'),
              IconButton(
                icon: const Icon(Icons.add_circle),
                onPressed: () {
                  context.read<CartCubit>().addToCart(item.product);
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  context.read<CartCubit>().removeItem(item.product);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
