import 'dart:convert';
import 'package:ecommerce_app/common/entities/ReviewEntity.dart';
import 'package:ecommerce_app/core/services/api_c;ient.dart';
import 'package:ecommerce_app/data/product/ProductModel.dart';

class ProductApi {
  final ApiClient client;
  final bool useFake;

  ProductApi({required this.client, this.useFake = false});

  //-------------------------------------------------------------------------- seed data
  final List<ProductModel> _seedProducts = [
    ProductModel(
      id: 1,
      name: 'Oil',
      description: 'Experience lightning-fast loading...',
      price: 519.99,
      // rating: 4.3,
      images: [
        "https://media.istockphoto.com/id/1320934166/photo/cosmetic-skin-care-products-on-green-leaves.jpg?s=612x612&w=0&k=20&c=X4pwnTaBzXHDOGZlcdJdlKxmYd__61xboHVIiR5JMIk=",
        "https://img.freepik.com/premium-photo/composition-with-natural-organic-cosmetic-product-illustration-ai-generative_118124-13187.jpg",
      ],
      reviews: [
        ReviewEntity(
          userName: "user1",
          location: 'location1',
          rating: 1.2,
          comment: 'comment1',
          imageUrl: "",
        ),
      ],
      recommendedIds: [2, 3],
    ),
    ProductModel(
      id: 2,
      name: 'Camera',
      description: 'High quality wireless headphones',
      price: 99.99,
      // rating: 4.7,
      images: [
        "https://t4.ftcdn.net/jpg/07/84/39/55/360_F_784395578_ZQcFO0hxlzT8dDowalW1eF2GTq7BJ9Mo.jpg",
        "https://images.pexels.com/photos/90946/pexels-photo-90946.jpeg?cs=srgb&dl=pexels-madebymath-90946.jpg&fm=jpg",
        "https://www.toolbox-studio.com/blog/wp-content/uploads/2019/10/3d-product-modeling_new.jpg",
      ],
      reviews: [
        ReviewEntity(
          userName: "user2",
          location: 'location2',
          rating: 2.5,
          comment: 'star 2.5',
          imageUrl: "",
        ),
        ReviewEntity(
          userName: "user3",
          location: 'location3',
          rating: 3.8,
          comment: 'star 3.8',
          imageUrl: "",
        ),
        ReviewEntity(
          userName: "user4",
          location: 'location4',
          rating: 4.9,
          comment: 'star 4.9',
          imageUrl: "",
        ),
      ],
      recommendedIds: [1],
    ),
    ProductModel(
      id: 3,
      name: 'Laptop',
      description: 'High quality wireless headphones',
      price: 29.99,
      // rating: 4.7,
      images: [
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTtEaqpeqDfRZAyHBeY_yxCahZmKxSuqI0jWETlVZ7DwKdwNnVhDZpHADw4ADPQ04sErN0&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSZCJnzD7fPhfSoA8ZCVWfy17dzK4Fr7Q6P0dbg6mgunU7gIvKXDi3P7gewGWfPG_Kxgk&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4BnnkyCgs5tVtVTYQ99SRtzDzVFHUPHiAF7AEcen5ePxQmynBVgeK3fTbEvxPTDCTASg&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXz3Mc9zfm88P1i5V_kJxM5jRongq2_jWSEUDrG3O7qvf85dshu8g7Fzg8wZ6zqRknXpg&usqp=CAU",
        "https://img.freepik.com/premium-photo/side-view-modern-designer-office-desktop-with-empty-laptop-reflections-screen-coffee-cup-window-with-city-view-background-3d-rendering_670147-76344.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSf3qR2VX4R9jTPhYZ7DsEXfWp-WkqX1lEWema2e13iAjtIqCGlFAcD0Xn4bxDu4TzaVXo&usqp=CAU",
        "https://img.freepik.com/premium-photo/open-laptop-computer-with-coffee-cup-notebook-white-table-blank-wall-background_67155-3268.jpg",
      ],
      reviews: [
        ReviewEntity(
          userName: "user2",
          location: 'location2',
          rating: 2.5,
          comment: 'star 2.5',
          imageUrl: "",
        ),
        ReviewEntity(
          userName: "user3",
          location: 'location3',
          rating: 3.8,
          comment: 'star 3.8',
          imageUrl: "",
        ),
        ReviewEntity(
          userName: "user4",
          location: 'location4',
          rating: 4.9,
          comment: 'star 4.9',
          imageUrl: "",
        ),
      ],
      recommendedIds: [2],
    ),
  ];

  //-------------------------------------------------------------------------- fetchProducts
  Future<List<ProductModel>> fetchProducts({bool forceRefresh = false}) async {
    if (useFake) {
      await Future.delayed(const Duration(milliseconds: 300));
      return _seedProducts;
    }
    final res = await client.get('/products');
    final jsonList = jsonDecode(res.body) as List;
    return jsonList.map((e) => ProductModel.fromJson(e)).toList();
  }

  //-------------------------------------------------------------------------- product by id
  Future<ProductModel?> fetchProductById(
    int id, {
    bool forceRefresh = false,
  }) async {
    if (useFake) {
      await Future.delayed(const Duration(milliseconds: 200));
      try {
        return _seedProducts.firstWhere((p) => p.id == id);
      } catch (_) {
        return null;
      }
    }
    final res = await client.get('/products/$id');
    if (res.statusCode == 200) {
      return ProductModel.fromJson(jsonDecode(res.body));
    }
    return null;
  }
}
