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
  void searchMealPlan() async {
    MealPlan mealPlan = await APIService.instance.generateMealPlan(
      diet: widget.selectedDiet,
      allergies: makeAllergyString(),
      targetCalories: widget.sliderValue.single.toInt() * 2500,
    );

    Navigator.push(context, 
      MaterialPageRoute(builder: (context) => MealPage(
        mealPlan: mealPlan
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
    /*print(this.widget.selectedDiet);
    print((this.widget.sliderValue.single * 2500).toString());
    print(this.widget.healthConditions);
    print(this.widget.allergies);
    print(this.widget.mealChoice);*/

    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: <Widget>[
          FloatingActionButton.extended(
            onPressed: () => searchMealPlan(),

            label: Text(
              'TESTING',
              style: new TextStyle(
                color: Colors.black,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Color(0xFFDABFFF),
          )
        ],
      ),
    );
  }
}