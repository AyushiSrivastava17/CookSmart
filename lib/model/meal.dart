class Meal {
  final int id;
  final String title;
  final String imgURL;

  Meal({this.id, this.title, this.imgURL});

  //given a string, dynamic means any type!
  factory Meal.fromMap(Map<String, dynamic> map) {
    return Meal(
      id: map['id'],
      title: map['title'],

      //IS THIS CORRECT?!
      imgURL: 'https://spoonacular.com/recipeImages/' + map['image'],
    );
  }
}
