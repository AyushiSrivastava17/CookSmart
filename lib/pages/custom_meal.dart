import 'dart:ui';
import 'package:CookSmart/model/ingredients_list.dart';
import 'package:CookSmart/model/meal_model.dart';
import '../pages/meal_plan_screen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../model/meal_plan_model.dart';
import '../services/services.dart';
import '../model/recipe_model.dart';
import '../pages/meal_ingredients_screen.dart';

class CustomPage extends StatefulWidget {
  final bool selectedMealPlan;
  final String selectedDiet;
  final Set<String> healthConditions;
  final Set<String> mealChoice;
  final Set<int> allergies;
  final Set<double> sliderValue;
  final Map<int, String> foodAllergyDict;
  final Recipe recipe;

  CustomPage(
      {this.selectedMealPlan,
      this.selectedDiet,
      this.healthConditions,
      this.mealChoice,
      this.allergies,
      this.sliderValue,
      this.foodAllergyDict,
      this.recipe});

  @override
  State createState() {
    return new CustomPageState();
  }
}

class CustomPageState extends State<CustomPage> {
  TextEditingController ingredientC = new TextEditingController();
  String ingredients;

  void searchMealPlan() async {
    int calories = (1500 + (widget.sliderValue.single.toInt() * 1000));
    MealPlan mealPlan = await APIService.instance.generateMealPlan(
      diet: widget.selectedDiet,
      allergies: makeAllergyString(),
      targetCalories: calories,
    );

    //print(mealPlan.meals[0].title);

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MealPage(
            mealPlan: mealPlan,
            selectedMealPlan: widget.selectedMealPlan,
          ),
        ));
  }

  void searchMealsByIngredients(String ingredients) async {
    List<SearchIngredients> searchIngred =
        await APIService.instance.searchByIngredients(ingredients: ingredients);

    //print(searchIngred.title);
    //print(searchIngred.sourceUrl);

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MealIngredientsPage(
            searchIngredients: searchIngred,
            selectedMealPlan: widget.selectedMealPlan,
          ),
        ));
  }

  String makeAllergyString() {
    String allergyString = "";
    if (this.widget.allergies.length == 1) {
      allergyString += this
          .widget
          .foodAllergyDict[this.widget.allergies.elementAt(0)]
          .toLowerCase();
    } else {
      List<int> allergiesList = this.widget.allergies.toList();
      for (int x = 0; x < allergiesList.length - 1; x++) {
        allergyString +=
            this.widget.foodAllergyDict[allergiesList[x]].toLowerCase();
        allergyString += ", ";
      }
      allergyString += this
          .widget
          .foodAllergyDict[allergiesList[allergiesList.length - 1]]
          .toLowerCase();
    }
    return allergyString;
  }

  Widget _buildQuestions(String question) {
    return Container(
      height: 50.0,
      width: 370.0,
      //color: Colors.transparent,
      child: Container(
        alignment: Alignment.center,
        child: new Center(
          child: new Text(
            question,
            style: TextStyle(
                color: Hexcolor('#723D46'),
                fontSize: 13,
                fontWeight: FontWeight.w600,
                fontFamily: "Montserrat"),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
  

  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
      appBar: AppBar(
          //backgroundColor: Color(0xFFFCA311),
          backgroundColor: Hexcolor('#723D46'),
          title: Text("Additional ingredients?",
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Montserrat",
                  fontSize: 25))),
      body: Container(
        color: Hexcolor('#FFE1A8'),
          /*decoration: new BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("background3.png"), fit: BoxFit.cover)),*/
          child: Scaffold(
              backgroundColor: Colors.transparent,
              body: ListView(children: <Widget>[
                SingleChildScrollView(
                    child: Center(
                      child: Column(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(bottom: 20)),
                    _buildQuestions("To include a list of ingredients in your recipes, add them inside the textbox below (separated by commas)"),
                    _buildQuestions("Otherwise, click 'Randomized Meal Plan'!"),

                    //Padding(padding: EdgeInsets.only(bottom: 20)),
                    Container(
                      width: 330,
                      height: 80,
                      child: TextField(
                          controller: ingredientC,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Ingredients (e.g. apples, flour, sugar)',
                          ),
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Hexcolor('#723D46'),
                              fontWeight: FontWeight.bold),
                          onSubmitted: (String value) {
                            setState(() {
                              ingredients = ingredients +
                                  ", " +
                                  value; //This isn't really necessary?
                              //ingredients.add(value);
                              ingredientC.clear();
                              //value = "";
                            });
                          }),
                    ),
                    FloatingActionButton.extended(
                      heroTag: "showIngredients",
                      onPressed: () {
                        //String ingred = _createIngredientString();
                        //print(ingredientC.text);
                        String ingred = ingredientC.text;
                        return showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text(
                                    "The ingredients you have included are: \n" +
                                        ingred,
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: Hexcolor('#723D46'),
                                        //color: Color(0xFFFCA311),
                                        fontWeight: FontWeight.bold)),
                              );
                            }
                          );
                      },
                      label: Text(
                        "See currently added ingredients!",
                        style: new TextStyle(
                          color: Colors.white,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      backgroundColor: Color(0xFFFCA311),
                    ),

                    Padding(padding: EdgeInsets.only(bottom: 60)),

                    FloatingActionButton.extended(
                      heroTag: "RandomizedMealBut",
                      onPressed: () {
                        searchMealPlan();
                        //searchMealsByIngredients(ingredientC.text);
                        //NOTE TO SELF: CREATE A NEW BUTTON FOR INGREDIENTS, SEPARATE FROM RANDOMIZED BUTTON
                      },
                      label: Text(
                        "Completely Randomized Meal (Plan)",
                        style: new TextStyle(
                          color: Colors.white,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      //backgroundColor: Color(0xFFFCA311),
                      backgroundColor: Hexcolor('#E26D5C'),
                    ),
                    
                    Padding(padding: EdgeInsets.all(10)),

                    FloatingActionButton.extended(
                      heroTag: "SearchByIngredBut",
                      onPressed: () {
                        searchMealsByIngredients(ingredientC.text);
                      },
                      label: Text(
                        "Search Meals by Ingredients",
                        style: new TextStyle(
                          color: Colors.white,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      //backgroundColor: Color(0xFFFCA311),
                      backgroundColor: Hexcolor('#E26D5C'),
                    ),

                    Padding(padding: EdgeInsets.all(20)),
                    
                  ],
                )))
              ]
              )
            )
        ),
    );
  }
}
