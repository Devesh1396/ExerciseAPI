import 'package:api_proj2/viewcat_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'UI_helpers.dart';
import 'data_constants.dart';
import 'exercise_provider.dart';
import 'exercises_listUI.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        title: Text('Exercise API'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Trendy Workouts',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white70),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewAllCategoriesPage(),
                      ),
                    );
                  },
                  child: Text(
                    'View All',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
            Expanded(
              child: exerciseProvider.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : exerciseProvider.errorMessage != null
                  ? Center(
                  child:
                  Text('Error: ${exerciseProvider.errorMessage}'))
                    : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: (MediaQuery.of(context).size.width > 600) ? 3 : 2,
                  crossAxisSpacing: MediaQuery.of(context).size.width * 0.04,
                  mainAxisSpacing: MediaQuery.of(context).size.width * 0.04,
                  childAspectRatio: (MediaQuery.of(context).size.width > 600) ? 3 / 4 : 9 / 16,
                ),
                itemCount: exerciseProvider.categories.length > 4 ? 4 : exerciseProvider.categories.length,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

