import 'package:ecommerce_app/common/entities/ProductEntity.dart';
import 'package:ecommerce_app/common/entities/ReviewEntity.dart';
import 'package:ecommerce_app/data/product/ProductApi.dart';
import 'package:ecommerce_app/data/product/domain/IProductRepository.dart';

class ProductRepository implements IProductRepository {
  final ProductApi api;
  ProductRepository({required this.api});

  //-------------------------------------------------------------------------- caching
  List<ProductEntity>? _cachedProducts;
  final Map<int, ProductEntity> _cachedById = {};
  DateTime? _lastFetchTime;
  final Duration cacheDuration = const Duration(minutes: 10);

  //-------------------------------------------------------------------------- get products
  @override
  Future<List<ProductEntity>> getProducts({bool forceRefresh = false}) async {
    final validCache =
        _cachedProducts != null &&
        _lastFetchTime != null &&
        DateTime.now().difference(_lastFetchTime!) < cacheDuration;

    if (!forceRefresh && validCache) return _cachedProducts!;

    final models = await api.fetchProducts();
    _cachedProducts = models;
    _lastFetchTime = DateTime.now();
    for (final p in models) {
      _cachedById[p.id] = p;
    }
    return _cachedProducts!;
  }

  //-------------------------------------------------------------------------- get by id
  @override
  Future<ProductEntity?> getProductById(
    int id, {
    bool forceRefresh = false,
  }) async {
    if (!forceRefresh && _cachedById.containsKey(id)) return _cachedById[id];

    final model = await api.fetchProductById(id);
    if (model != null) {
      _cachedById[id] = model;
      _cachedProducts ??= [model];
    }
    return model;
  }

  //-------------------------------------------------------------------------- get recomendations
  @override
  Future<List<ProductEntity>> getRecommendedForProduct(
    int id, {
    bool forceRefresh = false,
  }) async {
    final product = await getProductById(id, forceRefresh: forceRefresh);
    if (product == null) return [];
    final list = <ProductEntity>[];
    for (final rid in product.recommendedIds) {
      final r = await getProductById(rid, forceRefresh: forceRefresh);
      if (r != null) list.add(r);
    }
    return list;
  }

  //-------------------------------------------------------------------------- get recomendations
  @override
  Future<List<ReviewEntity>> getReviewsForProduct(
    int id, {
    bool forceRefresh = false,
  }) async {
    final product = await getProductById(id, forceRefresh: forceRefresh);
    if (product == null) return [];
    final list = product.reviews;
    return list;
  }

  //-------------------------------------------------------------------------- clear cache
  void clearCache() {
    _cachedProducts = null;
    _cachedById.clear();
    _lastFetchTime = null;
  }
}
