import 'package:CookSmart/model/ingredients_list.dart';
import 'package:CookSmart/pages/recipe_screen.dart';
import 'package:flutter/material.dart';

import 'package:hexcolor/hexcolor.dart';
import '../model/meal_plan_model.dart';
import '../model/meal_model.dart';
import '../model/recipe_model.dart';
import '../services/services.dart';
import '../pages/ingredients_recipe_screen.dart';

class MealIngredientsPage extends StatefulWidget {
  final bool selectedMealPlan;
  //final MealPlan mealPlan;
  final SearchIngredients searchIngredients;
  MealIngredientsPage({this.selectedMealPlan, this.searchIngredients});

  @override
  State createState() {
    return MealIngredientsPageState();
  }
}

class MealIngredientsPageState extends State<MealIngredientsPage> {
  buildMealCard(SearchIngredients searchIngred, int index) {
    String mealType = findMealType(index);

    return GestureDetector(
      onTap: () => searchRecipe(searchIngred, mealType),
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
                image: NetworkImage(searchIngred.image),
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
                    ),
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      searchIngred.title,
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

  void searchRecipe(SearchIngredients searchIngred, String mealType) async {
    Recipe recipe = await APIService.instance.fetchRecipe(id: searchIngred.id);
    //print(recipe.spoonacularSourceUrl);
    Navigator.push(
      this.context,
      MaterialPageRoute(
        builder: (context) => RecipeIngredientsPage(
            mealType: mealType, recipe: recipe, searchIngred: searchIngred),
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
          ListView.builder(
            itemCount: (widget.selectedMealPlan == true)
                ? 3
                : 1,
            itemBuilder: (BuildContext context, int index) {
              return buildMealCard(widget.searchIngredients, index);
            },
          ),
        ]));
  }
}
