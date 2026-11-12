import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Login(),
  ));
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Student Login")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Welcome Students!",
              style: TextStyle(fontSize: 25)),

          TextField(
            decoration: InputDecoration(labelText: "Email"),
          ),

          TextField(
            decoration: InputDecoration(labelText: "Password"),
          ),

          ElevatedButton(
            child: Text("Login"),
            onPressed: () {
              Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) => Notice()));
            },
          ),
        ],
      ),
    );
  }
}

class Notice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Campus Notice Board"),
        backgroundColor: Colors.blue,
      ),

      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            color: Colors.blue.shade100,
            child: Row(
              children: [
                Icon(Icons.school, size: 35),
                Text(" College Announcements",
                    style: TextStyle(fontSize: 20)),
              ],
            ),
          ),

          Stack(
            children: [
              Image.network(
                "https://picsum.photos/400/200",
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),

              Positioned(
                bottom: 10,
                left: 10,
                child: Text("Welcome Students!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20)),
              ),
            ],
          ),

          Container(
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.all(10),
            color: Colors.green.shade100,
            child: Column(
              children: [
                Text("Latest Notices",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold)),
                Text("1. Exams Start Monday"),
                Text("2. Sports Day on Friday"),
                Text("3. Submit Projects"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
