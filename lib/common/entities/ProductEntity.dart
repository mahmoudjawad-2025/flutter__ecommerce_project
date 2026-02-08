import 'package:ecommerce_app/common/entities/ReviewEntity.dart';

class ProductEntity {
  final int id;
  final String name;
  final String description;
  final double price;
  final double rating; // avg of review rates
  final List<String> images;
  final List<ReviewEntity> reviews;
  final List<int> recommendedIds;

  ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.images,
    required this.reviews,
    required this.recommendedIds,
  }) : rating = _calculateRating(reviews);

  static double _calculateRating(List<ReviewEntity> reviews) {
    if (reviews.isEmpty) return 0.0;
    final total = reviews.map((r) => r.rating).reduce((a, b) => a + b);
    return total / reviews.length;
  }
}
