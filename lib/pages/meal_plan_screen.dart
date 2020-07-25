import 'package:CookSmart/pages/recipe_screen.dart';
import 'package:flutter/material.dart';

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
              image: DecorationImage(
                image: NetworkImage(meal.imageURL),
                fit: BoxFit.cover,
              ),
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
            color: Color(0xC0FF7477),
            child: Column(
              children: <Widget>[
                Text(
                  mealType,
                  style: TextStyle(
                    fontFamily: "MontSerrat", 
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
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Cooking Time: " + meal.cookingTime.toString() + " minutes", 
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.right,
                ),
                Text(
                  "Servings: " + meal.servings.toString(), 
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void searchRecipe(Meal meal, String mealType) async {
    Recipe recipe = await APIService.instance.fetchRecipe(id: meal.id);
    Navigator.push(
      this.context,
      MaterialPageRoute(
        builder: (context) => RecipePage(
          mealType: mealType,
          recipe: recipe,
          meal:meal
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
        backgroundColor: Color(0xFFFF7477),
        title: Text('Your Meal Plan', style: TextStyle(fontFamily: "MontSerrat", fontSize: 30)),
      ),
      body: Stack(
          children: <Widget>[
            Container(
              decoration: new BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("background1.png"), fit: BoxFit.fill)),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Total calories for this meal plan: " + widget.mealPlan.calories.toString(),
                style: TextStyle(
                  fontFamily: 'MontSerrat'
                )
              )
            ),
            ListView.builder(
              itemCount: widget.mealPlan.meals.length,
              itemBuilder: (BuildContext context, int index) {
                Meal meal = widget.mealPlan.meals[index];
                return buildMealCard(meal, index);
              },
            ),
          ]
      )
    );
  }
}