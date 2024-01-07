import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:shopping_list_enhanced/models/grocery.dart';

@immutable
class _GroceriesInherited extends InheritedWidget {
  const _GroceriesInherited({
    required this.groceries,
    required this.addGrocery,
    required this.deleteGrocery,
    required super.child,
  });

  final UnmodifiableListView<Grocery> groceries;
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

  @override
  Widget build(BuildContext context) {
    return _GroceriesInherited(
      groceries: UnmodifiableListView(_groceries),
      addGrocery: _addGrocery,
      deleteGrocery: _deleteGrocery,
      child: widget.child,
    );
  }
}
