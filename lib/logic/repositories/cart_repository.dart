import '../logic.dart';

abstract class CartRepository {
  final _delay = const Duration(milliseconds: 800);
  final List<ProductModel> _products = <ProductModel>[];

  Future<List<ProductModel>> loadCartItems();
  void addItemToCart(ProductModel product);
  void removeItemFromCart(ProductModel product);
}

class CartRepositoryImpl extends CartRepository {
  @override
  Future<List<ProductModel>> loadCartItems() =>
      Future.delayed(_delay, () => _products);
  @override
  void addItemToCart(ProductModel product) => _products.add(product);

  @override
  void removeItemFromCart(ProductModel product) => _products.remove(product);
}
