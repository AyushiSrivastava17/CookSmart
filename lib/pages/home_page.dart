import 'package:flutter/material.dart';
import '../pages/quiz_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("homeBackground.png"), fit: BoxFit.cover
            )
        ),
      //InkWell is a property like an invisible button that allows us to register taps!
      child: new Scaffold (
        backgroundColor: Colors.transparent,
        body: new Center(
          child: Column(
          children: <Widget>[
            new Padding(
              padding: EdgeInsets.only(top: 50),
              child: new Image(
                image: AssetImage('Title.png') 
              )
            ),
            new Padding(
              padding: EdgeInsets.only(bottom: 50),
              child: new Image(
                image: AssetImage('CookSmart_logo.png'),
                width: 250,
                height: 250
              )
            ),
            FloatingActionButton.extended(
              onPressed: () {
                // Add your onPressed code here!
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizPage()),
                );
              },
              label: Text(
                'Search for new recipes!',
                style: new TextStyle(
                  color: Colors.black,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold,
                ),
              ),
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              backgroundColor: Color(0xFFDABFFF),
            ),
          ],
        ))
       )
      ),
    );
  }
}
