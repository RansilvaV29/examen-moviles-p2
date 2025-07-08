import 'package:uuid/uuid.dart';
import '../domain/entities/product.dart';

class ProductDataSource {
  final List<Product> _products = [];

  List<Product> getAll() => _products;

  void add(Product product) => _products.add(product);

  void update(Product updatedProduct) {
    final index = _products.indexWhere((p) => p.id == updatedProduct.id);
    if (index != -1) {
      _products[index] = updatedProduct;
    }
  }

  void delete(String id) {
    _products.removeWhere((p) => p.id == id);
  }
}
