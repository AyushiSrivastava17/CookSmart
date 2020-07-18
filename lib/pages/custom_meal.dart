import 'package:CookSmart/mechanics/multiselect.dart';
import '../mechanics/sliderCircle.dart';
import 'package:flutter/material.dart';
import '../pages/quiz_page.dart';

class CustomPage extends StatefulWidget {
  final String selectedDiet; 
  final Set<String> healthConditions;
  final Set<String> mealChoice; 
  final Set<int> allergies; 
  final Set<double> sliderValue;
  final List<MultiSelectDialogItem<int>> foodAllergyDict;

  CustomPage(
    {this.selectedDiet, 
    this.healthConditions,
    this.mealChoice,
    this.allergies,
    this.sliderValue,
    this.foodAllergyDict}
  );

  @override
  State createState() {
    return new CustomPageState();
  } 
}

class CustomPageState extends State<CustomPage> {
  @override
  Widget build(BuildContext context) {
    print(this.widget.selectedDiet);
    print((this.widget.sliderValue.single * 2500).toString());
    print(this.widget.healthConditions);
    print(this.widget.allergies);
    print(this.widget.mealChoice);
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: <Widget>[],
      ),
    );
  }
}