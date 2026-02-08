import 'package:ecommerce_app/common/widgets/FooterWidget.dart';
import 'package:ecommerce_app/core/routing/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ecommerce_app/logic/product/product_logic/product_cubit.dart';
import '../../common/models/product_card.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        actions: [
          IconButton(
            tooltip: 'Favourites',
            icon: const Icon(Icons.favorite),
            onPressed: () => context.push(AppRoutes.favourite),
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () => context.push(AppRoutes.cart),
          ),
        ],
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        buildWhen: (previous, current) => current is! ProductLoading,
        builder: (context, state) {
          //-------------------------------------------------------------------------- loading
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          //-------------------------------------------------------------------------- error
          if (state is ProductError) {
            return Center(child: Text(state.message));
          }
          //-------------------------------------------------------------------------- loaded
          if (state is ProductLoaded) {
            return CustomScrollView(
              slivers: [
                //-------------------------------------------------------------------------- GRID
                SliverPadding(
                  padding: const EdgeInsets.all(12),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final product = state.products[index];
                      return ProductCard(product: product);
                    }, childCount: state.products.length),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: .7,
                        ),
                  ),
                ),

                //-------------------------------------------------------------------------- FOOTER
                const SliverToBoxAdapter(child: FooterWidget()),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
