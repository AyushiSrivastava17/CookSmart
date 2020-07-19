import 'package:flutter/cupertino.dart';
import '../model/recipe_model.dart';

class RecipePage extends StatefulWidget {
  final Recipe recipe;
  final String mealType;

  RecipePage({this.mealType, this.recipe});

  @override
  State createState() {
    return new RecipePageState();
  }
}

class RecipePageState extends State<RecipePage> {
  @override
  Widget build(BuildContext context) {}
}
