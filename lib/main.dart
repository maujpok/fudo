import 'package:flutter/material.dart';
import 'package:fudo/app/app.dart';
import 'package:fudo/app/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injectDependencies();
  runApp(const MyApp());
}
