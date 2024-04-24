import 'package:ets/page/movies_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Movies',
      debugShowCheckedModeBanner: false,
      home: MoviesPage(),
    );
  }
}
