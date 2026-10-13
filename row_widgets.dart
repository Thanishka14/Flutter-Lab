import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      home: HomePage()
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Layouts"), 
        backgroundColor: Colors.blue
      ),
      body: Center(
        child: Column(
          children: [
            Center(
              child: Text(
                "Row widgets", 
                style: TextStyle(fontSize: 24)
              )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.home, size: 50, color: Colors.red),
                Icon(Icons.school, size: 50, color: Colors.pink),
                Icon(Icons.person, size: 50, color: Colors.green),
              ],
            ),
            SizedBox(height: 30),
            Text(
              "Stack", 
              style: TextStyle(color: Colors.black, fontSize: 25)
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(height: 20),
                Container(height: 100, width: 100, color: Colors.green),
                Container(height: 50, width: 50, color: Colors.red),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
