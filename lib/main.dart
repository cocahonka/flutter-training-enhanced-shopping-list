import 'package:flutter/material.dart';
import 'package:shopping_list_enhanced/scopes/groceries_scope.dart';
import 'package:shopping_list_enhanced/screens/groceries_screen.dart';

void main() {
  runApp(const ShoppingListApp());
}

class ShoppingListApp extends StatelessWidget {
  const ShoppingListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: const Color.fromARGB(255, 0, 37, 102),
        ),
      ),
      home: const GroceriesScope(
        child: GroceriesScreen(),
      ),
    );
  }
}
