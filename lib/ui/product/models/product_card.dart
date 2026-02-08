// lib/features/products/presentation/product_card.dart
import 'package:ecommerce_app/core/routing/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/common/entities/ProductEntity.dart';
import 'package:go_router/go_router.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    //-------------------------------------------------------------------------- vars
    final image = product.images.isNotEmpty ? product.images.first : null;
    return GestureDetector(
      onTap: () =>
          context.push(AppRoutes.productDetailWithParameters(product.id)),
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            //-------------------------------------------------------------------------- img != null
            if (image != null)
              AspectRatio(
                aspectRatio: 1,
                child: Image.network(image, fit: BoxFit.cover),
              ),
            //-------------------------------------------------------------------------- else
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "\$${product.price.toStringAsFixed(2)}",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
