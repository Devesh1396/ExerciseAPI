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
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
        itemCount: exerciseProvider.exercises.length,
        itemBuilder: (context, index) {
          final exercise = exerciseProvider.exercises[index];
          final screenWidth = MediaQuery.of(context).size.width;

          return Padding(
            padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(screenWidth * 0.03),
                border: Border.all(color: Colors.white70, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: screenWidth * 0.003,
                    blurRadius: screenWidth * 0.02,
                    offset: Offset(0, screenWidth * 0.01),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(screenWidth * 0.04),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(screenWidth * 0.02),
                  child: Image.network(
                    exercise.gifUrl,
                    width: screenWidth * 0.15,
                    height: screenWidth * 0.15,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  exercise.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenWidth * 0.045),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(top: screenWidth * 0.01),
                  child: Text(
                    'Equipment Needed: ${exercise.equipment}',
                    style: TextStyle(fontSize: screenWidth * 0.035),
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
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.03),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: screenWidth * 0.02,
                      horizontal: screenWidth * 0.04,
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Start',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.04,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      )
    );
  }
}
