import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';

const kInitializeFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  var currentIndex = 0;

  final List<Meal> favoriteMeals = [];
  Map<Filter, bool> selectedFilters = kInitializeFilters;

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
    var availableMeals = dummyMeals.where((meal) {
      if (selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    Widget activeScreen = CategoriesScreen(
      availableMeals: availableMeals,
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
        (identifier) async {
          Navigator.of(context).pop();
          if (identifier == 'filters') {
            var result = await Navigator.of(context).push<Map<Filter, bool>>(
              MaterialPageRoute(
                builder: (context) =>
                    Filters(currentActiveFilter: selectedFilters),
              ),
            );
            setState(() {
              selectedFilters = result ?? kInitializeFilters;
            });
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
