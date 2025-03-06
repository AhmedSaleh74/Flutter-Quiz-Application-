class QuizType {
  final String value;
  final String name;

  const QuizType({
    required this.value,
    required this.name,
  });

  static List<QuizType> get types => [
    QuizType(value: 'multiple', name: 'Multiple Choice'),
    QuizType(value: 'boolean', name: 'True/False'),
  ];
}