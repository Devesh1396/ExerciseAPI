import 'package:flutter/material.dart';
import 'api_service.dart';
import 'exercise_model.dart';

class ExerciseProvider with ChangeNotifier {
  List<String> _categories = [];
  List<Exercise> _exercises = [];
  bool _isLoading = false;
  bool _isExerciseLoading = false;
  bool _isExerciseDetailLoading = false;
  String? _errorMessage;
  String? _exerciseErrorMessage;
  Exercise? _selectedExercise;
  String? _exerciseDetailError;


  final ApiService _apiService = ApiService();

  List<String> get categories => _categories;
  List<Exercise> get exercises => _exercises;
  bool get isLoading => _isLoading;
  bool get isExerciseLoading => _isExerciseLoading;
  String? get errorMessage => _errorMessage;
  String? get exerciseErrorMessage => _exerciseErrorMessage;
  Exercise? get selectedExercise => _selectedExercise;
  bool get isExerciseDetailLoading => _isExerciseDetailLoading;
  String? get exerciseDetailError => _exerciseDetailError;


  //function to fetch categories available
  Future<void> fetchCategories() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _categories = await _apiService.fetchbodyPartList();
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //function to fetch exercises by selected body part
  Future<void> fetchExercisesByBodyPart(String bodyPart) async {
    _isExerciseLoading = true;
    _exerciseErrorMessage = null;
    notifyListeners();

    try {
      _exercises = await _apiService.fetchExercisesByBodyPart(bodyPart);
    } catch (error) {
      _exerciseErrorMessage = error.toString();
    } finally {
      _isExerciseLoading = false;
      notifyListeners();
    }
  }

  // Function to fetch exercise details by ID
  Future<void> fetchExerciseById(String id) async {
    _isExerciseDetailLoading = true;
    _exerciseDetailError = null;
    notifyListeners();

    try {
      _selectedExercise = await _apiService.fetchExerciseById(id);
    } catch (error) {
      _exerciseDetailError = error.toString();
    } finally {
      _isExerciseDetailLoading = false;
      notifyListeners();
    }
  }

}
