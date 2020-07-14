import 'package:flutter/material.dart';
import '../mechanics/multiselect.dart';
import '../mechanics/sliderCircle.dart';
import 'package:hexcolor/hexcolor.dart';

class QuizPage extends StatefulWidget {
  @override
  State createState() => new QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  Color _noneColor = Colors.indigo[50];
  Color _diabetesColor = Colors.indigo[50];
  Color _highBloodPressureColor = Colors.indigo[50];
  Color _lowBloodPressureColor = Colors.indigo[50];
  Color _highCholestrolColor = Colors.indigo[50]; 
  Set<String> healthConditions = Set();

  Color _mealColor = Colors.indigo[50];
  Color _mealPlanColor = Colors.indigo[50]; 
  Set<String> mealChoice = Set();

  double sliderValue = 0;
  List<MultiSelectDialogItem<int>> multiItem = List();

  final allergies = {
    1: "None",
    2: "Milk",
    3: "Shellfish",
    4: "Egg",
    5: "Fish",
    6: "Soybeans",
    7: "Wheat",
    8: "Nuts",
  };

  void populateMultiselect() {
    for (int v in allergies.keys) {
      multiItem.add(MultiSelectDialogItem(v, allergies[v]));
    }
  }

  void _showMultiSelect(BuildContext context, Set<int> selected) async {
    multiItem = [];
    populateMultiselect();
    final items = multiItem;

    final selectedValues = await showDialog<Set<int>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          items: items,
          initialSelectedValues: selected,
        );
      },
    );

    print(selectedValues);
    getvaluefromkey(selectedValues);
    selected.clear();
    selected.addAll(selectedValues);
  }

  void getvaluefromkey(Set selection) {
    if (selection != null) {
      for (int x in selection.toList()) {
        print(allergies[x]);
      }
    }
  }

  List<String> _diets = [
    'None',
    'Vegan',
    'Gluten Free',
    'Pescaterian',
    'Vegetarian'
  ];

  List<DropdownMenuItem<String>> dropdownDiets;
  String selectedDiet = "None";

  List<DropdownMenuItem<String>> buildDropdownMenuItems(List<String> diets) {
    List<DropdownMenuItem<String>> dietItems = List();
    for (String diet in diets) {
      dietItems.add(DropdownMenuItem(value: diet, child: Text(diet)));
    }
    return dietItems;
  }

  onChangeDropDownItem(String userDiet) {
    setState(() {
      selectedDiet = userDiet;
    });
  }

  @override
  Widget build(BuildContext context) {
    Set<int> selected = Set();
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Questionnaire",
            style: TextStyle(fontFamily: "MontSerrat", fontSize: 30)),
        backgroundColor: Hexcolor("#a974f4"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 25),
            ),
            Container(
              height: 75.0,
              width: 350.0,
              color: Colors.transparent,
              child: Container(
                child: new Center(
                  child: new Text(
                    "What is your preferred diet?",
                    style: TextStyle(
                        color: Hexcolor("#a974f4"),
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Montserrat"),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            DropdownButton(
              value: selectedDiet,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              items: buildDropdownMenuItems(_diets),
              style: TextStyle(color: Hexcolor("#a974f4"), fontSize: 18),
              underline: Container(
                height: 3,
                color: Hexcolor("#a974f4"),
              ),
              onChanged: onChangeDropDownItem,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 30),
            ),
            Container(
              height: 75.0,
              width: 350.0,
              color: Colors.transparent,
              child: Container(
                child: new Center(
                  child: new Text("What are your allergies?",
                      style: TextStyle(
                          color: Hexcolor("#a974f4"),
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Montserrat"),
                      textAlign: TextAlign.center),
                ),
              ),
            ),
            //Padding(padding: EdgeInsets.only(top: 10)),
            FloatingActionButton.extended(
              onPressed: () {
                if (selected.isEmpty) {
                  selected.add(1);
                }
                _showMultiSelect(context, selected);
                //getvaluefromkey(selected);
              },
              label: Text(
                'Open to Select',
                style: new TextStyle(color: Colors.white, fontSize: 15),
              ),
              backgroundColor: Hexcolor("#a974f4"),
            ),
            Padding(padding: EdgeInsets.all(20)),
            Container(
              height: 75.0,
              width: 350.0,
              color: Colors.transparent,
              child: Container(
                child: new Center(
                  child: new Text(
                      "Preferred maximum amount of calories in a meal?",
                      style: TextStyle(
                          color: Hexcolor("#a974f4"),
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Montserrat"),
                      textAlign: TextAlign.center),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(10)),

            SliderWidget(48, 0, 2500, false),

            Padding(padding: EdgeInsets.all(20)),

            Container(
              height: 75.0,
              width: 350.0,
              color: Colors.transparent,
              child: Container(
                child: new Center(
                  child: new Text("Any Preexisting Health Conditions?",
                      style: TextStyle(
                          color: Hexcolor("#a974f4"),
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Montserrat"),
                      textAlign: TextAlign.center),
                ),
              ),
            ),

            Padding(padding: EdgeInsets.all(10)),

            RaisedButton(
              color: _noneColor,
              onPressed: () {
                print("None was picked!");
                setState(() {
                  if (_noneColor == Colors.indigo[50]) {
                    _noneColor = Colors.blue[100];
                    healthConditions.add("N");
                  } else {
                    _noneColor = Colors.indigo[50];
                    healthConditions.remove("N");
                  }
                });
              },
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15)),
              child: Container(
                width: 300,
                height: 50,
                child: Center(
                  child: Text(
                    'None',
                    style: TextStyle(
                        color: Hexcolor("#a974f4"),
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Montserrat"),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),

            Padding(padding: EdgeInsets.all(5)),

            RaisedButton (
              color: _diabetesColor,
              onPressed: () {
                print("Diabetes was picked!");
                setState(() {
                  if (_diabetesColor == Colors.indigo[50]) {
                    healthConditions.add("D");
                    _diabetesColor = Colors.blue[100];
                  } else {
                    _diabetesColor = Colors.indigo[50];
                    healthConditions.remove("D");
                  }
                });
              },
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15)),
              child: Container(
                width: 300,
                height: 50,
                child: Center(
                  child: Text(
                    'Type 2 Diabetes',
                    style: TextStyle(
                        color: Hexcolor("#a974f4"),
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Montserrat"),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),

            Padding(padding: EdgeInsets.all(5)),

            RaisedButton(
              color: _highBloodPressureColor,
              onPressed: () {
                print("High Blood Pressure was picked!");
                setState(() {
                  if (_highBloodPressureColor == Colors.indigo[50]) {
                    _highBloodPressureColor = Colors.blue[100];
                    healthConditions.add("H");
                  } else {
                    _highBloodPressureColor = Colors.indigo[50];
                    healthConditions.remove("H");
                  }
                });
              },
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15)),
              child: Container(
                width: 300,
                height: 50,
                child: Center(
                  child: Text(
                    'High Blood Pressure',
                    style: TextStyle(
                        color: Hexcolor("#a974f4"),
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Montserrat"),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),

            Padding(padding: EdgeInsets.all(5)),

            RaisedButton(
              color: _lowBloodPressureColor,
              onPressed: () {
                print("Low Blood Pressure is pressed");
                setState(() {
                  if (_lowBloodPressureColor == Colors.indigo[50]) {
                    healthConditions.add("L");
                    _lowBloodPressureColor = Colors.blue[100];
                  } else {
                    _lowBloodPressureColor = Colors.indigo[50];
                    healthConditions.remove("L");
                  }
                });
              },
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15)),
              child: Container(
                width: 300,
                height: 50,
                child: Center(
                  child: Text(
                    'Low Blood Pressure',
                    style: TextStyle(
                        color: Hexcolor("#a974f4"),
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Montserrat"),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),

            Padding(padding: EdgeInsets.all(5)),

            RaisedButton(
              color: _highCholestrolColor,
              onPressed: () {
                print("Cholesterol was picked!");
                setState(() {
                  if (_highCholestrolColor == Colors.indigo[50]) {
                    healthConditions.add("C");
                    _highCholestrolColor = Colors.blue[100];
                  } else {
                    _highCholestrolColor = Colors.indigo[50];
                    healthConditions.remove("C");
                  }
                  print(healthConditions);
                });
              },
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15)),
              child: Container(
                width: 300,
                height: 50,
                child: Center(
                  child: Text(
                    'High Cholestrol',
                    style: TextStyle(
                        color: Hexcolor("#a974f4"),
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Montserrat"),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),

            Padding(padding: EdgeInsets.only(top: 40)),

            Container(
              height: 75.0,
              width: 350.0,
              color: Colors.transparent,
              child: Container(
                child: new Center(
                  child: new Text(
                      "Looking for a single meal or a daily meal plan?",
                      style: TextStyle(
                          color: Hexcolor("#a974f4"),
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Montserrat"),
                      textAlign: TextAlign.center),
                ),
              ),
            ),
            
             Padding(padding: EdgeInsets.only(top: 20)),

              RaisedButton(
              color: _mealPlanColor,
              onPressed: () {
                print("Meal Plan is pressed");
                setState(() {
                  if (_mealPlanColor == Colors.indigo[50]) {
                     mealChoice.add("P");
                    _mealPlanColor = Colors.blue[100];
                  } else {
                    _mealPlanColor = Colors.indigo[50];
                    mealChoice.remove("P");
                  }
                });
              },
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15)),
              child: Container(
                width: 300,
                height: 50,
                child: Center(
                  child: Text(
                    'Meal Plan',
                    style: TextStyle(
                        color: Hexcolor("#a974f4"),
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Montserrat"),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),

            Padding(padding: EdgeInsets.all(5)),

            RaisedButton(
              color: _mealColor,
              onPressed: () {
                print("Meal is pressed!");
                setState(() {
                  if (_mealColor == Colors.indigo[50]) {
                    mealChoice.add("M");
                    _mealColor = Colors.blue[100];
                  } else {
                    _mealColor = Colors.indigo[50];
                    mealChoice.remove("M");
                  }
                  print(mealChoice);
                });
              },
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15)),
              child: Container(
                width: 300,
                height: 50,
                child: Center(
                  child: Text(
                    'Single Meal',
                    style: TextStyle(
                        color: Hexcolor("#a974f4"),
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Montserrat"),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),

            Padding(padding: EdgeInsets.only(top: 50)),

          ]),
        ),
      ),
    );
  }
}
