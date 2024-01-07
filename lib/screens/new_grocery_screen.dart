import 'package:flutter/material.dart';

class NewGroceryScreen extends StatefulWidget {
  const NewGroceryScreen({super.key});

  @override
  State<NewGroceryScreen> createState() => _NewGroceryScreenState();
}

class _NewGroceryScreenState extends State<NewGroceryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new item'),
      ),
      body: const Placeholder(),
    );
  }
}
