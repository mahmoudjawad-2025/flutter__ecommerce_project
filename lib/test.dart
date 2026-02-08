import 'package:ecommerce_app/core/routing/AppRoutes.dart';
import 'package:ecommerce_app/common/entities/ProductEntity.dart';
import 'package:ecommerce_app/logic/product/cart_logic/CartCubit.dart';
import 'package:ecommerce_app/logic/product/product_details_logic/product_details_cubit.dart';
import 'package:ecommerce_app/logic/product/product_logic/product_cubit.dart';
import 'package:ecommerce_app/common/models/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProductDetailsPage1 extends StatelessWidget {
  final int productId;
  const ProductDetailsPage1({super.key, required this.productId});

  //-------------------------------------------------------------------------- inital part
  @override
  Widget build(BuildContext context) {
    // Load product when page opens
    context.read<ProductCubit>().loadProductDetails(productId);

    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is! ProductLoaded || state.currentProduct == null) {
          if (state is ProductError) {
            return Scaffold(body: Center(child: Text(state.message)));
          }
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        // Loaded state
        final product = state.currentProduct;
        if (product == null) {
          return const Scaffold(body: Center(child: Text('Product not found')));
        }

        return _ProductDetailsContent(product: product);
      },
    );
  }
}
// class ProductDetailsPage extends StatelessWidget {
//   final int productId;
//   const ProductDetailsPage({super.key, required this.productId});

//   @override
//   Widget build(BuildContext context) {
//     // Load product immediately
//     context.read<ProductCubit>().loadProductDetails(productId);

//     return BlocListener<ProductCubit, ProductState>(
//       listener: (context, state) {
//         // When route parameters change, reload the product
//         final currentRouteProductId = productId;
//         if (state is ProductLoaded && state.currentProduct != null) {
//           if (state.currentProduct!.id != currentRouteProductId) {
//             context.read<ProductCubit>().loadProductDetails(
//               currentRouteProductId,
//             );
//           }
//         }
//       },
//       child: BlocBuilder<ProductCubit, ProductState>(
//         builder: (context, state) {
//           if (state is! ProductLoaded || state.currentProduct == null) {
//             if (state is ProductError) {
//               return Scaffold(body: Center(child: Text(state.message)));
//             }
//             return const Scaffold(
//               body: Center(child: CircularProgressIndicator()),
//             );
//           }

//           final product = state.currentProduct!;
//           // Ensure we're showing the correct product for this route
//           if (product.id != productId) {
//             return const Scaffold(
//               body: Center(child: CircularProgressIndicator()),
//             );
//           }

//           return _ProductDetailsContent(product: product);
//         },
//       ),
//     );
//   }
// }

//-------------------------------------------------------------------------- Main Content
class _ProductDetailsContent extends StatelessWidget {
  final ProductEntity product;
  const _ProductDetailsContent({required this.product});

