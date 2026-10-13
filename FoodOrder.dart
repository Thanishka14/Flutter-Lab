import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartModel(),
      builder: (context, child) => const FoodOrderingApp(),
    ),
  );
}

class CartModel extends ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void addToCart() {
    _count++;
    notifyListeners();
  }
}

class Food {
  final String name;
  final String price;
  final String emoji;
  final String description;
  final Color color;

  const Food({
    required this.name,
    required this.price,
    required this.emoji,
    required this.description,
    required this.color,
  });
}

class FoodOrderingApp extends StatelessWidget {
  const FoodOrderingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Foodie',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const FoodHomePage(),
    );
  }
}

class FoodHomePage extends StatelessWidget {
  const FoodHomePage({super.key});

  final List<Food> foods = const [
    Food(
      name: 'Pizza',
      price: '₹199',
      emoji: '🍕',
      description: 'Cheesy • Italian',
      color: Color(0xFFFFE4D6),
    ),
    Food(
      name: 'Burger',
      price: '₹129',
      emoji: '🍔',
      description: 'Crispy • Delicious',
      color: Color(0xFFFFEDC2),
    ),
    Food(
      name: 'Biryani',
      price: '₹249',
      emoji: '🍛',
      description: 'Spicy • Authentic',
      color: Color(0xFFFFDCCB),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F3),
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        title: const Row(
          children: [
            Icon(Icons.restaurant_menu, size: 27),
            SizedBox(width: 10),
            Text('Foodie', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23)),
          ],
        ),
        actions: [
          Consumer<CartModel>(
            builder: (context, cart, child) => Padding(
              padding: const EdgeInsets.only(right: 18),
              child: Badge(
                label: Text('${cart.count}'),
                isLabelVisible: cart.count > 0,
                child: const Icon(Icons.shopping_cart_outlined, size: 28),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFFFF7043), Color(0xFFEF3E23)]),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('GOOD FOOD, GOOD MOOD!', style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.4)),
                  SizedBox(height: 10),
                  Text('What would you\nlike to eat today?', style: TextStyle(color: Colors.white, fontSize: 27, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('Freshly made, just for you', style: TextStyle(color: Colors.white, fontSize: 14)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ...foods.map<Widget>((food) => FoodCard(food: food)),
          ],
        ),
      ),
    );
  }
}

class FoodCard extends StatelessWidget {
  final Food food;
  const FoodCard({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: food.color, borderRadius: BorderRadius.circular(12)),
            child: Text(food.emoji, style: const TextStyle(fontSize: 32)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(food.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                Text(food.description, style: const TextStyle(color: Colors.grey)),
                Text(food.price, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange)),
              ],
            ),
          ),
          IconButton(
            onPressed: () => context.read<CartModel>().addToCart(),
            icon: const Icon(Icons.add_circle, color: Colors.deepOrange, size: 32),
          ),
        ],
      ),
    );
  }
}
