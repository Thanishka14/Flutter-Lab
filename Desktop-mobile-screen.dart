import 'package:flutter/material.dart';
void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    double width = MediaQuery.of(context).size.width;
    return MaterialApp(
    home: Scaffold(
    appBar: AppBar(
      title: Text("Responsive UI"),
    ),
     body: Center(
      child: width < 600
     ? Text(
     "Mobile Screen",
     style: TextStyle(fontSize: 25),
     )
     : Text(
        "Large Screen",
          style: TextStyle(fontSize: 25),
     ),
   ),
  ),
 );
  }
}
