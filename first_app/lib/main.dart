import 'package:flutter/material.dart';

//files
import 'package:first_app/gradient_container.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: GradientContainer(colors: [
          Color.fromARGB(255, 56, 8, 139),
          Color.fromARGB(255, 78, 35, 152)
        ]),
      ),
    ),
  );
}
