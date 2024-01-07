import 'package:flutter/material.dart';

enum Category {
  vegetables(Color.fromARGB(255, 0, 255, 128)),
  fruit(Color.fromARGB(255, 145, 255, 0)),
  meat(Color.fromARGB(255, 255, 102, 0)),
  dairy(Color.fromARGB(255, 0, 208, 255)),
  carbs(Color.fromARGB(255, 0, 60, 255)),
  sweets(Color.fromARGB(255, 255, 149, 0)),
  spices(Color.fromARGB(255, 255, 187, 0)),
  convenience(Color.fromARGB(255, 191, 0, 255)),
  hygiene(Color.fromARGB(255, 149, 0, 255)),
  other(Color.fromARGB(255, 0, 225, 255));

  const Category(this.color);

  final Color color;
}