  @override
  Widget build(BuildContext context) {
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
}

//-------------------------------------------------------------------------- Product Info
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
                    leading: const CircleAvatar(
                      backgroundImage: NetworkImage(
                        "https://i.pravatar.cc/150",
                      ),
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












//================================================================================








// class ProductDetailsPage extends StatefulWidget {
//   final int productId;
//   const ProductDetailsPage({super.key, required this.productId});

//   @override
//   State<ProductDetailsPage> createState() => _ProductDetailsPageState();
// }

// class _ProductDetailsPageState extends State<ProductDetailsPage> {
//   // @override
//   // void didUpdateWidget(ProductDetailsPage oldWidget) {
//   //   super.didUpdateWidget(oldWidget);
//   //   // ✅ Detect when productId changes (route parameter change)
//   //   if (oldWidget.productId != widget.productId) {
//   //     context.read<ProductCubit>().loadProductDetails(widget.productId);
//   //   }
//   // }

//   bool _loaded = false;

//   @override
//   void initState() {
//     super.initState();
//     if (!_loaded) {
//       context.read<ProductCubit>().loadProductDetails(widget.productId);
//       _loaded = true;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ProductCubit, ProductState>(
//       builder: (context, state) {
//         if (state is! ProductLoaded || state.currentProduct == null) {
//           if (state is ProductError) {
//             return Scaffold(body: Center(child: Text(state.message)));
//           }
//           return const Scaffold(
//             body: Center(child: CircularProgressIndicator()),
//           );
//         }
//         // Loaded state
//         final product = state.currentProduct;
//         if (product == null) {
//           return const Scaffold(body: Center(child: Text('Product not found')));
//         }

//         return _ProductDetailsContent(product: product);
//       },
//     );
//   }
// }

// //-------------------------------------------------------------------------- Main Content
// class _ProductDetailsContent extends StatelessWidget {
//   final ProductEntity product;
//   const _ProductDetailsContent({required this.product});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _ProductDetailsAppBar(product: product),
//       body: ListView(
//         children: [
//           _ImageCarousel(product: product),
//           _ProductInfo(product: product),
//           _QuantityAndPrice(product: product),
//           _AddToCartButton(product: product),
//           const Divider(),
//           _ReviewsSection(product: product),
//           const Divider(),
//           _RecommendedSection(product: product),
//           const SizedBox(height: 20),
//         ],
//       ),
//     );
//   }
// }

// //-------------------------------------------------------------------------- AppBar
// class _ProductDetailsAppBar extends StatelessWidget
//     implements PreferredSizeWidget {
//   final ProductEntity product;
//   const _ProductDetailsAppBar({required this.product});

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       title: Text(product.name),
//       actions: [
//         IconButton(
//           icon: const Icon(Icons.shopping_cart),
//           onPressed: () => context.push(AppRoutes.cart),
//         ),
//         BlocBuilder<ProductCubit, ProductState>(
//           buildWhen: (previous, current) {
//             if (previous is ProductLoaded && current is ProductLoaded) {
//               return previous.favouriteIds != current.favouriteIds;
//             }
//             return false;
//           },

//           builder: (context, state) {
//             final isFavourite = context.read<ProductCubit>().isFavourite(
//               product.id,
//             );
//             return IconButton(
//               onPressed: () =>
//                   context.read<ProductCubit>().toggleFavourite(product.id),
//               icon: Icon(
//                 isFavourite ? Icons.favorite : Icons.favorite_border,
//                 color: isFavourite ? Colors.red : null,
//               ),
//             );
//           },
//         ),
//       ],
//     );
//     ;
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }

// //-------------------------------------------------------------------------- Image Carousel
// class _ImageCarousel extends StatelessWidget {
//   final ProductEntity product;
//   const _ImageCarousel({required this.product});

//   @override
//   Widget build(BuildContext context) {
//     final detailsCubit = context.read<ProductDetailsCubit>();

//     return Column(
//       children: [
//         //-------------------------------------------------------------------------- Main Image (Never rebuilds)
//         SizedBox(
//           height: 300,
//           child: PageView.builder(
//             controller: detailsCubit.pageController,
//             itemCount: product.images.length,
//             onPageChanged: detailsCubit.setMainImage,
//             itemBuilder: (context, i) {
//               return Image.network(
//                 product.images[i],
//                 fit: BoxFit.cover,
//                 loadingBuilder: (c, child, progress) {
//                   return progress == null
//                       ? child
//                       : const Center(child: CircularProgressIndicator());
//                 },
//               );
//             },
//           ),
//         ),
//         const SizedBox(height: 8),
//         _ImageThumbnails(product: product),
//       ],
//     );
//   }
// }

// //-------------------------------------------------------------------------- Only thumbnails rebuild when selection changes
// class _ImageThumbnails extends StatelessWidget {
//   final ProductEntity product;
//   const _ImageThumbnails({required this.product});

//   @override
//   Widget build(BuildContext context) {
//     final detailsCubit = context.read<ProductDetailsCubit>();

//     return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
//       buildWhen: (previous, current) =>
//           previous.mainImageIndex != current.mainImageIndex,
//       builder: (context, state) {
//         return SizedBox(
//           height: 64,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             padding: const EdgeInsets.symmetric(horizontal: 12),
//             itemCount: product.images.length,
//             itemBuilder: (context, i) {
//               final isSelected = i == state.mainImageIndex;
//               return GestureDetector(
//                 onTap: () {
//                   detailsCubit.setMainImage(i);
//                   detailsCubit.animateToPage(i);
//                 },
//                 child: Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 6),
//                   width: 64,
//                   height: 64,
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: isSelected ? Colors.teal : Colors.grey.shade300,
//                       width: 2,
//                     ),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(6),
//                     child: Image.network(product.images[i], fit: BoxFit.cover),
//                   ),
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }

