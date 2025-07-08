import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presentation/viewmodel/product_viewmodel.dart';
import 'presentation/view/home_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ProductViewModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestión de Productos',
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
