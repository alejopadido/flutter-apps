import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsSummary extends StatelessWidget {
  QuestionsSummary(this.summaryData, {super.key});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          children: summaryData.map(
            (data) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    margin: const EdgeInsets.only(right: 15),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ((data['user_answer']) as String ==
                              (data['correct_answer']) as String
                          ? const Color.fromARGB(255, 0, 255, 191)
                          : Color.fromARGB(255, 255, 101, 232)),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      ((data['question_index'] as int) + 1).toString(),
                      style: GoogleFonts.lato(
                        color: const Color.fromARGB(255, 0, 64, 255),
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['question'] as String,
                          style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          data['user_answer'] as String,
                          style: GoogleFonts.lato(
                            color: const Color.fromARGB(255, 175, 206, 255),
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          data['correct_answer'] as String,
                          style: GoogleFonts.lato(
                            color: const Color.fromARGB(255, 0, 255, 191),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
