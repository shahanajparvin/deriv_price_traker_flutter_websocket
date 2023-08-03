import 'package:flutter/material.dart';
import 'Routes/routes_generator.dart';


void main() {
  runApp(const PriceTrackerApp());
}

class PriceTrackerApp extends StatelessWidget {
  const PriceTrackerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deriv Coding Challenge Task',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

