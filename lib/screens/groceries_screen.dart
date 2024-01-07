import 'package:flutter/material.dart';
import 'package:shopping_list_enhanced/models/grocery.dart';
import 'package:shopping_list_enhanced/scopes/groceries_scope.dart';
import 'package:shopping_list_enhanced/screens/new_grocery_screen.dart';
import 'package:shopping_list_enhanced/widgets/groceries_list.dart';

class GroceriesScreen extends StatefulWidget {
  const GroceriesScreen({super.key});

  @override
  State<GroceriesScreen> createState() => _GroceriesScreenState();
}

class _GroceriesScreenState extends State<GroceriesScreen> {
  Future<void> _addNewGrocery() async {
    final addNewGrocery = GroceriesScope.of(context, listen: false).addGrocery;

    final grocery = await Navigator.of(context).push<Grocery>(
      MaterialPageRoute(builder: (_) => const NewGroceryScreen()),
    );

    if (grocery == null) return;

    addNewGrocery(grocery);
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
