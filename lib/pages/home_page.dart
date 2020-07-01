import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.teal[400], // Color dependent on palette!!
      //InkWell is a property like an invisible button that allows us to register taps!
      child: new InkWell(
        //onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new QuizPage())),
        //since a column takes multiple widgets and displays them beneath each other(?), uses children and not child
        child: new Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Padding(
              padding: EdgeInsets.only(top: 100),
              child:
                new Text("Hobbies",
                style: new TextStyle(
                color: Colors.white,
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat'
                ),
              ),
            ),
            new Padding(
              padding: EdgeInsets.only(bottom: 100),
              child:
                new Text("@ Home",
                style: new TextStyle(
                color: Colors.white,
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat'
                ),
              ),
            ),
            new Padding(
              padding: EdgeInsets.only(bottom: 100),
              child: 
                new Container(
                decoration: new BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,                
                ),
                child: new Icon(
                  Icons.home,
                  size: 100),
                )
            ),
            FloatingActionButton.extended(
              onPressed: () {
                // Add your onPressed code here!
              },
              label: Text('Search for new recipes!',
                style: new TextStyle(
                  color: Colors.green[900],
                ),
                ),
              icon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              backgroundColor: Colors.white,
            ),
          ],

        )
      ),
    );
  }
}