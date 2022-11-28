import 'package:flutter/material.dart';
import 'package:ia_model/models/predictions.dart';
import 'package:ia_model/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Leo-Oh! LinearModel App',
      home: HomePage(),
    );
  }
}
