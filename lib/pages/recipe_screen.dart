import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../model/meal_model.dart';
import '../model/recipe_model.dart';
import 'dart:async';

class RecipePage extends StatefulWidget {
  final Recipe recipe;
  final String mealType;
  final Meal meal;

  RecipePage({this.mealType, this.recipe, this.meal});

  @override
  State createState() {
    return new RecipePageState();
  }
}

class RecipePageState extends State<RecipePage> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  Set<String> _favorites = Set<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mealType),
        actions: <Widget>[
          Menu(_controller.future, _favorites),
        ],
      ),
      body: WebView(
        initialUrl: widget.meal.sourceUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
      floatingActionButton: _saveRecipe(),
    );
  }

  _saveRecipe() {
    return FutureBuilder<WebViewController>(
      future: _controller.future,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> controller) {
        if (controller.hasData) {
          return FloatingActionButton(
            onPressed: () async {
              var url = await controller.data.currentUrl();
              _favorites.add(url);
              Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text('Saved to favorited recipes!')));
            },
            child: Icon(Icons.favorite),
          );
        }
        return Container();
      },
    );
  }
}

class Menu extends StatelessWidget {
  final Future<WebViewController> _webViewControllerFuture;
  final Set<String> favorites;
  Menu(this._webViewControllerFuture, this.favorites);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _webViewControllerFuture,
        builder: (BuildContext context,
            AsyncSnapshot<WebViewController> controller) {
          if (!controller.hasData) {
            return Container();
          }
          return PopupMenuButton<String>(
            onSelected: (String value) async {
              if (value == 'See Favorites') {
                var newUrl = await Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return FavoritesPage(favorites);
                }));
                Scaffold.of(context).removeCurrentSnackBar();
                if (newUrl != null) controller.data.loadUrl(newUrl);
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
              const PopupMenuItem<String>(
                value: 'See Favorites',
                child: Text('See Favorites'),
              ),
            ],
          );
        });
  }
}

class FavoritesPage extends StatelessWidget {
  final Set<String> favorites;
  FavoritesPage(this.favorites);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Favorited Recipes')),
        body: ListView(
            children: favorites
                .map((url) => ListTile(
                    title: Text(url), onTap: () => Navigator.pop(context, url)))
                .toList()));
  }
}
