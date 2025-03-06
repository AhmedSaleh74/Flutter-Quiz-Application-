class QuizDifficulty {
  final String value;
  final String name;

  const QuizDifficulty({
    required this.value,
    required this.name,
  });

  static List<QuizDifficulty> get difficulties => [
    QuizDifficulty(value: 'easy', name: 'Easy'),
    QuizDifficulty(value: 'medium', name: 'Medium'),
    QuizDifficulty(value: 'hard', name: 'Hard'),
  ];
}