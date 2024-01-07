import 'package:flutter/material.dart';
import 'package:shopping_list_enhanced/screens/new_grocery_screen.dart';
import 'package:shopping_list_enhanced/widgets/groceries_list.dart';

class GroceriesScreen extends StatefulWidget {
  const GroceriesScreen({super.key});

  @override
  State<GroceriesScreen> createState() => _GroceriesScreenState();
}

class _GroceriesScreenState extends State<GroceriesScreen> {
  void _addNewGrocery() {
    Navigator.of(context).push<void>(
      MaterialPageRoute(builder: (_) => const NewGroceryScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewGrocery,
        child: const Icon(Icons.add),
      ),
      body: const GroceriesList(),
    );
  }
}
