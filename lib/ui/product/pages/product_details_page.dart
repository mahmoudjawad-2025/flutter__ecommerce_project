import 'package:ecommerce_app/core/routing/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/logic/product/cart_logic/CartCubit.dart';
import 'package:ecommerce_app/logic/product/product_logic/product_cubit.dart';
import 'package:ecommerce_app/logic/product/product_details_logic/product_details_cubit.dart';
import 'package:go_router/go_router.dart';
import '../../../common/entities/ProductEntity.dart';
import '../../../common/models/product_card.dart';

class ProductDetailsPage extends StatelessWidget {
  final int productId;
  const ProductDetailsPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    //-------------------------------------------------------------------------- cubit + future + states with data
    final productCubit = context.read<ProductCubit>();
    return FutureBuilder<ProductEntity?>(
      future: productCubit.getProductById(productId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }
        if (!snapshot.hasData || snapshot.data == null) {
          return const Scaffold(body: Center(child: Text('Product not found')));
        }
        final ProductEntity product = snapshot.data!;

        //-------------------------------------------------------------------------- main
        return Scaffold(
          appBar: _ProductDetailsAppBar(product: product),
          body: ListView(
            children: [
              _ImageCarousel(product: product),
              _ProductInfo(product: product),
              _QuantityAndPrice(product: product),
              _AddToCartButton(product: product),
              const Divider(),
              _ReviewsSection(product: product),
              const Divider(),
              _RecommendedSection(product: product),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}

//-------------------------------------------------------------------------- AppBar
class _ProductDetailsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final ProductEntity product;
  const _ProductDetailsAppBar({required this.product});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(product.name),
      actions: [
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () => context.push(AppRoutes.cart),
        ),
        BlocBuilder<ProductCubit, ProductState>(
          buildWhen: (previous, current) {
            if (previous is ProductLoaded && current is ProductLoaded) {
              return previous.favouriteIds != current.favouriteIds;
            }
            return false;
          },

          builder: (context, state) {
            final isFavourite = context.read<ProductCubit>().isFavourite(
              product.id,
            );
            return IconButton(
              onPressed: () =>
                  context.read<ProductCubit>().toggleFavourite(product.id),
              icon: Icon(
                isFavourite ? Icons.favorite : Icons.favorite_border,
                color: isFavourite ? Colors.red : null,
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

//-------------------------------------------------------------------------- Image Carousel
class _ImageCarousel extends StatelessWidget {
  final ProductEntity product;
  const _ImageCarousel({required this.product});

  @override
  Widget build(BuildContext context) {
    final detailsCubit = context.read<ProductDetailsCubit>();

    return Column(
      children: [
        //-------------------------------------------------------------------------- Main Image (Never rebuilds)
        SizedBox(
          height: 300,
          child: PageView.builder(
            controller: detailsCubit.pageController,
            itemCount: product.images.length,
            onPageChanged: detailsCubit.setMainImage,
            itemBuilder: (context, i) {
              return Image.network(
                product.images[i],
                fit: BoxFit.cover,
                loadingBuilder: (c, child, progress) {
                  return progress == null
                      ? child
                      : const Center(child: CircularProgressIndicator());
                },
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        _ImageThumbnails(product: product),
      ],
    );
  }
}

//-------------------------------------------------------------------------- Only thumbnails rebuild when selection changes
class _ImageThumbnails extends StatelessWidget {
  final ProductEntity product;
  const _ImageThumbnails({required this.product});

  @override
  Widget build(BuildContext context) {
    final detailsCubit = context.read<ProductDetailsCubit>();

    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      buildWhen: (previous, current) =>
          previous.mainImageIndex != current.mainImageIndex,
      builder: (context, state) {
        return SizedBox(
          height: 64,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: product.images.length,
            itemBuilder: (context, i) {
              final isSelected = i == state.mainImageIndex;
              return GestureDetector(
                onTap: () {
                  detailsCubit.setMainImage(i);
                  detailsCubit.animateToPage(i);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isSelected ? Colors.teal : Colors.grey.shade300,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(product.images[i], fit: BoxFit.cover),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
} //-------------------------------------------------------------------------- Product Info

class _ProductInfo extends StatelessWidget {
  final ProductEntity product;
  const _ProductInfo({required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(product.name, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 6),
          Row(
            children: [
              ...List.generate(5, (i) {
                return Icon(
                  Icons.star,
                  size: 18,
                  color: i < product.rating.floor()
                      ? Colors.amber
                      : Colors.grey.shade300,
                );
              }),
              const SizedBox(width: 8),
              Text(product.rating.toStringAsFixed(1)),
              const SizedBox(width: 6),
              Text(
                "(${product.reviews.length} reviews)",
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(product.description),
        ],
      ),
    );
  }
}

//-------------------------------------------------------------------------- Quantity & Price
class _QuantityAndPrice extends StatelessWidget {
  final ProductEntity product;
  const _QuantityAndPrice({required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      buildWhen: (previous, current) => previous.quantity != current.quantity,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              IconButton(
                onPressed: context.read<ProductDetailsCubit>().decreaseQuantity,
                icon: const Icon(Icons.remove),
              ),
              Text(
                "${state.quantity}",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              IconButton(
                onPressed: context.read<ProductDetailsCubit>().increaseQuantity,
                icon: const Icon(Icons.add),
              ),
              const Spacer(),
              Text(
                "\$${(product.price * state.quantity).toStringAsFixed(2)}",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        );
      },
    );
  }
}

//-------------------------------------------------------------------------- Add to Cart Button
class _AddToCartButton extends StatelessWidget {
  final ProductEntity product;
  const _AddToCartButton({required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: () {
          // Get the current quantity directly when pressed
          final quantity = context.read<ProductDetailsCubit>().state.quantity;
          context.read<CartCubit>().addToCart(product, quantity: quantity);
        },
        child: const Text('Add to Cart'), // This never changes
      ),
    );
  }
}

//-------------------------------------------------------------------------- Reviews Section
class _ReviewsSection extends StatelessWidget {
  final ProductEntity product;
  const _ReviewsSection({required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                "Reviews",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              TextButton(
                onPressed: () =>
                    context.push(AppRoutes.reviewWithParameters(product.id)),
                child: const Text("See All"),
              ),
            ],
          ),
          ...product.reviews
              .take(2)
              .map(
                (r) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(r.imageUrl),
                    ),
                    title: Text(r.userName),
                    subtitle: Text(r.comment),
                    trailing: Text(r.rating.toString()),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}

//-------------------------------------------------------------------------- Recommended Section
class _RecommendedSection extends StatelessWidget {
  final ProductEntity product;
  const _RecommendedSection({required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              const Text(
                "Recommended for you",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => context.push(
                  AppRoutes.recommendationWithParameters(product.id),
                ),
                child: const Text("See All"),
              ),
            ],
          ),
        ),
        FutureBuilder<List<ProductEntity>>(
          future: context.read<ProductCubit>().getRecommendedForProduct(
            product.id,
          ),
          builder: (context, snap) {
            if (snap.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            final recs = snap.data ?? [];
            return SizedBox(
              height: 220,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: recs.length,
                itemBuilder: (context, i) {
                  final p = recs[i];
                  return Container(
                    width: 150,
                    margin: const EdgeInsets.only(right: 12),
                    child: ProductCard(product: p),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
