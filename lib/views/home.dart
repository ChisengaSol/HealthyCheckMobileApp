import 'dart:convert';
import 'dart:io';
import 'package:healthycheck/models/recipe_model.dart';
import 'package:healthycheck/views/recipe_view.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController textEditController = new TextEditingController();
  String applicationId = "19f5df86";
  String applicationKey = "65752f980196db34fa412b9eb3100a2d";

  List<RecipeModel> recipes = new List<RecipeModel>();

  getRecipes(String query) async {
    String url =
        "https://api.edamam.com/search?q=query&app_id=${applicationId}&app_key=${applicationKey}";

    var response = await http.get(Uri.parse(url));
    //print("this is the response $response");
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["hits"].forEach((element) {
      //print(element.toString());

      RecipeModel recipeModel = new RecipeModel();
      recipeModel = RecipeModel.fromMap(element["recipe"]);
      recipes.add(recipeModel);
    });
    setState(() {
      
    });
    print("${recipes.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff200bb7),
        title: Text("See recipes"),
      ),
      body: Stack(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                // gradient: LinearGradient(colors: [
                //   const Color(0xff213a50),
                //   const Color(0xff071930),
                // ]),
                color: const Color(0xFFE9E9E9),
              )),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 30.0, vertical: Platform.isIOS ? 60 : 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    "Provide an ingridient and all the blogs for recipes with the ingredient will be appear", 
                    style: TextStyle(fontSize: 18, color: Colors.blueGrey),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: textEditController,
                            decoration: InputDecoration(
                              hintText: "Enter ingridient",
                              hintStyle: TextStyle(
                                color: Colors.blueGrey.withOpacity(0.5),
                              ),
                            ),
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.blueGrey),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        InkWell(
                          onTap: () {
                            if (textEditController.text.isNotEmpty) {
                              //print("Just do it");
                              getRecipes(textEditController.text);
                            } else {
                              print("Ahh Fuseke!");
                            }
                          },
                          child: Container(
                            child: Icon(
                              Icons.search,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  Container(
                    child: GridView(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        mainAxisSpacing: 10,
                      ),
                      children: List.generate(recipes.length, (index) {
                        return GridTile(
                          child: RecipieTile(
                            title: recipes[index].label,
                            desc: recipes[index].source,
                            imgUrl: recipes[index].image,
                            url: recipes[index].url,
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RecipieTile extends StatefulWidget {
  final String title, desc, imgUrl, url;

  RecipieTile({this.title, this.desc, this.imgUrl, this.url});

  @override
  _RecipieTileState createState() => _RecipieTileState();
}

class _RecipieTileState extends State<RecipieTile> {
  _launchURL(String url) async {
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            if (kIsWeb) {
              _launchURL(widget.url);
            } else {
              print(widget.url + " this is what we are going to see");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Recipe(
                            postUrl: widget.url,
                          )));
            }
          },
          child: Container(
            margin: EdgeInsets.all(8),
            child: Stack(
              children: <Widget>[
                Image.network(
                  widget.imgUrl,
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: 200,
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.white30, Colors.white],
                          begin: FractionalOffset.centerRight,
                          end: FractionalOffset.centerLeft)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                            //fontFamily: 'Overpass'
                          ),
                        ),
                        Text(
                          widget.desc,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black54,
                            //fontFamily: 'OverpassRegular'
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
