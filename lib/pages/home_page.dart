import 'package:flutter/material.dart';
import '../pages/quiz_page.dart';
import '../pages/custom_meal.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("homeBackground.png"), fit: BoxFit.cover)),
          //InkWell is a property like an invisible button that allows us to register taps!
          child: new Scaffold(
              backgroundColor: Colors.transparent,
              body: new Center(
                  child: Column(
                children: <Widget>[
                  new Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: new Image(image: AssetImage('Title.png'))),
                  new Padding(
                      padding: EdgeInsets.only(bottom: 40),
                      child: new Image(
                        image: AssetImage('CookSmart_logo.png'),
                        width: 175,
                        height: 175,
                      )),
                  FloatingActionButton.extended(
                    onPressed: () {
                      // Add your onPressed code here!
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => QuizPage()),
                        //MaterialPageRoute(builder: (context) => CustomPage()),
                      );
                    },
                    label: Text(
                      'Search for new recipes!',
                      style: new TextStyle(
                        color: Color(0xFFFF7477),
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    ),
                    icon: Icon(
                      Icons.search,
                      color: Color(0xFFFF7477),
                    ),
                    backgroundColor: Color(0xFFA7C8FF),
                  ),
                ],
              )))),
    );
  }
}
