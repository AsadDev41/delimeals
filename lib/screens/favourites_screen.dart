import 'package:delimeals/models/meal.dart';
import 'package:delimeals/widgets/meal_item.dart';
import 'package:flutter/material.dart';

class favoutiteScreen extends StatelessWidget {
  final List<Meal> favourites;
  favoutiteScreen(this.favourites);

  @override
  Widget build(BuildContext context) {
    if (favourites.isEmpty) {
      return Center(
        child: Text('You have no favourites yet. Add Some! '),
      );
    } else {
      return ListView.builder(
        itemBuilder: ((ctx, index) {
          return mealItem(
            id: favourites[index].id,
            title: favourites[index].title,
            imageUrl: favourites[index].imageUrl,
            duration: favourites[index].duration,
            complexity: favourites[index].complexity,
            affordability: favourites[index].affordability,
          );
        }),
        itemCount: favourites.length,
      );
    }
  }
}
