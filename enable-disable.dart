import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  double size = 50;
  bool enabled = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("School Icon"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Icon(
                Icons.school,
                size: size,
                color: Colors.blue,
              ),
            ),

            SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: enabled
                      ? () {
                          setState(() {
                            size++;
                          });
                        }
                      : null,
                  child: Text("+"),
                ),

                ElevatedButton(
                  onPressed: enabled
                      ? () {
                          setState(() {
                            size--;
                          });
                        }
                      : null,
                  child: Text("-"),
                ),

                ElevatedButton(
                  onPressed: enabled
                      ? () {
                          setState(() {
                            size = 50;
                          });
                        }
                      : null,
                  child: Text("Reset"),
                ),
              ],
            ),

            SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Enable"),
                Switch(
                  value: enabled,
                  onChanged: (value) {
                    setState(() {
                      enabled = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
