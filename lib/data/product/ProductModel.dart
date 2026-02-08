// lib/features/products/data/product_model.dart
import 'package:ecommerce_app/common/entities/ReviewEntity.dart';

import '../../common/entities/ProductEntity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    // required super.rating,
    required super.images,
    required super.reviews,
    required super.recommendedIds,
  });
  //-------------------------------------------------------------------------- fromJson
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      // rating: (json['rating'] as num).toDouble(),
      images: List<String>.from(json['images'] ?? []),
      reviews:
          (json['reviews'] as List<dynamic>?)
              ?.map(
                (r) => ReviewEntity(
                  userName: r['userName'] as String,
                  location: r['location'] as String,
                  rating: (r['rating'] as num).toDouble(),
                  comment: r['comment'] as String,
                  imageUrl: r['imageUrl'] as String,
                ),
              )
              .toList() ??
          [],
      recommendedIds:
          (json['recommendedIds'] as List<dynamic>?)?.cast<int>() ?? [],
    );
  }

  //-------------------------------------------------------------------------- toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'rating': rating,
      'images': images,
      'reviews': reviews
          .map(
            (r) => {
              'userName': r.userName,
              'location': r.location,
              'rating': r.rating,
              'comment': r.comment,
            },
          )
          .toList(),
      'recommendedIds': recommendedIds,
    };
  }
}
