import 'package:ecommerce_app/common/entities/ProductEntity.dart';
import 'package:ecommerce_app/common/entities/ReviewEntity.dart';

abstract class IProductRepository {
  //-------------------------------------------------------------------------- getProducts
  Future<List<ProductEntity>> getProducts({bool forceRefresh = false});
  //-------------------------------------------------------------------------- getProductById
  Future<ProductEntity?> getProductById(int id, {bool forceRefresh = false});
  //-------------------------------------------------------------------------- getRecommendedForProduct
  Future<List<ProductEntity>> getRecommendedForProduct(
    int id, {
    bool forceRefresh = false,
  });
  //-------------------------------------------------------------------------- getReviewsForProduct
  Future<List<ReviewEntity>> getReviewsForProduct(
    int id, {
    bool forceRefresh = false,
  });
}
