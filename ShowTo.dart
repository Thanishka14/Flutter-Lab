import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: FoodMenu(),
));

class FoodMenu extends StatefulWidget {
  FoodMenu({super.key});

  @override
  State<FoodMenu> createState() => _FoodMenuState();
}

class _FoodMenuState extends State<FoodMenu> {

  // Food menu items
  final foods = [
    ['Pizza', '₹199', Icons.local_pizza],
    ['Burger', '₹99', Icons.lunch_dining],
    ['Biryani', '₹149', Icons.rice_bowl],
    ['Ice Cream', '₹79', Icons.icecream],
  ];

  // Cart list
  List<Map<String, dynamic>> cart = [];

  // Add item to cart
  void addToCart(int i) {
    setState(() {
      int index = cart.indexWhere(
        (item) => item['name'] == foods[i][0],
      );

      if (index != -1) {
        cart[index]['quantity']++;
      } else {
        cart.add({
          'name': foods[i][0],
          'price': int.parse(
            foods[i][1].toString().replaceAll('₹', ''),
          ),
          'quantity': 1,
        });
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${foods[i][0]} added to cart'),
      ),
    );
  }

  // Remove item from cart
  void removeFromCart(int i) {
    setState(() {
      cart.removeAt(i);
    });
  }

  // Calculate total
  int get total {
    int sum = 0;

    for (var item in cart) {
      sum += item['price'] * item['quantity'] as int;
    }

    return sum;
  }

  @override
  Widget build(BuildContext context) {

    // Responsive breakpoint
    int columns =
        MediaQuery.of(context).size.width < 600 ? 1 : 2;

    return Scaffold(
      appBar: AppBar(
        title: Text('Food Ordering App'),
        backgroundColor: Colors.orange,

        // Cart icon
        actions: [
          IconButton(
            icon: Badge(
              label: Text(
                '${cart.fold<int>(0, (sum, item) => sum + item['quantity'] as int)}',
              ),
              child: Icon(Icons.shopping_cart),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(
                    cart: cart,
                    removeFromCart: removeFromCart,
                    getTotal: () => total,
                  ),
                ),
              ).then((_) => setState(() {}));
            },
          ),
        ],
      ),

      // Food Menu Screen
      body: Column(
        children: [
          SizedBox(height: 10),

          Text(
            'Our Food Menu',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              itemCount: foods.length,

              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                childAspectRatio:
                    columns == 1 ? 2.5 : 1.2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),

              itemBuilder: (context, i) => Card(
                color: Colors.orange.shade50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      foods[i][2] as IconData,
                      size: 30,
                      color: Colors.orange,
                    ),

                    Text(
                      foods[i][0] as String,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),

                    Text(foods[i][1] as String),

                    ElevatedButton(
                      onPressed: () => addToCart(i),
                      child: Text('Order Now'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Cart Screen
class CartScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cart;
  final Function(int) removeFromCart;
  final int Function() getTotal;

  CartScreen({
    required this.cart,
    required this.removeFromCart,
    required this.getTotal,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
        backgroundColor: Colors.orange,
      ),

      body: widget.cart.isEmpty
          ? Center(
              child: Text(
                'Your cart is empty',
                style: TextStyle(fontSize: 20),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.cart.length,
                    itemBuilder: (context, i) {
                      var item = widget.cart[i];

                      return Card(
                        child: ListTile(
                          title: Text(item['name']),
                          subtitle: Text(
                            'Price: ₹${item['price']}  |  Quantity: ${item['quantity']}',
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              setState(() {
                                widget.removeFromCart(i);
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Total Amount: ₹${widget.getTotal()}',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
