import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/product_viewmodel.dart';
import '../../domain/entities/product.dart';
import 'product_form.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ProductViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Lista de productos")),
      body: ListView.builder(
        itemCount: vm.products.length,
        itemBuilder: (_, index) {
          final product = vm.products[index];
          return Card(
            child: ListTile(
              leading: Image.file(
                File(product.imagePath),
                width: 50,
                fit: BoxFit.cover,
              ),
              title: Text(product.name),
              subtitle: Text('${product.description}\n\$${product.price.toStringAsFixed(2)}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (_) => ProductForm(product: product),
                      ));
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      vm.delete(product.id);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const ProductForm()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
