import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meal_detail_screen.dart';
import 'package:meals_app/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    required this.meals,
    this.title,
    required this.toggleFavorites,
  });

  final List<Meal> meals;
  final String? title;

  final Function(Meal) toggleFavorites;

  void showMealDetailScreen(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MealDetailScreen(
          meal: meal,
          toggleFavorites: toggleFavorites,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = meals.isEmpty
        ? const Center(
            child: Text(
              'Add some of your favorite meals',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
          )
        : ListView(
            children: [
              ...meals.map(
                (meal) => MealItem(
                  meal,
                  () => showMealDetailScreen(context, meal),
                ),
              ),
            ],
          );

    if (title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
