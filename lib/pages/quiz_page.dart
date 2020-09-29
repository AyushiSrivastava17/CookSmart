import 'package:flutter/material.dart';
import '../mechanics/multiselect.dart';
import '../mechanics/sliderCircle.dart';
import 'package:hexcolor/hexcolor.dart';
import '../pages/custom_meal.dart';
import '../model/meal_plan_model.dart';
import '../services/services.dart';

class QuizPage extends StatefulWidget {
  @override
  State createState() => new QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  Color _noneColor = Colors.white;
  Color _diabetesColor = Colors.white;
  Color _highBloodPressureColor = Colors.white;
  Color _lowBloodPressureColor = Colors.white;
  Color _highCholestrolColor = Colors.white;
  Set<String> healthConditions = Set();

  Color _mealColor = Colors.white;
  Color _mealPlanColor = Colors.white;
  Set<String> mealChoice = Set();

  Set<int> selected = Set();

  SliderWidget slider;
  Set<double> sliderSet = Set();
  List<MultiSelectDialogItem<int>> multiItem = List();

  final allergiesDict = {
    1: "None",
    2: "Dairy",
    3: "Shellfish",
    4: "Egg",
    5: "Seafood",
    6: "Soy",
    7: "Wheat",
    8: "Peanut",
  };

  bool selectedMealPlan;

