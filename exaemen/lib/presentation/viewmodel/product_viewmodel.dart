import 'package:flutter/material.dart';
import '../../data/product_datasource.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';

class ProductViewModel extends ChangeNotifier implements ProductRepository {
  final ProductDataSource _dataSource = ProductDataSource();

  List<Product> _products = [];

  List<Product> get products => _products;

  @override
  void add(Product product) {
    _dataSource.add(product);
    _products = _dataSource.getAll();
    notifyListeners();
  }

  @override
  void delete(String id) {
    _dataSource.delete(id);
    _products = _dataSource.getAll();
    notifyListeners();
  }

  @override
  List<Product> getAll() {
    _products = _dataSource.getAll();
    return _products;
  }

  @override
  void update(Product product) {
    _dataSource.update(product);
    _products = _dataSource.getAll();
    notifyListeners();
  }
}
