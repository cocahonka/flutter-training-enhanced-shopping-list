import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart' show listEquals;
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_list_enhanced/models/grocery.dart';

@immutable
class _GroceriesInherited extends InheritedWidget {
  const _GroceriesInherited({
    required this.groceries,
    required this.fetchGroceries,
    required this.addGrocery,
    required this.deleteGrocery,
    required super.child,
  });

  final UnmodifiableListView<Grocery> groceries;
  final ValueGetter<Future<List<Grocery>>> fetchGroceries;
  final ValueSetter<Grocery> addGrocery;
  final ValueSetter<Grocery> deleteGrocery;

  @override
  bool updateShouldNotify(_GroceriesInherited oldWidget) {
    return !listEquals(groceries, oldWidget.groceries);
  }
}

class GroceriesScope extends StatefulWidget {
  const GroceriesScope({required this.child, super.key});

  final Widget child;

  static _GroceriesInherited of(BuildContext context, {bool listen = true}) {
    if (listen) {
      return context.dependOnInheritedWidgetOfExactType<_GroceriesInherited>()!;
    }

    return context.getInheritedWidgetOfExactType<_GroceriesInherited>()!;
  }

  @override
  State<GroceriesScope> createState() => _GroceriesScopeState();
}

class _GroceriesScopeState extends State<GroceriesScope> {
  List<Grocery> _groceries = [];

  List<Grocery> _cloneGroceries() => _groceries.map((grocery) => grocery.clone()).toList();

  void _addGrocery(Grocery grocery) {
    setState(() {
      _groceries = _cloneGroceries()..add(grocery);
    });
  }

  void _deleteGrocery(Grocery grocery) {
    setState(() {
      _groceries = _cloneGroceries()..remove(grocery);
    });
  }

  Future<List<Grocery>> _fetchGroceries() async {
    final response = await http.get(
      Uri.parse(
        'https://shopping-list-demo-cocahonka-default-rtdb.europe-west1.firebasedatabase.app/shopping-list.json',
      ),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch groceries');
    }

    if (response.body == 'null') {
      return [];
    }

    final body = json.decode(response.body) as Map<String, dynamic>;
    final fetchedGroceries = body.entries.map((entry) {
      return Grocery.fromJson(
        {
          'id': entry.key,
          ...entry.value as Map<String, dynamic>,
        },
      );
    }).toList();

    return fetchedGroceries;
  }

  @override
  Widget build(BuildContext context) {
    return _GroceriesInherited(
      groceries: UnmodifiableListView(_groceries),
      fetchGroceries: _fetchGroceries,
      addGrocery: _addGrocery,
      deleteGrocery: _deleteGrocery,
      child: widget.child,
    );
  }
}
