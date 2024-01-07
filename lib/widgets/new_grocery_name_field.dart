import 'package:flutter/material.dart';

class NewGroceryNameField extends StatelessWidget {
  const NewGroceryNameField({required this.onSaved, super.key});

  final ValueSetter<String?> onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 50,
      decoration: const InputDecoration(label: Text('Name')),
      validator: (value) {
        final trimmedValue = value?.trim();

        if (trimmedValue == null || trimmedValue.length <= 1) {
          return 'Name lenght must be greater than 1';
        }

        return null;
      },
      onSaved: onSaved,
    );
  }
}
