import 'package:flutter/material.dart';
import 'BookListScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Book Store",
      home: BookListScreen(),
    );
  }
}



