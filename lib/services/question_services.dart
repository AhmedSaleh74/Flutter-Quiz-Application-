import 'package:dio/dio.dart';
import 'package:quiz_app/models/question_model.dart';

class QuestionServices {
  final dio = Dio();

  Future<List<QuestionModel>> getQuestion({
    required String amount,
    required String difficulty,
    required String category,
    required String type,
  }) async {
    try {
      final response = await dio.get(
        'https://opentdb.com/api.php?amount=$amount&category=$category&difficulty=$difficulty&type=$type',
      );

      final jsonData = response.data;
      final results = jsonData['results'] as List;
      List<QuestionModel> questionList = [];

      for (var result in results) {
        questionList.add(
          QuestionModel(
            question: result['question'],
            correctAnswer: result['correct_answer'],
            incorrectAnswers: List<String>.from(result['incorrect_answers']),
          ),
        );
      }
      return questionList;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Server not responding');
      } else if (e.response != null) {
        throw Exception('Server error: ${e.response?.statusCode}');
      } else {
        throw Exception('Network error occurred');
      }
    } catch (e) {
      throw Exception('Error fetching questions: $e');
    }
  }
}
