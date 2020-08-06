import 'dart:ui';

import 'package:CookSmart/model/meal_model.dart';

import '../pages/meal_plan_screen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../model/meal_plan_model.dart';
import '../services/services.dart';
import '../model/recipe_model.dart';

class CustomPage extends StatefulWidget {
  final String selectedDiet;
  final Set<String> healthConditions;
  final Set<String> mealChoice;
  final Set<int> allergies;
  final Set<double> sliderValue;
  final Map<int, String> foodAllergyDict;

  CustomPage(
      {this.selectedDiet,
      this.healthConditions,
      this.mealChoice,
      this.allergies,
      this.sliderValue,
      this.foodAllergyDict});

  @override
  State createState() {
    return new CustomPageState();
  }
}

class CustomPageState extends State<CustomPage> {
  TextEditingController ingredientC = new TextEditingController();
  List<String> ingredients; 

  void searchMealPlan() async {
    int calories = (1500 + (widget.sliderValue.single.toInt() * 1000));
    MealPlan mealPlan = await APIService.instance.generateMealPlan(
      diet: widget.selectedDiet,
      allergies: makeAllergyString(),
      targetCalories: calories,
    );

    Navigator.push(context, 
      MaterialPageRoute(builder: (context) => MealPage(
        mealPlan: mealPlan,

      ),
      )
    );
  }

  String makeAllergyString() {
    String allergyString = "";
    if (this.widget.allergies.length == 1){
      allergyString += this.widget.foodAllergyDict[this.widget.allergies.elementAt(0)].toLowerCase();
     } else {
       List<int> allergiesList = this.widget.allergies.toList();
      for(int x = 0; x < allergiesList.length - 1; x++){
        allergyString += this.widget.foodAllergyDict[allergiesList[x]].toLowerCase();
        allergyString += ", ";
      }
      allergyString += this.widget.foodAllergyDict[allergiesList[allergiesList.length-1]].toLowerCase();
    }
    return allergyString;
}

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFCA311),
        title: Text("Additional ingredients?", 
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Montserrat",
            fontSize: 25
          )
        )
      ),
      body: 
      Container(
        decoration: new BoxDecoration(
          image: DecorationImage(
            image: AssetImage("background3.png"), fit: BoxFit.cover)
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: ListView(
            children: <Widget>[
              SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 30)
                      ),
                      FloatingActionButton.extended(
                        heroTag: "RandomizedMeal",
                        onPressed: () {
                          if (this.widget.mealChoice.single == 'P') { // if they selected meal plan
                            searchMealPlan();
                          } else {

                          }
                        },
                        label: Text(
                          "Completely Randomized Meal (Plan)",
                          style: new TextStyle(
                            color: Colors.white,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        backgroundColor: Color(0xFFFCA311),
                      ), 
                      Padding(
                        padding: EdgeInsets.only(bottom: 30)
                      ),
                      Container(
                        width: 330,
                        height: 200,
                        child: TextField(
                          controller: ingredientC,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Ingredients',
                          ),
                          style: TextStyle(fontFamily: 'Montserrat', color: Color(0xFFFCA311), fontWeight: FontWeight.bold),
                          onSubmitted: (String value) {
                            ingredients.add(value);
                            value = "";
                            print(ingredients.length);
                          }
                        ),
                      ),
                      FloatingActionButton.extended(
                        heroTag: "showIngredients",
                        onPressed: () {
                          String ingred =  _createIngredientString();
                          return showDialog(
                            context: context,
                            builder: (context){
                              return AlertDialog(
                                content: Text("The ingredients you have included are: \n" + ingred, 
                                  style: TextStyle(fontFamily: 'Montserrat', color: Color(0xFFFCA311), fontWeight: FontWeight.bold)
                                ),   
                              );
                            }
                          );
                        },
                        label: Text("See currently added ingredients!",
                          style: new TextStyle(
                            color: Colors.white,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        backgroundColor: Color(0xFFFCA311),
                      )
                    ],
                  )
                )
              )
            ]
          )
        )
      ),
    );
  }
  String _createIngredientString(){
    String complete = "";
    for (int i = 0; i < ingredients.length; i++){
      if (i == ingredients.length-1){
        complete += ingredients[i];
      } else {
        complete += ingredients[i] + ", ";
      }
    }
    return complete; 
  }
}