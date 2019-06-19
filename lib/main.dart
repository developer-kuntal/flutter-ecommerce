import 'package:flutter/material.dart';

// my own imports
import 'package:flutter_shopping/pages/login.dart';
// import 'package:flutter/foundation.dart'

// show debugDefaultTargetPlatformOverride; // for desktop embedder

void main() {
  
  // debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia; // for desktop embedder

  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Colors.red.shade900
    ),
    home: Login(),
  ));
}