import 'package:flutter/material.dart';
import '../mechanics/multiselect.dart';

class QuizPage extends StatefulWidget {
  @override
  State createState() => new QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  List <MultiSelectDialogItem<int>> multiItem = List();

  final allergies = {
    1 : "None",
    2 : "Milk",
    3 : "Shellfish",
    4 : "Egg",
    5 : "Fish",
    6 : "Soybeans",
    7 : "Wheat",
    8 : "Nuts",
  };

  void populateMultiselect(){
    for(int v in allergies.keys){
      multiItem.add(MultiSelectDialogItem(v, allergies[v]));
    }
  }
    void _showMultiSelect(BuildContext context) async {
      multiItem = [];
      populateMultiselect();
      final items = multiItem;

    final selectedValues = await showDialog<Set<int>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          items: items,
          initialSelectedValues: [1].toSet(),
        );
      },
    );

    print(selectedValues);
    getvaluefromkey(selectedValues);
  }

  void getvaluefromkey(Set selection){
    if(selection != null){
      for(int x in selection.toList()){
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
      dietItems.add(DropdownMenuItem(
        value: diet, 
        child: Text(diet)
        )
      );
    }
    return dietItems;
  }

  onChangeDropDownItem(String userDiet) {
    setState(() {
      selectedDiet = userDiet;
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Questionnaire",
              style: TextStyle(fontFamily: "MontSerrat", fontSize: 30)),
          backgroundColor: Color(0xFF7A9BEE),
        ),
        body: Center(
            child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Padding(
                    padding: EdgeInsets.only(top: 50),
                  ),
              Container(
                height: 75.0,
                width: 350.0,
                color: Colors.transparent,
                child: Container (
                  child: new Center(
                    child: new Text("What is your preferred diet?",
                        style: TextStyle(
                            color: Color(0xFF7A9BEE),
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Montserrat"),
                        textAlign: TextAlign.center),
                  ),
                ),
              ),
             
              DropdownButton(
                value: selectedDiet,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                items: buildDropdownMenuItems(_diets),
                style: TextStyle(
                  color: Color(0xFF7A9BEE),
                  fontSize: 18),
                underline: Container(
                height: 3,
                color: Color(0xFF7A9BEE),
                ),
                onChanged: onChangeDropDownItem,
              ),

            Padding(
              padding: EdgeInsets.only(bottom: 50),),
              
            Container(
                height: 75.0,
                width: 350.0,
                color: Colors.transparent,
                child: Container (
                  child: new Center(
                    child: new Text("What are your allergies / food intolerances?",
                        style: TextStyle(
                            color: Color(0xFF7A9BEE),
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Montserrat"),
                        textAlign: TextAlign.center),
                  ),
                ),
              ),
              FloatingActionButton.extended(
              onPressed: () {
                _showMultiSelect(context);
              },
              label: Text('Open to Select',
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 15
                ),
                ),
              backgroundColor: Color(0xFF7A9BEE),
            ),
            ]
          )
        )
    );
  }
}
