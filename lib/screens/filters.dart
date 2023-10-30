import 'package:flutter/material.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class Filters extends StatefulWidget {
  const Filters({super.key, required this.currentActiveFilter});

  final Map<Filter, bool> currentActiveFilter;

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  bool isGlutenFree = false;
  bool isLactoseFree = false;
  bool isVegetarian = false;
  bool isVegan = false;

  @override
  void initState() {
    isGlutenFree = widget.currentActiveFilter[Filter.glutenFree]!;
    isLactoseFree = widget.currentActiveFilter[Filter.lactoseFree]!;
    isVegetarian = widget.currentActiveFilter[Filter.vegetarian]!;
    isVegan = widget.currentActiveFilter[Filter.vegan]!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop({
            Filter.glutenFree: isGlutenFree,
            Filter.lactoseFree: isLactoseFree,
            Filter.vegetarian: isVegetarian,
            Filter.vegan: isVegan,
          });
          return false;
        },
        child: Column(
          children: [
            SwitchListTile(
              activeColor: Theme.of(context).colorScheme.primary,
              title: const Text('Gluten Free'),
              subtitle: const Text('Show Gluten Free Meals Only'),
              value: isGlutenFree,
              onChanged: (value) {
                setState(() {
                  isGlutenFree = value;
                });
              },
            ),
            const Divider(),
            SwitchListTile(
              activeColor: Theme.of(context).colorScheme.primary,
              title: const Text('Lactose Free'),
              subtitle: const Text('Show Lactose Free Meals Only'),
              value: isLactoseFree,
              onChanged: (value) {
                setState(() {
                  isLactoseFree = value;
                });
              },
            ),
            const Divider(),
            SwitchListTile(
              activeColor: Theme.of(context).colorScheme.primary,
              title: const Text('Vegetarian'),
              subtitle: const Text('Show Vegetarian Meals Only'),
              value: isVegetarian,
              onChanged: (value) {
                setState(() {
                  isVegetarian = value;
                });
              },
            ),
            const Divider(),
            SwitchListTile(
              activeColor: Theme.of(context).colorScheme.primary,
              title: const Text('Vegan'),
              subtitle: const Text('Show Vegan Meals Only'),
              value: isVegan,
              onChanged: (value) {
                setState(() {
                  isVegan = value;
                });
              },
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
