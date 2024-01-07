import 'package:flutter/material.dart';
import 'package:shopping_list_enhanced/extensions/string.dart';
import 'package:shopping_list_enhanced/models/category.dart';

class NewGroceryCategoryDropdown extends StatelessWidget {
  const NewGroceryCategoryDropdown({required this.onChanged, super.key});

  final ValueSetter<Category?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Category>(
      decoration: const InputDecoration(label: Text('Category')),
      items: [
        for (final category in Category.values)
          DropdownMenuItem(
            value: category,
            child: Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  color: category.color,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Text(category.name.capitalize()),
                ),
              ],
            ),
          ),
      ],
      onChanged: onChanged,
    );
  }
}
