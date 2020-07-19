import 'package:path/path.dart';
import 'package:CookSmart/mechanics/multiselect.dart';
import 'package:CookSmart/pages/recipe_screen.dart';
import 'package:flutter/material.dart';
import '../pages/quiz_page.dart';

import 'package:flutter/material.dart';
import '../mechanics/multiselect.dart';
import 'package:hexcolor/hexcolor.dart';
import '../model/meal_plan_model.dart';
import '../model/meal_model.dart';
import '../model/recipe_model.dart';
import '../services/services.dart';

class MealPage extends StatefulWidget {
  final MealPlan mealPlan;
  MealPage({this.mealPlan});

  State createState() => new MealPageState();
}

class MealPageState extends State<MealPage> {
  buildMealCard(Meal meal, int index) {
    String mealType = findMealType(index);

    return GestureDetector(
      onTap: () => searchRecipe(meal, mealType),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: 220.0,
            width: double.infinity,
            margin: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 10.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              /*image: DecorationImage(
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover,
              )*/
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 2),
                  blurRadius: 6.0,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(60.0),
            padding: EdgeInsets.all(10.0),
            color: Colors.white70,
            child: Column(
              children: <Widget>[
                Text(
                  mealType,
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                Text(
                  meal.title,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
    
  }

  void searchRecipe(Meal meal, String mealType) async {
    Recipe recipe = await APIService.instance.fetchRecipe(meal.id.toString());
    Navigator.push(
      this.context,
      MaterialPageRoute(
        builder: (context) => RecipePage(
          mealType: mealType,
          recipe: recipe,
        ),
      ),
    );
  }

  findMealType(int index) {
    if (index == 0) {
      return 'Breakfast';
    }
    if (index == 1) {
      return 'Lunch';
    }
    if (index == 2) {
      return 'Dinner';
    }
    return 'Breakfast';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Meal Plan'),
      ),
      body: ListView.builder(
        itemCount: 1 + widget.mealPlan.meals.length,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            print(widget.mealPlan.protein.toString());
            print(widget.mealPlan.calories.toString());
            print(widget.mealPlan.carbs.toString());
          }
          Meal meal = widget.mealPlan.meals[index - 1];
          return buildMealCard(meal, index - 1);
        },
      ),
    );
  }
}
