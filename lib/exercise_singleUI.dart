import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'exercise_provider.dart';

class ExerciseDetailPage extends StatefulWidget {
  final String exerciseId;

  ExerciseDetailPage({required this.exerciseId});

  @override
  _ExerciseDetailPageState createState() => _ExerciseDetailPageState();
}

class _ExerciseDetailPageState extends State<ExerciseDetailPage> {
  @override
  void initState() {
    super.initState();

    // Fetch the selected exercise details by ID
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final exerciseProvider = Provider.of<ExerciseProvider>(context, listen: false);
      exerciseProvider.fetchExerciseById(widget.exerciseId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final exerciseProvider = Provider.of<ExerciseProvider>(context);
    final exercise = exerciseProvider.selectedExercise;

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(exercise != null ? exercise.name : 'Exercise Details'),
      ),
      body: exerciseProvider.isExerciseDetailLoading
          ? Center(child: CircularProgressIndicator())
          : exerciseProvider.exerciseDetailError != null
          ? Center(child: Text('Error: ${exerciseProvider.exerciseDetailError}'))
          : exercise != null
          ? SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the exercise GIF
            Container(
              width: double.infinity,
              height: 360,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(exercise.gifUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 16),

            // Equipment information
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Equipment Needed: ${exercise.equipment}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
            ),

            // Instructions list
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Instructions:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: exercise.instructions.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.arrow_right,
                          color: Colors.blueAccent,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            exercise.instructions[index],
                            style: TextStyle(fontSize: 16, color: Colors.white70),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      )
          : Center(child: Text('Exercise not found')),
    );
  }
}
