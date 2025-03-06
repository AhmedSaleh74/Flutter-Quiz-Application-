import 'package:flutter/material.dart';

class OnBoardingModel {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  OnBoardingModel({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });

  static List<OnBoardingModel> items = [
    OnBoardingModel(
      title: 'Welcome to Quiz App',
      description: 'Test your knowledge with our amazing quiz app',
      icon: Icons.quiz,
      color: Colors.blue,
    ),
    OnBoardingModel(
      title: 'Multiple Categories',
      description: 'Choose from various categories and challenge yourself',
      icon: Icons.category,
      color: Colors.purple,
    ),
    OnBoardingModel(
      title: 'Track your Progress',
      description: 'See your scores and improve your knowledge',
      icon: Icons.trending_up,
      color: Colors.orange,
    ),
  ];
}