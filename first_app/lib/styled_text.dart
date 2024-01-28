import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  const StyledText(this.text,
      {super.key}); // this.text to assign the received value to the property

  // Add property to the class
  final String
      text; // Because the value never changes (just in the runtime) we use final

  @override
  Widget build(context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 28,
      ),
    );
  }
}
