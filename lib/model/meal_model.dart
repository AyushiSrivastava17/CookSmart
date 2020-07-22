class Meal {
  final int id;
  final String title;
  final String imageType;
  final String imageURL;

  Meal({this.id, this.title, this.imageType, this.imageURL});

  //given a string, dynamic means any type!
  //https://spoonacular.com/food-api/docs#Generate-Meal-Plan
  factory Meal.fromMap(Map<String, dynamic> map) {
    return Meal(
      id: map['id'],
      title: map['title'],
      imageType: map['imageType'],
      imageURL: 'https://spoonacular.com/recipeImages/' + map['id'].toString() + '-' + '556x370' + '.' + map['imageType']
    );
  }
}


