import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../model/meal_model.dart';
import '../model/recipe_model.dart';

class RecipePage extends StatefulWidget {
  final Recipe recipe;
  final String mealType;
  final Meal meal;

  RecipePage({this.mealType, this.recipe, this.meal});

  @override
  State createState() {
    return new RecipePageState();
  }
}

class RecipePageState extends State<RecipePage> {
  @override
  Widget build(BuildContext context) {
    print("HI");
    print(widget.recipe.imageUrl);
    print(widget.meal.sourceUrl);

    return Scaffold(
      appBar: AppBar(title: Text(widget.mealType)),
      body: WebView(
        initialUrl:  widget.meal.sourceUrl,
        javascriptMode: JavascriptMode.unrestricted,
      ));
  }
}
