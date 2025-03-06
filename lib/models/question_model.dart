// question_model.dart
class QuestionModel {
  final String question;
  final String correctAnswer;
  final List<String> incorrectAnswers;

  QuestionModel({
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
  });
}