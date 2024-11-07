import 'dart:convert';
import 'package:http/http.dart' as http;
import 'exercise_model.dart';

class ApiService {
  static const String _baseUrl = 'https://exercisedb.p.rapidapi.com';
  static const Map<String, String> _headers = {
    'X-RapidAPI-Key':
    'ebefe0efc5msh0289171d9cc62a6p14b16djsna1f498a4958e',
    'X-RapidAPI-Host': 'exercisedb.p.rapidapi.com'
  };

  //method to fetch body part list
  Future<List<String>> fetchbodyPartList() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/exercises/bodyPartList'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      return List<String>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load body part list');
    }
  }

  //  method to fetch exercises by body part
  Future<List<Exercise>> fetchExercisesByBodyPart(String bodyPart) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/exercises/bodyPart/$bodyPart'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> exercisesJson = jsonDecode(response.body);
      return exercisesJson.map((json) => Exercise.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load exercises for $bodyPart');
    }
  }

  // Fetch a specific exercise by ID
  Future<Exercise> fetchExerciseById(String id) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/exercises/exercise/$id'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> exerciseJson = jsonDecode(response.body);
      return Exercise.fromJson(exerciseJson);
    } else {
      throw Exception('Failed to load exercise details');
    }
  }

}
