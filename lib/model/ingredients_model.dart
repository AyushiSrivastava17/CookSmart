class SearchIngredients {
  final int id;
  final String title;
  final String image;
  final String sourceUrl;

  //https://spoonacular.com/food-api/docs#Search-Recipes-by-Ingredients

  SearchIngredients({this.id, this.title, this.image, this.sourceUrl});

  factory SearchIngredients.fromMap(Map<String, dynamic> map) {
    return SearchIngredients(
      id: map['id'],
      title: map['title'],
      image: map['image'],
      sourceUrl: 'https://spoonacular.com/recipes/' + map['title'].split(" ").join("-").toLowerCase().toString() + '-' + map['id'].toString()
    );
  }
}
