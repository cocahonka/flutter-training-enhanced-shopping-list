import 'dart:async';
import 'dart:collection';

import 'package:shopping_list_enhanced/models/category.dart';
import 'package:shopping_list_enhanced/models/grocery.dart';
import 'package:shopping_list_enhanced/scopes/groceries_repository.dart';

typedef GroceriesOutput = UnmodifiableListView<Grocery>;

class GroceriesBloc {
  GroceriesBloc({required this.repository}) {
    _loadGroceries();
  }

  final GroceriesRepository repository;
  final List<Grocery> _groceries = [];
  final StreamController<GroceriesOutput> _groceriesController = StreamController.broadcast();

  Stream<GroceriesOutput> get groceryStream => _groceriesController.stream;

  List<Grocery> _cloneGroceries() {
    return _groceries.map((grocery) => grocery.clone()).toList();
  }

  Future<void> _loadGroceries() async {
    try {
      _groceries.addAll(await repository.getAllGroceries());

      _groceriesController.add(GroceriesOutput(_groceries));
    } catch (e) {
      _groceriesController.addError(e);
    }
  }

  Future<void> deleteGrocery(Grocery grocery) async {
    final originalGroceries = _cloneGroceries();

    try {
      await repository.deleteGrocery(grocery);

      _groceries.remove(grocery);
      _groceriesController.add(GroceriesOutput(_groceries));
    } catch (e) {
      _groceries
        ..clear()
        ..addAll(originalGroceries);

      _groceriesController
        ..addError(e)
        ..add(GroceriesOutput(_groceries));
    }
  }

  Future<void> addGrocery({
    required String name,
    required int quantity,
    required Category category,
  }) async {
    try {
      final grocery = await repository.addGrocery(
        name: name,
        quantity: quantity,
        category: category,
      );

      _groceries.add(grocery);
      _groceriesController.add(GroceriesOutput(_groceries));
    } catch (e) {
      _groceriesController.addError(e);
    }
  }
}
