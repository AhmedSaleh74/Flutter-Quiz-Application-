import 'package:flutter/material.dart';

import '../models/question_model.dart';
import 'package:get/get.dart';

import 'answer_button.dart';

ListView answerListView(List<String> allAnswers, QuestionModel currentQuestionObj,RxString selectedAnswer,RxBool showResult,void Function(String answer) checkAnswer) {
  return ListView.separated(
    itemCount: allAnswers.length,
    separatorBuilder: (_, __) => const SizedBox(height: 10),
    itemBuilder: (_, index) {
      final answer = allAnswers[index];
      return AnswerButton(
        answer: answer,
        correctAnswer: currentQuestionObj.correctAnswer,
        selectedAnswer: selectedAnswer.value,
        showResult: showResult.value,
        onTap: () => checkAnswer(answer),
      );
    },
  );
}
