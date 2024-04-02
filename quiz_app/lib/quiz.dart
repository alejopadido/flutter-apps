import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/questions_screen.dart';
import 'package:quiz_app/start_screen.dart';
import 'package:quiz_app/results_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswers = [];
  var activeScreen = 'start-screen';

  void switchScreen() {
    setState(() {
      activeScreen = 'questions-screen';
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = 'results-screen';
      });
    }
  }

  void restartQuiz() {
    setState(
      () {
        selectedAnswers = [];
        activeScreen = 'questions-screen';
      },
    );
  }

  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 0, 64, 255),
                Color.fromARGB(255, 33, 96, 243),
              ],
            ),
          ),
          child: activeScreen == 'start-screen'
              ? StartScreen(switchScreen)
              : activeScreen == 'results-screen'
                  ? ResultsScreen(
                      chosenAnswers: selectedAnswers,
                      onRestart: restartQuiz,
                    )
                  : QuestionsScreen(onSelectAnswer: chooseAnswer),
        ),
      ),
    );
  }
}
