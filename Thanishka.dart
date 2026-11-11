import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: FoodMenu(),
));

class FoodMenu extends StatelessWidget {
  FoodMenu({super.key});

  // Food menu items
  final foods = [
    ['Pizza', '₹199', Icons.local_pizza],
    ['Burger', '₹99', Icons.lunch_dining],
    ['Biryani', '₹149', Icons.rice_bowl],
    ['Ice Cream', '₹79', Icons.icecream],
  ];

  @override
  Widget build(BuildContext context) {

    // MediaQuery and Responsive Breakpoint
    // Mobile: 1 column, Tablet: 2 columns
    int columns =
        MediaQuery.of(context).size.width < 600 ? 1 : 2;

    return Scaffold(
      appBar: AppBar(
        title: Text('Food Ordering App'),
        backgroundColor: Colors.orange,
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

          // Responsive GridView
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              itemCount: foods.length,

              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(

                // Responsive layout
                crossAxisCount: columns,

                // Adjust card size
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
                      onPressed: () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          SnackBar(
                            content: Text(
                              '${foods[i][0]} added to cart',
                            ),
                          ),
                        );
                      },
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
