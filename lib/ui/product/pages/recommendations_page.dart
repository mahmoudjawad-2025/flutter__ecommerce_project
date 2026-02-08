import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/logic/product/product_logic/product_cubit.dart';
import '../../../common/entities/ProductEntity.dart';
import '../../../common/models/product_card.dart';

class RecommendationsPage extends StatelessWidget {
  final int productId;
  const RecommendationsPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final recommended = context.read<ProductCubit>().getRecommendedForProduct(
      productId,
    );

    return Scaffold(
      //-------------------------------------------------------------------------- app bar + future list
      appBar: AppBar(title: const Text('Recommended Products')),
      body: FutureBuilder<List<ProductEntity>>(
        future: recommended,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final list = snap.data ?? [];
          if (list.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Text('No recommendations found.'),
              ),
            );
          }
          //-------------------------------------------------------------------------- items
          return GridView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: list.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: .7,
            ),
            itemBuilder: (context, i) {
              final p = list[i];
              return ProductCard(product: p);
            },
          );
        },
      ),
    );
  }
}
