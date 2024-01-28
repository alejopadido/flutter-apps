import 'package:flutter/material.dart';
//files
import 'package:first_app/styled_text.dart';

// variables
const startAlignment = Alignment.topLeft;
const endAlignment = Alignment.bottomRight;

class GradientContainer extends StatelessWidget {
  const GradientContainer(
      {super.key,
      required this.colors}); // By default, named arguments are optional, so you must use 'required'

  final List<Color> colors;

  @override
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: startAlignment,
          end: endAlignment,
        ),
      ),
      child: const Center(
        child: StyledText('Home Page'),
      ),
    );
  }
}
