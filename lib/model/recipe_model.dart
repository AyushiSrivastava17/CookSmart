class Recipe {
  final String spoonacularSourceUrl;

  Recipe({
    this.spoonacularSourceUrl
  });

  //https://spoonacular.com/food-api/docs#Get-Recipe-Information
  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      spoonacularSourceUrl: map['spoonacularSourceUrl']
    );
  }

}