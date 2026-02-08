import 'package:flutter/material.dart';
import 'package:ecommerce_app/logic/product/product_logic/product_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/models/product_card.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductCubit>();
    return Scaffold(
      appBar: AppBar(title: const Text('Favourites')),
      body: BlocBuilder<ProductCubit, ProductState>(
        //-------------------------------------------------------------------------- states
        buildWhen: (previous, current) {
          if (previous is ProductLoaded && current is ProductLoaded) {
            return previous.favouriteIds != current.favouriteIds;
          }
          return false;
        },
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProductError) {
            return Center(child: Text(state.message));
          }

          final favourites = cubit.favourites;

          if (favourites.isEmpty) {
            return const Center(child: Text('No favourites yet'));
          } else {
            //-------------------------------------------------------------------------- items
            return GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: favourites.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: .7,
              ),
              itemBuilder: (context, index) {
                final product = favourites[index];
                return ProductCard(product: product);
              },
            );
          }
        },
      ),
    );
  }
}
