import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  var currentIndex = 0;

  final List<Meal> favoriteMeals = [];

  void switchScreen(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void toggleFavorites(Meal meal) {
    var isExisting = favoriteMeals.contains(meal);

    if (!isExisting) {
      setState(() {
        favoriteMeals.add(meal);
      });
    } else {
      setState(() {
        favoriteMeals.remove(meal);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen = CategoriesScreen(
      toggleFavorites: toggleFavorites,
    );
    var title = 'Categories';

    if (currentIndex == 1) {
      activeScreen = MealsScreen(
        meals: favoriteMeals,
        toggleFavorites: toggleFavorites,
      );
      title = 'Favorites';
    }

    return Scaffold(
      drawer: MainDrawer(
        (identifier) {
          Navigator.of(context).pop();
          if (identifier == 'filters') {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const Filters(),
              ),
            );
          }
        },
      ),
      appBar: AppBar(
        title: Text(title),
      ),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        onTap: switchScreen,
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            label: 'Category',
            icon: Icon(Icons.category_rounded),
          ),
          BottomNavigationBarItem(
            label: 'Favorites',
            icon: Icon(Icons.star),
          ),
        ],
      ),
    );
  }
}