// //-------------------------------------------------------------------------- Product Info
// class _ProductInfo extends StatelessWidget {
//   final ProductEntity product;
//   const _ProductInfo({required this.product});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(product.name, style: Theme.of(context).textTheme.headlineSmall),
//           const SizedBox(height: 6),
//           Row(
//             children: [
//               ...List.generate(5, (i) {
//                 return Icon(
//                   Icons.star,
//                   size: 18,
//                   color: i < product.rating.floor()
//                       ? Colors.amber
//                       : Colors.grey.shade300,
//                 );
//               }),
//               const SizedBox(width: 8),
//               Text(product.rating.toStringAsFixed(1)),
//               const SizedBox(width: 6),
//               Text(
//                 "(${product.reviews.length} reviews)",
//                 style: const TextStyle(color: Colors.grey),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Text(product.description),
//         ],
//       ),
//     );
//   }
// }

// //-------------------------------------------------------------------------- Quantity & Price
// class _QuantityAndPrice extends StatelessWidget {
//   final ProductEntity product;
//   const _QuantityAndPrice({required this.product});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
//       buildWhen: (previous, current) => previous.quantity != current.quantity,
//       builder: (context, state) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Row(
//             children: [
//               IconButton(
//                 onPressed: context.read<ProductDetailsCubit>().decreaseQuantity,
//                 icon: const Icon(Icons.remove),
//               ),
//               Text(
//                 "${state.quantity}",
//                 style: Theme.of(context).textTheme.titleMedium,
//               ),
//               IconButton(
//                 onPressed: context.read<ProductDetailsCubit>().increaseQuantity,
//                 icon: const Icon(Icons.add),
//               ),
//               const Spacer(),
//               Text(
//                 "\$${(product.price * state.quantity).toStringAsFixed(2)}",
//                 style: Theme.of(context).textTheme.headlineSmall,
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// //-------------------------------------------------------------------------- Add to Cart Button
// class _AddToCartButton extends StatelessWidget {
//   final ProductEntity product;
//   const _AddToCartButton({required this.product});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: ElevatedButton(
//         onPressed: () {
//           // Get the current quantity directly when pressed
//           final quantity = context.read<ProductDetailsCubit>().state.quantity;
//           context.read<CartCubit>().addToCart(product, quantity: quantity);
//         },
//         child: const Text('Add to Cart'), // This never changes
//       ),
//     );
//   }
// }

// //-------------------------------------------------------------------------- Reviews Section
// class _ReviewsSection extends StatelessWidget {
//   final ProductEntity product;
//   const _ReviewsSection({required this.product});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               const Text(
//                 "Reviews",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               const Spacer(),
//               TextButton(
//                 onPressed: () =>
//                     context.push(AppRoutes.reviewWithParameters(product.id)),
//                 child: const Text("See All"),
//               ),
//             ],
//           ),
//           ...product.reviews
//               .take(2)
//               .map(
//                 (r) => Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 8),
//                   child: ListTile(
//                     leading: const CircleAvatar(
//                       backgroundImage: NetworkImage(
//                         "https://i.pravatar.cc/150",
//                       ),
//                     ),
//                     title: Text(r.userName),
//                     subtitle: Text(r.comment),
//                     trailing: Text(r.rating.toString()),
//                   ),
//                 ),
//               ),
//         ],
//       ),
//     );
//   }
// }

// //-------------------------------------------------------------------------- Recommended Section
// class _RecommendedSection extends StatelessWidget {
//   final ProductEntity product;
//   const _RecommendedSection({required this.product});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Row(
//             children: [
//               const Text(
//                 "Recommended for you",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               const Spacer(),
//               TextButton(
//                 onPressed: () => context.push(
//                   AppRoutes.recommendationWithParameters(product.id),
//                 ),
//                 child: const Text("See All"),
//               ),
//             ],
//           ),
//         ),
//         FutureBuilder<List<ProductEntity>>(
//           future: context.read<ProductCubit>().getRecommendedForProduct(
//             product.id,
//           ),
//           builder: (context, snap) {
//             if (snap.connectionState != ConnectionState.done) {
//               return const Center(child: CircularProgressIndicator());
//             }
//             final recs = snap.data ?? [];
//             return SizedBox(
//               height: 220,
//               child: ListView.builder(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 scrollDirection: Axis.horizontal,
//                 itemCount: recs.length,
//                 itemBuilder: (context, i) {
//                   final p = recs[i];
//                   return Container(
//                     width: 150,
//                     margin: const EdgeInsets.only(right: 12),
//                     child: ProductCard(product: p),
//                   );
//                 },
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }
// }















