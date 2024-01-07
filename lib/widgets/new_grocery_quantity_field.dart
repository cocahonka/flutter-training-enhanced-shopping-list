import 'package:flutter/material.dart';

class NewGroceryQuantityField extends StatelessWidget {
  const NewGroceryQuantityField({required this.onSaved, super.key});

  final ValueSetter<String?> onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(label: Text('Quantity')),
      validator: (value) {
        if (value == null || int.tryParse(value) == null || int.tryParse(value)! < 0) {
          return 'Quantity must be greater than 1';
        }

        return null;
      },
      onSaved: onSaved,
    );
  }
}
