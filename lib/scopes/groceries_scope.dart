import 'package:flutter/widgets.dart';
import 'package:shopping_list_enhanced/scopes/groceries_bloc.dart';
import 'package:shopping_list_enhanced/scopes/groceries_repository.dart';

@immutable
class _GroceriesInherited extends InheritedWidget {
  const _GroceriesInherited({
    required this.groceriesBloc,
    required super.child,
  });

  final GroceriesBloc groceriesBloc;

  @override
  bool updateShouldNotify(_GroceriesInherited oldWidget) {
    return groceriesBloc != oldWidget.groceriesBloc;
  }
}

class GroceriesScope extends StatefulWidget {
  const GroceriesScope({
    required this.child,
    required this.repository,
    super.key,
  });

  final GroceriesRepository repository;
  final Widget child;

  static GroceriesBloc of(BuildContext context, {bool listen = true}) {
    if (listen) {
      return context.dependOnInheritedWidgetOfExactType<_GroceriesInherited>()!.groceriesBloc;
    }

    return context.getInheritedWidgetOfExactType<_GroceriesInherited>()!.groceriesBloc;
  }

  @override
  State<GroceriesScope> createState() => _GroceriesScopeState();
}

class _GroceriesScopeState extends State<GroceriesScope> {
  @override
  void initState() {
    super.initState();
    _groceriesBloc = GroceriesBloc(repository: widget.repository);
  }

  late final GroceriesBloc _groceriesBloc;

  @override
  Widget build(BuildContext context) {
    return _GroceriesInherited(
      groceriesBloc: _groceriesBloc,
      child: widget.child,
    );
  }
}