//==================================================================================================










// this initial correct working page code


// import 'package:ecommerce_app/core/routing/AppRoutes.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ecommerce_app/features/product/logic/cart_logic/CartCubit.dart';
// import 'package:ecommerce_app/features/product/domain/entities/ReviewEntity.dart';
// import 'package:ecommerce_app/features/product/logic/product_logic/product_cubit.dart';
// import 'package:ecommerce_app/features/product/logic/product_details_logic/product_details_cubit.dart';
// import 'package:go_router/go_router.dart';
// import '../../domain/entities/ProductEntity.dart';
// import '../models/product_card.dart';
// import 'reviews_page.dart';
// import 'recommendations_page.dart';

// class ProductDetailsPage extends StatelessWidget {
//   final int productId;
//   const ProductDetailsPage({super.key, required this.productId});

//   @override
//   Widget build(BuildContext context) {
//     final productCubit = context.watch<ProductCubit>();

//     // final pageController = PageController();

//     return FutureBuilder<ProductEntity?>(
//       future: productCubit.getProductById(productId),
//       builder: (context, snapshot) {
//         // Show loading while waiting for data
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Scaffold(
//             body: Center(child: CircularProgressIndicator()),
//           );
//         }

//         // Show error if something went wrong
//         if (snapshot.hasError) {
//           return Scaffold(
//             body: Center(child: Text('Error: ${snapshot.error}')),
//           );
//         }

//         // Show message if product not found
//         if (!snapshot.hasData || snapshot.data == null) {
//           return const Scaffold(body: Center(child: Text('Product not found')));
//         }

//         // We have the product data now
//         final ProductEntity product = snapshot.data!;
//         final pageController = PageController();

//         return BlocProvider(
//           create: (_) => ProductDetailsCubit(),
//           child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
//             builder: (context, state) {
//               final detailsCubit = context.read<ProductDetailsCubit>();

//               return Scaffold(
//                 appBar: AppBar(
//                   title: Text(product.name),
//                   actions: [
//                     IconButton(
//                       icon: const Icon(Icons.shopping_cart),
//                       onPressed: () => context.push(AppRoutes.cart),
//                     ),
//                     IconButton(
//                       onPressed: () => productCubit.toggleFavourite(product.id),
//                       icon: Icon(
//                         productCubit.isFavourite(product.id)
//                             ? Icons.favorite
//                             : Icons.favorite_border,
//                         color: productCubit.isFavourite(product.id)
//                             ? Colors.red
//                             : null,
//                       ),
//                     ),
//                   ],
//                 ),
//                 body: ListView(
//                   children: [
//                     // ---- Carousel ----
//                     SizedBox(
//                       height: 300,
//                       child: PageView.builder(
//                         controller: pageController,
//                         itemCount: product.images.length,
//                         onPageChanged: (i) => detailsCubit.setMainImage(i),
//                         itemBuilder: (context, i) {
//                           final img = product.images[i];
//                           return Image.network(
//                             img,
//                             fit: BoxFit.cover,
//                             loadingBuilder: (c, child, progress) {
//                               if (progress == null) return child;
//                               return const Center(
//                                 child: CircularProgressIndicator(),
//                               );
//                             },
//                           );
//                         },
//                       ),
//                     ),

//                     const SizedBox(height: 8),
//                     SizedBox(
//                       height: 64,
//                       child: ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         padding: const EdgeInsets.symmetric(horizontal: 12),
//                         itemCount: product.images.length,
//                         itemBuilder: (context, i) {
//                           final img = product.images[i];
//                           final isSelected = i == state.mainImageIndex;
//                           return GestureDetector(
//                             onTap: () {
//                               detailsCubit.setMainImage(i);
//                               pageController.animateToPage(
//                                 i,
//                                 duration: const Duration(milliseconds: 350),
//                                 curve: Curves.easeInOut,
//                               );
//                             },
//                             child: Container(
//                               margin: const EdgeInsets.symmetric(horizontal: 6),
//                               width: 64,
//                               height: 64,
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                   color: isSelected
//                                       ? Colors.teal
//                                       : Colors.grey.shade300,
//                                   width: 2,
//                                 ),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(6),
//                                 child: Image.network(img, fit: BoxFit.cover),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),

//                     const SizedBox(height: 12),

//                     // ---- Name + rating + reviews ----
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             product.name,
//                             style: Theme.of(context).textTheme.headlineSmall,
//                           ),
//                           const SizedBox(height: 6),
//                           Row(
//                             children: [
//                               ...List.generate(5, (i) {
//                                 return Icon(
//                                   Icons.star,
//                                   size: 18,
//                                   color: i < product.rating.floor()
//                                       ? Colors.amber
//                                       : Colors.grey.shade300,
//                                 );
//                               }),
//                               const SizedBox(width: 8),
//                               Text(product.rating.toStringAsFixed(1)),
//                               const SizedBox(width: 6),
//                               Text(
//                                 "(${product.reviews.length} reviews)",
//                                 style: const TextStyle(color: Colors.grey),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 8),
//                           Text(product.description),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 16),

//                     // ---- Quantity + price ----
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: Row(
//                         children: [
//                           IconButton(
//                             onPressed: detailsCubit.decreaseQuantity,
//                             icon: const Icon(Icons.remove),
//                           ),
//                           Text(
//                             "${state.quantity}",
//                             style: Theme.of(context).textTheme.titleMedium,
//                           ),
//                           IconButton(
//                             onPressed: detailsCubit.increaseQuantity,
//                             icon: const Icon(Icons.add),
//                           ),
//                           const Spacer(),
//                           Text(
//                             "\$${(product.price * state.quantity).toStringAsFixed(2)}",
//                             style: Theme.of(context).textTheme.headlineSmall,
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(16),
//                       child: ElevatedButton(
//                         onPressed: () {
//                           context.read<CartCubit>().addToCart(
//                             product,
//                             quantity: state.quantity,
//                           );
//                         },
//                         child: const Text('Add to Cart'),
//                       ),
//                     ),
//                     const Divider(),

//                     // ---- Reviews ----
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: Row(
//                         children: [
//                           const Text(
//                             "Reviews",
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const Spacer(),
//                           TextButton(
//                             onPressed: () => context.push(
//                               AppRoutes.reviewWithParameters(product.id),
//                             ),
//                             child: const Text("See All"),
//                           ),
//                         ],
//                       ),
//                     ),
//                     ...product.reviews
//                         .take(2)
//                         .map(
//                           (r) => Padding(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 16,
//                               vertical: 8,
//                             ),
//                             child: _buildReviewItem(r),
//                           ),
//                         ),

//                     const Divider(),

//                     // ---- Recommended ----
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: Row(
//                         children: [
//                           const Text(
//                             "Recommended for you",
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const Spacer(),
//                           TextButton(
//                             onPressed: () => context.push(
//                               AppRoutes.recommendationWithParameters(
//                                 product.id,
//                               ),
//                             ),

//                             child: const Text("See All"),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 220,
//                       child: FutureBuilder<List<ProductEntity>>(
//                         future: productCubit.getRecommendedForProduct(
//                           product.id,
//                         ),
//                         builder: (context, snap) {
//                           if (snap.connectionState != ConnectionState.done) {
//                             return const Center(
//                               child: CircularProgressIndicator(),
//                             );
//                           }
//                           final recs = snap.data ?? [];
//                           if (recs.isEmpty) {
//                             return const Center(
//                               child: Padding(
//                                 padding: EdgeInsets.all(12),
//                                 child: Text("No recommendations."),
//                               ),
//                             );
//                           }
//                           return ListView.builder(
//                             padding: const EdgeInsets.symmetric(horizontal: 16),
//                             scrollDirection: Axis.horizontal,
//                             itemCount: recs.length,
//                             itemBuilder: (context, i) {
//                               final p = recs[i];
//                               return Container(
//                                 width: 150,
//                                 margin: const EdgeInsets.only(right: 12),
//                                 child: ProductCard(product: p),
//                               );
//                             },
//                           );
//                         },
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                   ],
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildReviewItem(ReviewEntity r) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 CircleAvatar(
//                   radius: 20,
//                   backgroundImage: NetworkImage(
//                     "https://i.pravatar.cc/150?u=${r.userName}",
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       r.userName,
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       r.location,
//                       style: const TextStyle(fontSize: 12, color: Colors.grey),
//                     ),
//                   ],
//                 ),
//                 const Spacer(),
//                 Row(
//                   children: [
//                     const Icon(Icons.star, color: Colors.amber, size: 16),
//                     const SizedBox(width: 4),
//                     Text(r.rating.toString()),
//                   ],
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             Text(r.comment),
//           ],
//         ),
//       ),
//     );
//   }
// }
