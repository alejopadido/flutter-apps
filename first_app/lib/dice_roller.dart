import 'package:flutter/material.dart';
import 'dart:math'; // Math features from Dart

final randomizer =
    Random(); // this prevents from creating a new object each execution

// Statefull Widget (always 2 classes)
class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

// Same name with an underscore and the 'State' Word
class _DiceRollerState extends State<DiceRoller> {
  var currentDiceRoll = 2;

  // Method
  void rollDice() {
    setState(() {
      currentDiceRoll = randomizer.nextInt(6) + 1; // Number between 1 and 6
    }); // Reload build function
  }

  @override
  Widget build(context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Center vertically the column content
      children: [
        Image.asset(
          'assets/images/dice-$currentDiceRoll.png', // Change path
          width: 200,
        ),
        TextButton(
          onPressed: rollDice,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.only(top: 20), // padding top
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontSize: 28,
            ),
          ),
          child: const Text('Roll Dice'),
        )
      ],
    );
  }
}
