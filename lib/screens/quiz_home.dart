import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/question_model.dart';
import '../services/question_services.dart';
import '../widgets/answer_button.dart';

class QuizScreen extends StatelessWidget {
  QuizScreen({
    super.key,
    required this.playerName,
    required this.category,
    required this.difficulty,
    required this.type,
    required this.amount
  });

  final String playerName;
  final int category;
  final String difficulty;
  final String type;
  final int amount;

  final questions = <QuestionModel>[].obs;
  final currentIndex = 0.obs;
  final gameStarted = false.obs;
  final isLoading = false.obs;
  final selectedAnswer = ''.obs;
  final showResult = false.obs;
  final score = 0.obs;

  Future<void> fetchQuestions() async {
    isLoading.value = true;
    try {
      final questionsList = await QuestionServices().getQuestion(
        difficulty: difficulty,
        amount: '$amount',
        category: '$category',
        type: type,
      );
      questions.value = questionsList;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load questions');
    } finally {
      isLoading.value = false;
    }
  }

  void checkAnswer(String answer) {
    selectedAnswer.value = answer;
    showResult.value = true;

    Future.delayed(const Duration(milliseconds: 500), () {
      if (answer.toLowerCase() ==
          questions[currentIndex.value].correctAnswer.toLowerCase()) {
        score.value++;
      }

      showResult.value = false;
      selectedAnswer.value = '';
      currentIndex.value++;

      if (currentIndex.value >= questions.length) {
        Get.snackbar(
          'Quiz Completed!',
          'Your Final Score: ${score.value}/${questions.length}',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
        gameStarted.value = false;
        currentIndex.value = 0;
      }
    });
  }

  void startGame() async {
    await fetchQuestions();
    gameStarted.value = true;
    score.value = 0;
    currentIndex.value = 0;
    showResult.value = false;
    selectedAnswer.value = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade900,
              Colors.purple.shade900,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                // Welcome Header
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.white30,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Hello, $playerName!',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Loading Indicator
                Obx(() => isLoading.value
                    ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ))
                    : const SizedBox()),

                // Question Section
                Obx(() {
                  if (!gameStarted.value || questions.isEmpty) {
                    return Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.1),
                              ),
                              child: const Icon(
                                Icons.quiz,
                                size: 60,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Ready to Start?',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1.5,
                              ),
                            ),
                            const SizedBox(height: 40),
                            Container(
                              height: 55,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.blue.shade400,
                                    Colors.purple.shade400,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                onPressed: startGame,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.play_arrow, color: Colors.white),
                                    SizedBox(width: 10),
                                    Text(
                                      'Start Quiz',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return Expanded(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.white30,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Question ${currentIndex.value + 1}/${questions.length}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white70,
                                ),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                questions[currentIndex.value].question,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.white30,
                                width: 1,
                              ),
                            ),
                            child: Center(child: _buildAnswers()),
                          ),
                        ),
                      ],
                    ),
                  );
                }),

                // Score Section
                Obx(() => gameStarted.value
                    ? Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.shade400,
                        Colors.purple.shade400,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.stars,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Score: ${score.value}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
                    : const SizedBox()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnswers() {
    final currentQuestionObj = questions[currentIndex.value];
    final allAnswers = [
      currentQuestionObj.correctAnswer,
      ...currentQuestionObj.incorrectAnswers,
    ]..shuffle();

    return ListView.separated(
      itemCount: allAnswers.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (_, index) {
        final answer = allAnswers[index];
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue.shade800,
                Colors.blue.shade600,
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: AnswerButton(
            answer: answer,
            correctAnswer: currentQuestionObj.correctAnswer,
            selectedAnswer: selectedAnswer.value,
            showResult: showResult.value,
            onTap: () => checkAnswer(answer),
          ),
        );
      },
    );
  }
}