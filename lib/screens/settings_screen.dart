import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/screens/quiz_home.dart';
import '../models/quiz_category.dart';
import '../models/quiz_difficulty.dart';
import '../models/quiz_type.dart';
import '../widgets/custom_dropdowns.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final playerName = ''.obs;
  final selectedCategoryId = 9.obs;
  final selectedDifficulty = 'easy'.obs;
  final selectedType = 'multiple'.obs;
  final numberOfQuestions = 10.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: double.infinity,
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
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 20,
                  children: [
                    // Header
                    Center(
                      child: Container(
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
                    ),
                    const Text(
                      'Quiz Settings',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      ),
                    ),
                    // Name Input
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white30,
                          width: 1,
                        ),
                      ),
                      child: TextField(
                        onChanged: (value) => playerName.value = value,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Your Name',
                          labelStyle: const TextStyle(color: Colors.white70),
                          prefixIcon: const Icon(Icons.person, color: Colors.white70),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                        ),
                      ),
                    ),
                    // Dropdowns
                    Row(
                      spacing: 16,
                      children: [
                        Obx(() => Expanded(
                          child: CustomDropdown<int>(
                            label: 'Category',
                            value: selectedCategoryId.value,
                            items: QuizCategory.categories.map((e) => e.id).toList(),
                            getLabel: (id) => QuizCategory.categories
                                .firstWhere((cat) => cat.id == id).name,
                            onChanged: (value) => selectedCategoryId.value = value!,
                          ),
                        )),
                        Obx(() => Expanded(
                          child: CustomDropdown<String>(
                            label: 'Difficulty',
                            value: selectedDifficulty.value,
                            items: QuizDifficulty.difficulties.map((e) => e.value).toList(),
                            getLabel: (value) => QuizDifficulty.difficulties
                                .firstWhere((diff) => diff.value == value).name,
                            onChanged: (value) => selectedDifficulty.value = value!,
                          ),
                        )),

                      ],
                    ),
                    Row(
                      spacing: 16,
                      children: [
                        Obx(() => Expanded(
                          child: CustomDropdown<String>(
                            label: 'Question Type',
                            value: selectedType.value,
                            items: QuizType.types.map((e) => e.value).toList(),
                            getLabel: (value) => QuizType.types
                                .firstWhere((type) => type.value == value).name,
                            onChanged: (value) => selectedType.value = value!,
                          ),
                        )),
                        Obx(() => Expanded(
                          child: CustomDropdown<int>(
                            label: 'Number of Questions',
                            value: numberOfQuestions.value,
                            items: [5, 10, 15, 20, 25, 30],
                            getLabel: (number) => '$number Questions',
                            onChanged: (value) => numberOfQuestions.value = value!,
                          ),
                        )),
                      ],
                    ),
                    SizedBox(height: 20,),
                    // Start Button
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
                            color: Colors.blue.shade900.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          if (playerName.value.trim().isNotEmpty) {
                            Get.to(() => QuizScreen(
                              playerName: playerName.value,
                              category: selectedCategoryId.value,
                              difficulty: selectedDifficulty.value,
                              type: selectedType.value,
                              amount: numberOfQuestions.value,
                            ));
                          } else {
                            Get.snackbar(
                              'Error',
                              'Please enter your name',
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          }
                        },
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
            ),
          ),
        ),
      ),
    );
  }
}