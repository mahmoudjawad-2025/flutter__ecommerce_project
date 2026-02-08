import 'package:ecommerce_app/core/routing/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../common/entities/ProductEntity.dart';

class ProductsListPage extends StatelessWidget {
  final List<ProductEntity> products;
  const ProductsListPage({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Recommended Products")),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, i) {
          final p = products[i];
          return ListTile(
            leading: Image.network(
              p.images.first,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
            title: Text(p.name),
            subtitle: Text("\$${p.price}"),
            onTap: () =>
                context.push(AppRoutes.productDetailWithParameters(p.id)),
          );
        },
      ),
    );
  }
}
