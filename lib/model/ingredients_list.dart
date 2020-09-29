// To parse this JSON data, do
//
//     final welcome = welcomeFromMap(jsonString);

import 'dart:convert';

List<SearchIngredients> welcomeFromMap(String str) =>
    List<SearchIngredients>.from(json.decode(str).map((x) => SearchIngredients.fromMap(x)));

String welcomeToMap(List<SearchIngredients> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class SearchIngredients {
  final int id;
  final String image;
  final String title;
  final String sourceUrl;

  SearchIngredients({
    this.id,
    this.image,
    this.title,
    this.sourceUrl
  });

  factory SearchIngredients.fromMap(Map<String, dynamic> json) => SearchIngredients(
        id: json["id"],
        image: json["image"],
        title: json["title"],
        sourceUrl: 'https://spoonacular.com/recipes/' + json['title'].split(" ").join("-").toLowerCase().toString() + '-' + json['id'].toString() + ''
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "image": image,
        "title": title,
        "sourceUrl": sourceUrl
      };
}
