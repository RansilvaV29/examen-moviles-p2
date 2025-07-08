import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/product.dart';
import '../viewmodel/product_viewmodel.dart';
import '../../utils/image_helper.dart';

class ProductForm extends StatefulWidget {
  final Product? product;

  const ProductForm({super.key, this.product});

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();
  String? name, description;
  double? price;
  String? imagePath;

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      name = widget.product!.name;
      description = widget.product!.description;
      price = widget.product!.price;
      imagePath = widget.product!.imagePath;
    }
  }

  void _saveProduct() {
    if (_formKey.currentState!.validate() && imagePath != null) {
      _formKey.currentState!.save();
      final vm = Provider.of<ProductViewModel>(context, listen: false);

      final product = Product(
        id: widget.product?.id ?? const Uuid().v4(),
        name: name!,
        description: description!,
        price: price!,
        imagePath: imagePath!,
      );

      if (widget.product == null) {
        vm.add(product);
      } else {
        vm.update(product);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product == null ? "Nuevo Producto" : "Editar Producto"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              imagePath != null
                  ? Image.file(File(imagePath!), height: 150)
                  : const Placeholder(fallbackHeight: 150),
              ElevatedButton.icon(
                onPressed: () async {
                  final path = await ImageHelper.pickImageFromCamera();
                  if (path != null) {
                    setState(() => imagePath = path);
                  }
                },
                icon: const Icon(Icons.camera),
                label: const Text("Tomar Foto"),
              ),
              TextFormField(
                initialValue: name,
                decoration: const InputDecoration(labelText: "Nombre"),
                onSaved: (val) => name = val,
                validator: (val) => val!.isEmpty ? "Requerido" : null,
              ),
              TextFormField(
                initialValue: description,
                decoration: const InputDecoration(labelText: "Descripción"),
                onSaved: (val) => description = val,
                validator: (val) => val!.isEmpty ? "Requerido" : null,
              ),
              TextFormField(
                initialValue: price?.toString(),
                decoration: const InputDecoration(labelText: "Precio"),
                keyboardType: TextInputType.number,
                onSaved: (val) => price = double.tryParse(val!),
                validator: (val) => val!.isEmpty ? "Requerido" : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProduct,
                child: const Text("Guardar Producto"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
