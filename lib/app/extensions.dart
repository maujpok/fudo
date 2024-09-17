import 'package:flutter/material.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

extension Navigation on BuildContext {
  void pop() {
    Navigator.of(this).pop();
  }

  void pushNamed(String routeName, {Object? arguments}) {
    Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  void pushReplacementNamed(String routeName, {Object? arguments}) {
    Navigator.of(this).pushReplacementNamed(routeName, arguments: arguments);
  }

  void pushNamedAndRemoveUntil(String routeName, RoutePredicate predicate, {Object? arguments}) {
    Navigator.of(this).pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
  }
}

extension HideKeyboard on BuildContext {
  void hideKeyboard() {
    FocusScope.of(this).unfocus();
  }
}
