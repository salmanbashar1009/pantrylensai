import 'package:flutter/material.dart';

class PantryLensApp extends StatelessWidget {
  const PantryLensApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Center(child: Text('Hello World!'))),
    );
  }
}