import '../entities/product.dart';

abstract class ProductRepository {
  List<Product> getAll();
  void add(Product product);
  void update(Product product);
  void delete(String id);
}
