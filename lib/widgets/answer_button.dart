import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  final String answer;
  final String correctAnswer;
  final String selectedAnswer;
  final bool showResult;
  final VoidCallback onTap;

  const AnswerButton({
    Key? key,
    required this.answer,
    required this.correctAnswer,
    required this.selectedAnswer,
    required this.showResult,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? buttonColor;
    Color? textColor = Colors.white;

    if (showResult) {
      if (answer == correctAnswer) {
        buttonColor = Colors.green;
      } else if (answer == selectedAnswer) {
        buttonColor = Colors.red;
      }
    }

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor ?? Colors.transparent,
        foregroundColor: textColor,
        padding: const EdgeInsets.all(16),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: showResult ? null : onTap,
      child: Row(
        children: [
          Expanded(
            child: Text(
              answer,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (showResult && answer == correctAnswer)
            const Icon(
              Icons.check_circle,
              color: Colors.white,
            )
          else if (showResult && answer == selectedAnswer && answer != correctAnswer)
            const Icon(
              Icons.close,
              color: Colors.white,
            ),
        ],
      ),
    );
  }
}