import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shopping_list_enhanced/models/category.dart';
import 'package:shopping_list_enhanced/models/grocery.dart';

class GroceriesRepository {
  static const _baseUrl = 'https://shopping-list-demo-cocahonka-default-rtdb.europe-west1.firebasedatabase.app';

  Future<List<Grocery>> getAllGroceries() async {
    final url = Uri.parse('$_baseUrl/shopping-list.json');
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to load groceries');
    }

    if (response.body == 'null') {
      return [];
    }

    final body = json.decode(response.body) as Map<String, dynamic>;
    final groceries = body.entries.map((entry) {
      return Grocery.fromJson({
        'id': entry.key,
        ...entry.value as Map<String, dynamic>,
      });
    }).toList();

    return groceries;
  }

  Future<void> deleteGrocery(Grocery grocery) async {
    final url = Uri.parse('$_baseUrl/shopping-list/${grocery.id}.json');
    final response = await http.delete(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to delete item');
    }
  }

  Future<Grocery> addGrocery({
    required String name,
    required int quantity,
    required Category category,
  }) async {
    final url = Uri.parse('$_baseUrl/shopping-list.json');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': name,
        'quantity': quantity,
        'category': category.name,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add grocery');
    }

    final body = json.decode(response.body) as Map<String, dynamic>;
    final id = body['name'] as String;

    final grocery = Grocery(
      id: id,
      name: name,
      quantity: quantity,
      category: category,
    );

    return grocery;
  }
}
