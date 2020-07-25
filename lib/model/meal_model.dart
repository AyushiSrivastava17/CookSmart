class Meal {
  final int id;
  final String title;
  final String imageType;
  final String imageURL;
  final int cookingTime;
  final int servings; 
  final String sourceUrl;

  Meal({this.id, this.title, this.imageType, this.imageURL, this.cookingTime, this.servings, this.sourceUrl});

  //given a string, dynamic means any type!
  //https://spoonacular.com/food-api/docs#Generate-Meal-Plan
  factory Meal.fromMap(Map<String, dynamic> map) {
    return Meal(
      id: map['id'],
      title: map['title'],
      imageType: map['imageType'],
      cookingTime: map['readyInMinutes'],
      servings: map['servings'],
      imageURL: 'https://spoonacular.com/recipeImages/' + map['id'].toString() + '-' + '556x370' + '.' + map['imageType'],
      sourceUrl: map['sourceUrl']
      //sourceUrl: 'https://spoonacular.com/recipes/' + map['title'].split(" ").join("-").toLowerCase().toString() + '-' + map['id'].toString()
    );
  }
}


