class Recipe {
  final String spoonacularSourceUrl;
  final String imageUrl;
  final String cookingTime;

  Recipe({
    this.spoonacularSourceUrl,
    this.imageUrl,
    this.cookingTime
  });

  //https://spoonacular.com/food-api/docs#Get-Recipe-Information
  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      spoonacularSourceUrl: map['spoonacularSourceUrl'],
      imageUrl: map['image'],
      cookingTime: map['readyInMinutes']
    );
  }

}