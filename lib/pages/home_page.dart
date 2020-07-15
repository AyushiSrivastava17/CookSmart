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
                image: AssetImage('Logo.png') 
              )
            ),
            new Padding(
                padding: EdgeInsets.only(bottom: 80),
                child: new Container(
                  decoration: new BoxDecoration(
                    color: Color(0xFF84DCC6),
                    shape: BoxShape.circle,
                  ),
                  child: new Icon(Icons.home, size: 100),
                )),
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
                ),
              ),
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              backgroundColor: Color(0xFF84DCC6),
            ),
          ],
        ))
       )
      ),
    );
  }
}
