import 'package:CookSmart/model/ingredients_model.dart';

class SearchIngredientsList {
  final List<SearchIngredients> ingredientRecipes;

  //https://spoonacular.com/food-api/docs#Search-Recipes-by-Ingredients

  SearchIngredientsList({this.ingredientRecipes});

  factory SearchIngredientsList.fromMap(Map<String, dynamic> map) {
    List<SearchIngredients> list = [];
    //list = List<SearchIngredients>.from(response.data.map((i) => SearchIngredients.fromMap(i)));


    return SearchIngredientsList();
  }
}
