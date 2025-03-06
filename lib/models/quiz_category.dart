class QuizCategory {
  final int id;
  final String name;

  const QuizCategory({
    required this.id,
    required this.name,
  });

  static List<QuizCategory> get categories => [
    QuizCategory(id: 9, name: 'General Knowledge'),
    QuizCategory(id: 10, name: 'Entertainment: Books'),
    QuizCategory(id: 11, name: 'Entertainment: Film'),
    QuizCategory(id: 12, name: 'Entertainment: Music'),
    QuizCategory(id: 17, name: 'Science & Nature'),
    QuizCategory(id: 18, name: 'Science: Computers'),
    QuizCategory(id: 19, name: 'Science: Mathematics'),
    QuizCategory(id: 21, name: 'Sports'),
    QuizCategory(id: 22, name: 'Geography'),
    QuizCategory(id: 23, name: 'History'),
  ];
}