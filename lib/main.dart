// ignore_for_file: prefer_const_constructors

import 'package:delimeals/3.2%20dummy_data.dart';
import 'package:delimeals/models/meal.dart';
import 'package:delimeals/screens/categories_screens.dart';
import 'package:delimeals/screens/category_meals_screen.dart';
import 'package:delimeals/screens/filters_Screen.dart';
import 'package:delimeals/screens/meal_detail_screen.dart';
import 'package:delimeals/screens/tabs_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false
  };
  List<Meal> availiablemeals = DUMMY_MEALS;
  List<Meal> favourites = [];

  void setfilters(Map<String, bool> filterData) {
    setState(() {
      filters = filterData;

      availiablemeals = DUMMY_MEALS.where((meal) {
        if (filters['gluten']! && !meal.isGlutenFree) {
          return false;
        }
        if (filters['lactose']! && !meal.isLactoseFree) {
          return false;
        }
        if (filters['vegan']! && !meal.isVegan) {
          return false;
        }
        if (filters['vegetarian']! && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void tooglefavourite(String mealId) {
    final existingindex = favourites.indexWhere((meal) => meal.id == mealId);
    if (existingindex >= 0) {
      setState(() {
        favourites.removeAt(existingindex);
      });
    } else {
      setState(() {
        favourites.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool isFavourite(String id) {
    return favourites.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        hintColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: TextStyle(
                  fontFamily: 'RobotoCondensed',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
      ),
      // home: const categoriesScreen(),
      initialRoute: '',
      routes: {
        '': (context) => tabsScreen(favourites),
        categoryMealsScreen.routename: (context) =>
            categoryMealsScreen(availiablemeals),
        MealDetails.routeName: (context) => MealDetails(
              tooglefavourite,
              isFavourite,
            ),
        FilterScreen.routeName: (context) => FilterScreen(filters, setfilters),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => categoriesScreen());
      },
    );
  }
}
