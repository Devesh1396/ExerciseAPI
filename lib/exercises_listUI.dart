import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'exercise_provider.dart';
import 'exercise_singleUI.dart';

class ExerciseListPage extends StatefulWidget {
  final String bodyPart;

  ExerciseListPage({required this.bodyPart});

  @override
  _ExerciseListPageState createState() => _ExerciseListPageState();
}

class _ExerciseListPageState extends State<ExerciseListPage> {
  @override
  void initState() {
    super.initState();
    // Fetch exercises based on the selected body part
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final exerciseProvider = Provider.of<ExerciseProvider>(context, listen: false);
      exerciseProvider.fetchExercisesByBodyPart(widget.bodyPart);
    });
  }

  @override
  Widget build(BuildContext context) {
    final exerciseProvider = Provider.of<ExerciseProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('${widget.bodyPart} Exercises'),
        actions: [
          IconButton(
            icon: Icon(Icons.search_outlined, color: Colors.white),
            onPressed: (){
            },
          ),
        ],
      ),
      body: exerciseProvider.isExerciseLoading
          ? Center(child: CircularProgressIndicator())
          : exerciseProvider.exerciseErrorMessage != null
          ? Center(child: Text('Error: ${exerciseProvider.exerciseErrorMessage}'))
          : ListView.builder(
        padding: EdgeInsets.all(12), // Padding around the entire list
        itemCount: exerciseProvider.exercises.length,
        itemBuilder: (context, index) {
          final exercise = exerciseProvider.exercises[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8), // More space between items
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white70, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: Offset(0, 3), // Shadow position
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(16), // Increase padding inside ListTile
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8), // Rounded corners for image
                  child: Image.network(
                    exercise.gifUrl,
                    width: 60, // Increased image width
                    height: 60, // Increased image height
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  exercise.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Equipment Needed: ${exercise.equipment}',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExerciseDetailPage(exerciseId: exercise.id),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Button background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Rounded corners
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    elevation: 0, // No shadow or elevation
                  ),
                  child: Text(
                    'Start',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
