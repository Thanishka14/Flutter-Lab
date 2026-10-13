import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<ProductStore>(
      create: (_) => ProductStore(),
      builder: (context, _) => const ProductApp(),
    ),
  );
}

class Product {
  final int id;
  final String title;
  final double price;
  final String category;
  final String image;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int? ?? 0,
      title: json['title']?.toString() ?? 'Unknown Product',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      category: json['category']?.toString() ?? 'Unknown',
      image: json['image']?.toString() ?? 'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg',
    );
  }
}

class ProductStore extends ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = true;
  String? _error;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get error => _error;

  ProductStore() {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await http
          .get(Uri.parse('https://fakestoreapi.com/products'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        _products = data.map((item) => Product.fromJson(item as Map<String, dynamic>)).toList();
      } else {
        _error = 'Failed to load products: ${response.statusCode}';
      }
    } catch (e) {
      _error = 'Could not connect to server.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

class ProductApp extends StatelessWidget {
  const ProductApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Store',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const ProductScreen(),
    );
  }
}

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<ProductStore>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Available Products')),
      body: store.isLoading
          ? const Center(child: CircularProgressIndicator())
          : store.error != null
              ? Center(child: Text(store.error!))
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: store.products.length,
                  itemBuilder: (context, index) {
                    final product = store.products[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: Image.network(
                          product.image,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                        ),
                        title: Text(product.title),
                        subtitle: Text('${product.category.toUpperCase()} • \$${product.price.toStringAsFixed(2)}'),
                      ),
                    );
                  },
                ),
    );
  }
}
