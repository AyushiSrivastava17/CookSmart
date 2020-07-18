import 'dart:convert';
import 'dart:io';
import 'dart:async' show Future;
import 'package:http/http.dart' as http;
import '../model/meal_model.dart';
import '../model/meal_plan_model.dart';
import '../model/recipe_model.dart';

class APIService {
  //The API Service is a singleton (only 1 instance of the class is ever created).
  //Thus, we create a private constructor and static instance variable
  APIService._privateConstructor();
  static final APIService _instance = APIService._privateConstructor();

  final String _baseUrl = 'api.spoonacular.com';
  static const String API_KEY = '7c8f561b7b59491aba99a36c6addbf74';

  //https://spoonacular.com/food-api/docs#Generate-Meal-Plan
  //An async function to generate a meal plan.
  //API parameters are timeFrame, targetCalories, diet and exclude
  Future<MealPlan> generateMealPlan({String diet, String allergies}) async {
    if (diet == 'None') {
      diet = ''; //Set diet to be an empty string!
    }
    //Allergies is a comma-seperated string of things to exclude
    if (allergies.contains('None')) {
      allergies = '';
    }

    //NOTE: I WILL LATER HAVE TO GO BACK HERE AND INCLUDE targetCalories
    Map<String, dynamic> parameters = {
      'timeFrame': 'day', //3 meals in a day
      'diet': diet,
      'exclude': allergies,
      'apiKey': API_KEY //DO I NEED THIS???
    };

    Uri uri = Uri.https(
      _baseUrl,
      '/mealplanner/generate', //GET REQUEST URL?
      parameters,
    );

    //Headers, return a json object
    Map<String, dynamic> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try {
      var response = await http.get(uri, headers: headers);
      Map<String, dynamic> data = json.decode(response.body);
      MealPlan mealPlan =
          MealPlan.fromMap(data); //uses the factory constructor here

    } catch (err) {
      throw err.toString();
    }
  }
}