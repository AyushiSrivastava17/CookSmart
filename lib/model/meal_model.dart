class Meal {
  final int id;
  final String title;
  final String imgURL;

  Meal({
    this.id, 
    this.title, 
    this.imgURL
  });

  //given a string, dynamic means any type!
  //https://spoonacular.com/food-api/docs#Generate-Meal-Plan
  factory Meal.fromMap(Map<String, dynamic> map) {
    return Meal(
      id: map['id'],
      title: map['title'],

      //NOTE: THE DOC IS OUTDATED, THERE IS A SOURCE URL BUT NOT AN IMAGE URL
      //imgURL: 'https://spoonacular.com/recipeImages/' + map['image'],
    );
  }
}


