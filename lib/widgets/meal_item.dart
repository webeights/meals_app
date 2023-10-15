import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item_traits.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem(this.meal, this.showMealDetailScreen, {super.key});

  final Meal meal;
  final void Function() showMealDetailScreen;

  get complexityText {
    var complexity = meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
    return complexity;
  }

  get affordabilityText {
    var affordability = meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
    return affordability;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 24,
      ),
      child: InkWell(
        onTap: showMealDetailScreen,
        child: SizedBox(
          width: double.infinity,
          height: 200,
          child: Stack(
            children: [
              FadeInImage(
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  color: Colors.black54,
                  child: Column(
                    children: [
                      Text(
                        meal.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MealItemTrait(
                            icon: Icons.watch_later_outlined,
                            label: '${meal.duration} min',
                          ),
                          MealItemTrait(
                            icon: Icons.cases_outlined,
                            label: complexityText,
                          ),
                          MealItemTrait(
                            icon: Icons.attach_money_rounded,
                            label: affordabilityText,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
