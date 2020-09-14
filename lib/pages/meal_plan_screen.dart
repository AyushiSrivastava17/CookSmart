import 'package:CookSmart/model/ingredients_list.dart';
import 'package:CookSmart/pages/recipe_screen.dart';
import 'package:flutter/material.dart';

import 'package:hexcolor/hexcolor.dart';
import '../model/meal_plan_model.dart';
import '../model/meal_model.dart';
import '../model/recipe_model.dart';
import '../services/services.dart';

class MealPage extends StatefulWidget {
  final bool selectedMealPlan;
  final MealPlan mealPlan;
  final SearchIngredients searchIngredients;
  MealPage({this.selectedMealPlan, this.mealPlan, this.searchIngredients});

  State createState() => new MealPageState();
}

class MealPageState extends State<MealPage> {
  _buildTotalNutrientsCard() {
    return Container(
      height: 140.0,
      margin: EdgeInsets.all(20.0),
      padding: EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 10.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 2),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Total Nutrients',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10.0),
          /*Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Calories: ${widget.mealPlan.calories.toString()} cal',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Protein: ${widget.mealPlan.protein.toString()} g',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Fat: ${widget.mealPlan.fat.toString()} g',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Carbs: ${widget.mealPlan.carbs.toString()} g',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),*/
        ],
      ),
    );
  }

  buildMealCard(Meal meal, int index) {
    String mealType = findMealType(index);

    return GestureDetector(
      onTap: () => searchRecipe(meal, mealType),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          Container(
            height: 260.0,
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
            height: 260,
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
              borderRadius: BorderRadius.circular(15.0),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xCC000000),
                  const Color(0x00000000),
                  const Color(0x00000000),
                  const Color(0xCC000000),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20.0),
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      meal.cookingTime.toString() + " minutes",
                      style: TextStyle(fontSize: 15.0, color: Colors.white),
                    )),
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      meal.title,
                      style: TextStyle(fontSize: 21.0, color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void searchRecipe(Meal meal, String mealType) async {
    Recipe recipe = await APIService.instance.fetchRecipe(id: meal.id);
    print(recipe.spoonacularSourceUrl);
    Navigator.push(
      this.context,
      MaterialPageRoute(
        builder: (context) =>
            RecipePage(mealType: mealType, recipe: recipe, meal: meal),
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
          title: Text('Your Meals',
              style: TextStyle(fontFamily: "MontSerrat", fontSize: 30)),
        ),
        body: Stack(children: <Widget>[
          Container(
            decoration: new BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("image0.jpeg"), fit: BoxFit.fill)),
          ),
          /*Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Total calories for this meal plan: " + widget.mealPlan.calories.toString(),
                style: TextStyle(
                  fontFamily: 'MontSerrat'
                )
              )
            ),*/

          //_buildTotalNutrientsCard(),
          ListView.builder(
            itemCount: (widget.selectedMealPlan == true)
                ? widget.mealPlan.meals.length + 1
                : 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return _buildTotalNutrientsCard();
              }
              Meal meal = widget.mealPlan.meals[index - 1];
              return buildMealCard(meal, index - 1);
            },
          ),
        ]));
  }
}