  void populateMultiselect() {
    for (int v in allergiesDict.keys) {
      multiItem.add(MultiSelectDialogItem(v, allergiesDict[v]));
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
        print(allergiesDict[x]);
      }
    }
  }

  List<String> _diets = [
    'None',
    'Vegan',
    'Gluten Free',
    'Pescatarian',
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
    return new Scaffold(
        //backgroundColor: Hexcolor("#d4dcf2"),
        appBar: AppBar(
          title: Text("Questionnaire",
              style: TextStyle(fontFamily: "MontSerrat", fontSize: 30)),
          backgroundColor: Hexcolor("#a974f4"),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              decoration: new BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("homeBackground2.png"), fit: BoxFit.fill)),
            ),
            SingleChildScrollView(
              child: Center(
                child: Column(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),
                  _buildQuestions("What is your preferred diet?"),
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
                  _buildQuestions(
                      "Do you have any allergies/food intolerances?"),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  FloatingActionButton.extended(
                    heroTag: "btn1",
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
                  _buildQuestions("Preferred amount of calories in a day?"),
                  Padding(padding: EdgeInsets.all(10)),
                  slider = SliderWidget(48, 1500, 2500, false, sliderSet),
                  Padding(padding: EdgeInsets.all(20)),
                  _buildQuestions("Any preexisting health conditions?"),
                  Padding(padding: EdgeInsets.all(10)),
                  RaisedButton(
                      color: _noneColor,
                      onPressed: () {
                        print("None was picked!");
                        setState(() {
                          if (_noneColor == Colors.white) {
                            _noneColor = Colors.blue[100];
                            healthConditions.add("N");
                          } else {
                            _noneColor = Colors.white;
                            healthConditions.remove("N");
                          }
                        });
                      },
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15)),
                      child: _buildButtons("None")),
                  Padding(padding: EdgeInsets.all(5)),
                  RaisedButton(
                    color: _diabetesColor,
                    onPressed: () {
                      print("Diabetes was picked!");
                      setState(() {
                        if (_diabetesColor == Colors.white) {
                          healthConditions.add("D");
                          _diabetesColor = Colors.blue[100];
                        } else {
                          _diabetesColor = Colors.white;
                          healthConditions.remove("D");
                        }
                      });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(15)),
                    child: _buildButtons("Type 2 Diabetes"),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  RaisedButton(
                      color: _highBloodPressureColor,
                      onPressed: () {
                        print("High Blood Pressure was picked!");
                        setState(() {
                          if (_highBloodPressureColor == Colors.white) {
                            _highBloodPressureColor = Colors.blue[100];
                            healthConditions.add("H");
                          } else {
                            _highBloodPressureColor = Colors.white;
                            healthConditions.remove("H");
                          }
                        });
                      },
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15)),
                      child: _buildButtons("High Blood Pressure")),
                  Padding(padding: EdgeInsets.all(5)),
                  RaisedButton(
                      color: _lowBloodPressureColor,
                      onPressed: () {
                        print("Low Blood Pressure is pressed");
                        setState(() {
                          if (_lowBloodPressureColor == Colors.white) {
                            healthConditions.add("L");
                            _lowBloodPressureColor = Colors.blue[100];
                          } else {
                            _lowBloodPressureColor = Colors.white;
                            healthConditions.remove("L");
                          }
                        });
                      },
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15)),
                      child: _buildButtons("Low Blood Pressure")),
                  Padding(padding: EdgeInsets.all(5)),
                  RaisedButton(
                      color: _highCholestrolColor,
                      onPressed: () {
                        print("Cholesterol was picked!");
                        setState(() {
                          if (_highCholestrolColor == Colors.white) {
                            healthConditions.add("C");
                            _highCholestrolColor = Colors.blue[100];
                          } else {
                            _highCholestrolColor = Colors.white;
                            healthConditions.remove("C");
                          }
                          print(healthConditions);
                        });
                      },
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15)),
                      child: _buildButtons("High Cholesterol")),
                  Padding(padding: EdgeInsets.only(top: 40)),
                  _buildQuestions(
                      "Looking for a single meal or a daily meal plan?"),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  RaisedButton(
                      color: _mealPlanColor,
                      onPressed: () {
                        selectedMealPlan = true;
                        print("Meal Plan is pressed");
                        setState(() {
                          if (_mealPlanColor == Colors.white) {
                            mealChoice.add("P");
                            _mealPlanColor = Colors.blue[100];
                          } else {
                            _mealPlanColor = Colors.white;
                            mealChoice.remove("P");
                          }
                        });
                      },
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15)),
                      child: _buildButtons("Meal Plan")),
                  Padding(padding: EdgeInsets.all(5)),
                  RaisedButton(
                      color: _mealColor,
                      onPressed: () {
                        selectedMealPlan = false;
                        print("Meal is pressed!");
                        setState(() {
                          if (_mealColor == Colors.white) {
                            mealChoice.add("M");
                            _mealColor = Colors.blue[100];
                          } else {
                            _mealColor = Colors.white;
                            mealChoice.remove("M");
                          }
                          print(mealChoice);
                        });
                      },
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15)),
                      child: _buildButtons("Single Meal")),
                  Padding(padding: EdgeInsets.only(top: 50)),
                  FloatingActionButton.extended(
                    //splashColor: Hexcolor("#a974f4"),
                    heroTag: 'btn2',
                    onPressed: () {
                      if (selected.isEmpty) {
                        selected
                            .add(1); // add None to it before leaving this page
                      }
                      if (selected.contains(3) &&
                          selected.contains(5) &&
                          selectedDiet == 'Pescatarian') {
                        selectedDiet = 'Vegetarian';
                      }
                      if (sliderSet.isEmpty) {
                        sliderSet.add(0.0);
                      }
                      if (healthConditions.isEmpty || mealChoice.isEmpty) {
                        // if no health conditions were answered
                        _showDialog("Some questions are still unanswered!",
                            "One or more of the bottom three questions was unanswered");
                      } else if (mealChoice.length == 2) {
                        // selected both options in meal plan
                        _showDialog("We're confused!",
                            "You've selected both a single meal and the meal plan, please unselect one of them");
                      } else if (healthConditions.length > 1 &&
                          healthConditions.contains("N")) {
                        _showDialog("Schrodinger's Health conditions!",
                            "You've selected 'None' and health condition(s), please fix this");
                      } else if (healthConditions.contains("H") &&
                          healthConditions.contains("L")) {
                        _showDialog("High AND Low Blood Pressure?",
                            "Both these options were selected as health conditions, please unselect one of them");
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CustomPage(
                                selectedMealPlan: selectedMealPlan,
                                selectedDiet: selectedDiet,
                                healthConditions: healthConditions,
                                mealChoice: mealChoice,
                                allergies: selected,
                                sliderValue: sliderSet,
                                foodAllergyDict: allergiesDict),
                          ),
                        );
                      }
                    },
                    label: Text(
                      'Submit!',
                      style: new TextStyle(
                          color: Hexcolor("#a974f4"),
                          fontWeight: FontWeight.bold),
                    ),
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                    ),
                    backgroundColor: Colors.white,
                  ),
                  Padding(padding: EdgeInsets.only(top: 50)),
                ]),
              ),
            )
          ],
        ));
  }

  Widget _buildQuestions(String question) {
    return Container(
      height: 75.0,
      width: 350.0,
      color: Colors.transparent,
      child: Container(
        child: new Center(
          child: new Text(
            question,
            style: TextStyle(
                color: Hexcolor("#a974f4"),
                fontSize: 25,
                fontWeight: FontWeight.w800,
                fontFamily: "Montserrat"),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildButtons(String text) {
    return Container(
      width: 300,
      height: 50,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              color: Hexcolor("#a974f4"),
              fontSize: 23,
              fontWeight: FontWeight.bold,
              fontFamily: "Montserrat"),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  void _showDialog(String mainTitle, String reminder) {
    // for empty health conditions set
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            mainTitle,
            style: TextStyle(
                color: Hexcolor("#a974f4"),
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: "Montserrat"),
            textAlign: TextAlign.center,
          ),
          content: new Text(
            reminder,
            style: TextStyle(
                color: Hexcolor("#a974f4"),
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
      },
    );
  }
}
