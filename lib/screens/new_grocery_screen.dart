import 'package:flutter/material.dart';
import 'package:shopping_list_enhanced/models/category.dart';
import 'package:shopping_list_enhanced/models/grocery.dart';
import 'package:shopping_list_enhanced/widgets/new_grocery_category_dropdown.dart';
import 'package:shopping_list_enhanced/widgets/new_grocery_name_field.dart';
import 'package:shopping_list_enhanced/widgets/new_grocery_quantity_field.dart';

class NewGroceryScreen extends StatefulWidget {
  const NewGroceryScreen({super.key});

  @override
  State<NewGroceryScreen> createState() => _NewGroceryScreenState();
}

class _NewGroceryScreenState extends State<NewGroceryScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _enteredName;
  int? _enteredQuantity;
  Category? _selectedCategory;

  void _resetForm() {
    _formKey.currentState!.reset();
  }

  void _saveForm() {
    final formState = _formKey.currentState!;

    if (!formState.validate()) return;

    formState.save();

    if (_enteredName == null || _enteredQuantity == null || _selectedCategory == null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Fields must not be empty')));
      return;
    }

    Navigator.of(context).pop(
      Grocery(
        id: DateTime.now().toIso8601String(),
        name: _enteredName!,
        quantity: _enteredQuantity!,
        category: _selectedCategory!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              NewGroceryNameField(onSaved: (value) => _enteredName = value),
              Row(
                children: [
                  Expanded(child: NewGroceryQuantityField(onSaved: (value) => _enteredQuantity = int.parse(value!))),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: NewGroceryCategoryDropdown(onChanged: (value) => _selectedCategory = value),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: _resetForm,
                      child: const Text('Reset'),
                    ),
                    ElevatedButton(
                      onPressed: _saveForm,
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
