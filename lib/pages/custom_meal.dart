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
  List<String> entries = <String>[];
  
  void addItemToList() {
    if (!entries.contains(ingredientC.text)){
      setState(() {
        entries.insert(0, ingredientC.text);
      });
    }
    //print("In addItemToList(): " + entries.last);
  }

  void searchMealPlan() async {
    int calories = (1500 + (widget.sliderValue.single.toInt() * 1000));
    MealPlan mealPlan = await APIService.instance.generateMealPlan(
      diet: widget.selectedDiet,
      allergies: makeAllergyString(),
      targetCalories: calories,
    );

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MealPage(
            mealPlan: mealPlan,
            selectedMealPlan: widget.selectedMealPlan,
          ),
        ));
  }

  void searchMealsByIngredients(List<String> entries) async {
    String ingredients = entriesListToString();
    List<SearchIngredients> searchIngred =
        await APIService.instance.searchByIngredients(ingredients: ingredients);

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

  String entriesListToString() {
    String listString = "";
    if (entries.length == 1) {
      listString += entries.last.toLowerCase();
    } else {
      for (int x = 0; x < entries.length - 1; x++) {
        listString += entries.elementAt(x).toLowerCase();
        listString += ", ";
      }
      listString += entries.last.toLowerCase();
    }
    return listString;
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
        //color: Hexcolor('#FFE1A8'),
        decoration: new BoxDecoration(
          image: DecorationImage(
          image: AssetImage("homeBackground1.png"), fit: BoxFit.cover)
        ),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              body: ListView(children: <Widget>[
                SingleChildScrollView(
                    child: Center(
                      child: Column(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(bottom: 20)),
                    _buildQuestions("To include a list of ingredients (preferably for single meals), add them inside the textbox below! Duplicates will not be shown"),
                    Container(
                      height: 50.0,
                      width: 370.0,
                      //color: Colors.transparent,
                      child: Container(
                        alignment: Alignment.center,
                        child: new Center(
                          child: new Text(
                            "Tap an added Ingredient to delete it from custom ingredients to look for!",
                            style: TextStyle(
                                color: Hexcolor('#723D46'),
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                fontFamily: "Montserrat-Bold"),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    _buildQuestions("Otherwise, tap 'Randomized Meal (Plan)'!"),

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
                        if (entries.length == 0){
                          return showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: new Text("No Ingredients were entered!",
                                  style: TextStyle(
                                      color: Hexcolor("#723D46"),
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Montserrat"),
                                  textAlign: TextAlign.center,
                                ),
                                content: new Text(
                                  "We can't do a search without being given ingredients. Would you want a completely randomized meal (plan) instead?",
                                  style: TextStyle(
                                      color: Hexcolor("#E26D5C"),
                                      fontSize: 20,
                                      fontFamily: "Montserrat"),
                                  textAlign: TextAlign.center,
                                ),
                                shape: new RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(15)),
                                actions: <Widget>[
                                  // usually buttons at the bottom of the dialog
                                  new FlatButton(
                                    child: new Text("Ok", style: TextStyle(fontSize: 17)),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            }
                          );
                        } else {
                          searchMealsByIngredients(entries);
                        }
                      },
                      label: Text(
                        "Search for Meals by Ingredients",
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
                    Container(
                      width: 330,
                      height: 80,
                      child: TextField(
                          controller: ingredientC,
                          autocorrect: true, // autocorrect is available for ingredients
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Ingredients (e.g. apples, flour, sugar)',
                          ),
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Hexcolor('#723D46'),
                            fontWeight: FontWeight.bold
                          ),
                          onSubmitted: (value) {
                            addItemToList();
                            ingredientC.clear();
                            value = "";
                          },
                        ),
                      ),
                      entries.length > 0 ?
                        ListView.separated(
                        padding: const EdgeInsets.all(8),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true, 
                        itemCount: entries.length,
                        itemBuilder: (BuildContext context, int index) {
                          return FloatingActionButton.extended(
                            heroTag: "AddedIngredient" + index.toString(),
                            onPressed: () {
                              setState(() {
                                entries.removeAt(index);
                              });
                            },
                            label: Text(
                              '${entries[index]}', 
                              style: TextStyle(
                                color: Colors.white, 
                                fontFamily: 'Montserrat-Bold', 
                                fontSize: 18
                              )
                            ),
                            backgroundColor: Color(0xFFFCA311),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) => const Divider(),
                        ) 
                        : Center(
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            height: 50,
                            color: Color(0xFFFCA311),
                            child: Center(child: Text('Ingredients entered will be shown here ...', style: TextStyle(color: Colors.white, fontFamily: 'Montserrat-Bold', fontSize: 18))),
                          )
                        ),
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
}
