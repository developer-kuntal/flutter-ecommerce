import 'package:flutter/material.dart';

// my own imports
import 'package:flutter_shopping/pages/login.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Colors.red.shade900
    ),
    home: Login(),
  ));
}