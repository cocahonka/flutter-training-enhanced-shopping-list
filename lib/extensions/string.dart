extension Capitalize on String {
  String capitalize() => length > 1 ? this[0].toUpperCase() + substring(1) : this;
}
