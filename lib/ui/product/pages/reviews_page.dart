import 'package:ecommerce_app/logic/product/product_logic/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/common/entities/ReviewEntity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewsPage extends StatelessWidget {
  final int productId;
  const ReviewsPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    //-------------------------------------------------------------------------- vars + future + states
    final reviews = context.read<ProductCubit>().getReviewsForProduct(
      productId,
    );
    return Scaffold(
      appBar: AppBar(title: const Text("All Reviews")),
      body: FutureBuilder<List<ReviewEntity>>(
        future: reviews,
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
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, i) {
              final r = list[i];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(r.imageUrl),
                ),
                title: Text(r.userName),
                subtitle: Text(r.comment),
                trailing: Text(r.rating.toString()),
              );
            },
          );
        },
      ),
    );
  }
}
