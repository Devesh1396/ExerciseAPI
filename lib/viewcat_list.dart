import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'UI_helpers.dart';
import 'data_constants.dart';
import 'exercise_provider.dart';
import 'exercises_listUI.dart';

class ViewAllCategoriesPage extends StatefulWidget {
  @override
  _ViewAllCategoriesPageState createState() => _ViewAllCategoriesPageState();
}

class _ViewAllCategoriesPageState extends State<ViewAllCategoriesPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final exerciseProvider =
      Provider.of<ExerciseProvider>(context, listen: false);
      if (exerciseProvider.categories.isEmpty && !exerciseProvider.isLoading) {
        exerciseProvider.fetchCategories();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final exerciseProvider = Provider.of<ExerciseProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Choose Your Workout',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search_outlined, color: Colors.white),
            onPressed: (){
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: exerciseProvider.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : exerciseProvider.errorMessage != null
                  ? Center(
                  child:
                  Text('Error: ${exerciseProvider.errorMessage}'))
                  : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: (MediaQuery.of(context).size.width > 600) ? 2 : 1,
                  crossAxisSpacing: MediaQuery.of(context).size.width * 0.04,
                  mainAxisSpacing: MediaQuery.of(context).size.width * 0.04,
                  childAspectRatio: (MediaQuery.of(context).size.width > 600) ? 4 / 3 : 16 / 9,
                ),
                itemCount: exerciseProvider.categories.length,
                itemBuilder: (context, index) {
                  final category = exerciseProvider.categories[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExerciseListPage(bodyPart: category),
                        ),
                      );
                    },
                    child: CategoryCard(
                      title: category,
                      imageUrl: getCategoryImage(category),
                    ),
                  );
                },
              )
            ),
          ],
        ),
      ),
    );
  }
}
