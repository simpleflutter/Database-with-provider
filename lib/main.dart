import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/screens/home_screen.dart';
import 'services/employee_operations.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => EmployeeOperations(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
