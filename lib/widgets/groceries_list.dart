import 'package:flutter/material.dart';
import 'package:shopping_list_enhanced/extensions/string.dart';
import 'package:shopping_list_enhanced/scopes/groceries_scope.dart';

class GroceriesList extends StatefulWidget {
  const GroceriesList({super.key});

  @override
  State<GroceriesList> createState() => _GroceriesListState();
}

class _GroceriesListState extends State<GroceriesList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: GroceriesScope.of(context).groceryStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final groceries = snapshot.data!;
          return groceries.isEmpty
              ? Center(
                  child: Text(
                    'You dont have groceries yet.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                )
              : ListView.builder(
                  itemCount: groceries.length,
                  itemBuilder: (context, index) {
                    final grocery = groceries[index];
                    return Dismissible(
                      key: UniqueKey(),
                      onDismissed: (_) => GroceriesScope.of(context).deleteGrocery(grocery),
                      child: ListTile(
                        leading: Container(
                          width: 24,
                          height: 24,
                          color: grocery.category.color,
                        ),
                        title: Text(grocery.name.capitalize()),
                        trailing: Text(grocery.quantity.toString()),
                      ),
                    );
                  },
                );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              snapshot.error.toString(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
