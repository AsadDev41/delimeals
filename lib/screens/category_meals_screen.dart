// ignore_for_file: unused_local_variable

import 'package:delimeals/models/meal.dart';
import 'package:delimeals/widgets/meal_item.dart';
import 'package:flutter/material.dart';
import '../3.2 dummy_data.dart';

class categoryMealsScreen extends StatefulWidget {
  static const routename = '/category-meals';

  final List<Meal> avaliablemeals;
  categoryMealsScreen(this.avaliablemeals);

  @override
  State<categoryMealsScreen> createState() => _categoryMealsScreenState();
}

class _categoryMealsScreenState extends State<categoryMealsScreen> {
  late String categoryTitle;
  late List<Meal> displayedMeals;
  var loadedinItData = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!loadedinItData) {
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title']!;
      final categoryid = routeArgs['id'];
      displayedMeals = widget.avaliablemeals.where((meal) {
        return meal.categories.contains(categoryid);
      }).toList();
      loadedinItData = true;
    }

    super.didChangeDependencies();
  }

  void removeMeal(String mealid) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealid);
    });
  }

  // final String categoryId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(categoryTitle!)),
      body: ListView.builder(
        itemBuilder: ((ctx, index) {
          return mealItem(
            id: displayedMeals[index].id,
            title: displayedMeals[index].title,
            imageUrl: displayedMeals[index].imageUrl,
            duration: displayedMeals[index].duration,
            complexity: displayedMeals[index].complexity,
            affordability: displayedMeals[index].affordability,
          );
        }),
        itemCount: displayedMeals.length,
      ),
    );
  }
}
