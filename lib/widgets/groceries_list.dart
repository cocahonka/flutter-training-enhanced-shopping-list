import 'package:flutter/material.dart';
import 'package:shopping_list_enhanced/extensions/string.dart';
import 'package:shopping_list_enhanced/scopes/groceries_scope.dart';

class GroceriesList extends StatelessWidget {
  const GroceriesList({super.key});

  @override
  Widget build(BuildContext context) {
    final groceries = GroceriesScope.of(context).groceries;

    return ListView.builder(
      itemCount: groceries.length,
      itemBuilder: (context, index) {
        final grocery = groceries[index];
        return ListTile(
          leading: Container(
            width: 24,
            height: 24,
            color: grocery.category.color,
          ),
          title: Text(grocery.name.capitalize()),
          trailing: Text(grocery.quantity.toString()),
        );
      },
    );
  }
}
