import 'package:flutter/material.dart';
import 'package:shopping_list_enhanced/scopes/groceries_repository.dart';
import 'package:shopping_list_enhanced/scopes/groceries_scope.dart';
import 'package:shopping_list_enhanced/screens/groceries_screen.dart';

void main() {
  runApp(const ShoppingListApp());
}

class ShoppingListApp extends StatefulWidget {
  const ShoppingListApp({super.key});

  @override
  State<ShoppingListApp> createState() => _ShoppingListAppState();
}

class _ShoppingListAppState extends State<ShoppingListApp> {
  final _groceriesRepository = GroceriesRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: const Color.fromARGB(255, 0, 37, 102),
        ),
      ),
      home: GroceriesScope(
        repository: _groceriesRepository,
        child: const GroceriesScreen(),
      ),
    );
  }
}
