import 'package:flutter/foundation.dart' show immutable;
import 'package:shopping_list_enhanced/models/category.dart';

@immutable
class Grocery {
  const Grocery({
    required this.id,
    required this.name,
    required this.quantity,
    required this.category,
  });

  factory Grocery.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': final String id,
        'name': final String name,
        'quantity': final int quantity,
        'category': final String categoryName,
      } =>
        Grocery(
          id: id,
          name: name,
          quantity: quantity,
          category: Category.values.firstWhere(
            (category) => category.name == categoryName,
          ),
        ),
      _ => throw const FormatException('Failed to load grocery.'),
    };
  }

  final String id;
  final String name;
  final int quantity;
  final Category category;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'quantity': quantity,
        'category': category.name,
      };

  Grocery clone() => Grocery(
        id: id,
        name: name,
        quantity: quantity,
        category: category,
      );

  @override
  int get hashCode => Object.hash(id, name, quantity, category);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Grocery &&
        id == other.id &&
        name == other.name &&
        quantity == other.quantity &&
        category == other.category;
  }
}
