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
  static final APIService instance = APIService._privateConstructor();

  final String _baseURL = 'api.spoonacular.com';
  static const String API_KEY = '7c8f561b7b59491aba99a36c6addbf74';

  //https://spoonacular.com/food-api/docs#Generate-Meal-Plan
  //An async function to generate a meal plan.
  //API parameters are timeFrame, targetCalories, diet and exclude
  Future<MealPlan> generateMealPlan(
      {String diet, String allergies, int targetCalories}) async {
    if (diet == 'None') {
      diet = ''; //Set diet to be an empty string!
    }
    //Allergies is a comma-seperated string of things to exclude
    //WE NEED TO CONVERT OUR ALLERGIES LIST TO A SINGLE STRING?

    if (allergies.contains('None')) {
      allergies = '';
    }

    Map<String, String> parameters = {
      'timeFrame': 'day', //3 meals in a day
      'targetCalories': targetCalories.toString(),
      'diet': diet,
      'exclude': allergies,
      'apiKey': API_KEY
    };

    Uri uri = Uri.https(
      _baseURL,
      '/mealplanner/generate', //GET REQUEST URL? Endpoint we're using
      parameters,
    );

    //Headers, return a json object
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try {
      var response = await http.get(uri, headers: headers);
      Map<String, dynamic> data = json.decode(response.body);
      MealPlan mealPlan =
          MealPlan.fromMap(data); //uses the factory constructor here
      return mealPlan;
    } catch (err) {
      throw err.toString();
    }
  }

  //Takes the ID of the recipe you want information from
  Future<Recipe> fetchRecipe({int id}) async {
    Map<String, String> parameters = {
      'includeNutrition': 'false',
      'apiKey': API_KEY
    };

    //Include the recipe ID in the uri and parse in parameters
    String idString = id.toString();
    String recipeParam = '/recipes/\$' + idString + '/information';
    Uri uri = Uri.https(
      _baseURL,
      recipeParam,
      parameters,
    );

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try {
      var response = await http.get(uri, headers: headers);
      Map<String, dynamic> data = json.decode(response.body);
      Recipe recipe = Recipe.fromMap(data);
      return recipe;
    } catch (err) {
      throw err.toString();
    }
  }
}