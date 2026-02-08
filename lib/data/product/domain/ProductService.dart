import 'package:ecommerce_app/common/entities/ProductEntity.dart';
import 'package:ecommerce_app/common/entities/ReviewEntity.dart';

import 'IProductRepository.dart';

//-------------------------------------------------------------------------- ProductService
class ProductService {
  final IProductRepository repository;
  ProductService(this.repository);

  Future<List<ProductEntity>> call({bool forceRefresh = false}) {
    return repository.getProducts(forceRefresh: forceRefresh);
  }
}

//-------------------------------------------------------------------------- GetProductByIdUseCase
class GetProductByIdUseCase {
  final IProductRepository repository;
  GetProductByIdUseCase(this.repository);

  Future<ProductEntity?> call(int id, {bool forceRefresh = false}) {
    return repository.getProductById(id, forceRefresh: forceRefresh);
  }
}

//-------------------------------------------------------------------------- GetRecommendedProductsUseCase
class GetRecommendedProductsUseCase {
  final IProductRepository repository;
  GetRecommendedProductsUseCase(this.repository);

  Future<List<ProductEntity>> call(int id, {bool forceRefresh = false}) {
    return repository.getRecommendedForProduct(id, forceRefresh: forceRefresh);
  }
}

//-------------------------------------------------------------------------- GetReviewsProductsUseCase
class GetReviewsProductsUseCase {
  final IProductRepository repository;
  GetReviewsProductsUseCase(this.repository);

  Future<List<ReviewEntity>> call(int id, {bool forceRefresh = false}) {
    return repository.getReviewsForProduct(id, forceRefresh: forceRefresh);
  }
}
