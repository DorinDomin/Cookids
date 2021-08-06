import 'dart:convert';

import 'package:cookids/afterCooking/reviewPage.dart';
import 'package:cookids/cooking/cookingPage.dart';
import 'package:cookids/homePage/bodyLevelPage.dart';
import 'package:cookids/logIn/logOrSign.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cookids/constants.dart';
import 'package:cookids/logIn/loginScreen.dart';
import 'package:flutter_tts/flutter_tts.dart';

class BodyIngridientPage extends StatefulWidget {
  final String recipeId;
  final String email;
  final List<Map<String, dynamic>> list;
  var recipeList;

  BodyIngridientPage(
      {Key key,
      @required this.recipeId,
      @required this.email,
      @required this.list,
      @required this.recipeList})
      : super(key: key);

  @override
  _BodyIngridientPageState createState() => _BodyIngridientPageState();
}
//final pruduct pruduct;

class _BodyIngridientPageState extends State<BodyIngridientPage> {
  int counter = 0;
  final FlutterTts flutterTts = FlutterTts();
  String _newVoiceText;
  String engine;
  String language;
  List<Map<String, dynamic>> recipe = [];
  var voiceImg = Image.asset(
    "images/voiceToText.png",
    scale: 1,
  );
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int len = widget.list.length - 1;
    var img;
    if (widget.list[counter]["image"].toString() == "[]") {
      // print("its empty******************************");
      img = "";
    } else {
      img = (widget.list[counter]["image"])[0];
    }
    String desc = widget.list[counter]["name"];

    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        SizedBox(
          height: size.height,
          child: Stack(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(
                      top: size.height * 0.48, left: size.width * 0.05),
                  height: 250,
                  width: 370,
                  decoration: BoxDecoration(
                    color: appbarColor,
                    borderRadius: BorderRadius.circular(16),
                  )),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 10),
                        Text(desc,
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                        const SizedBox(height: 15),
                        Row(
                          children: <Widget>[
                            new Image.memory(
                              base64Decode((img).toString()),
                              scale: 1.7,
                            ),
                            // Image.asset("images/banana.jpg", scale: 1.4),
                            Expanded(
                                // ignore: deprecated_member_use
                                child: FlatButton(
                              onPressed: () {
                                _newVoiceText = desc;
                                _speak();
                              },
                              padding: EdgeInsets.all(0.2),
                              child: voiceImg,
                            ))
                          ],
                        ),
                        const SizedBox(height: 280),
                        // ignore: deprecated_member_use
                        Row(
                          children: <Widget>[
                            Expanded(
                              // ignore: deprecated_member_use
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                color: Colors.green,
                                onPressed: () async {
                                  if (counter < len) {
                                    counter++;
                                    setState(() {
                                      if (widget.list[counter]["image"]
                                              .toString() ==
                                          "[]") {
                                        // print("its empty******************************");
                                        img = "";
                                      } else {
                                        img =
                                            (widget.list[counter]["image"])[0];
                                      }
                                      desc = widget.list[counter]["name"];
                                      voiceImg = Image.asset(
                                        "images/voiceToText.png",
                                        scale: 1,
                                      );
                                    });
                                  } else {
                                    var result =
                                        await get_recipes_steps(context);
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => CookingPage(),
                                    //     // builder: (context) => ReviewPage(),
                                    //   ),
                                    // );
                                  }
                                },
                                child: Text("Next",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            )
                          ],
                        ),
                      ])),
            ],
          ),
        )

        /*
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return BodyLevelPage();
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 100),

            Container(
                padding: EdgeInsets.all(4),
                */ /*    height: 180,
                width: 160,*/ /*
                decoration: BoxDecoration(
                  color: kPrimaryLightColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.asset("images/open.png")),
            const SizedBox(height: 50),
            ClipRRect(
                borderRadius: BorderRadius.circular(20),
                // ignore: deprecated_member_use
                child: FlatButton(
                  color: Colors.black,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) { },
                      ),
                    );
                  },
                  child: Text("lets pick up the ingredients!",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryLightColor)),
                )),*/
      ],
    ));
  }

  Future<dynamic> _getLanguages() => flutterTts.getLanguages;

  Future<dynamic> _getEngines() => flutterTts.getEngines;

  Future _getDefaultEngine() async {
    var def_engine = await flutterTts.getDefaultEngine;
    if (engine != null) {
      print(engine);
    }
  }

  _speak() async {
    if (engine == null) {
      _getDefaultEngine();
    }
    await flutterTts.setVolume(1.0);
    // await flutterTts.setSpeechRate(0.5);
    // await flutterTts.setPitch(1.0);
    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
      });
    });
    if (_newVoiceText != null) {
      if (_newVoiceText.isNotEmpty) {
        // await flutterTts.awaitSpeakCompletion(true);
        // await flutterTts.setLanguage(language)
        await flutterTts.speak(_newVoiceText);
      }
    }
  }

  List<DropdownMenuItem<String>> getEnginesDropDownMenuItems(dynamic engines) {
    var items = <DropdownMenuItem<String>>[];
    for (dynamic type in engines) {
      items.add(
          DropdownMenuItem(value: type as String, child: Text(type as String)));
    }
    return items;
  }

  void changedEnginesDropDownItem(String selectedEngine) {
    flutterTts.setEngine(selectedEngine);
    language = null;
    setState(() {
      engine = selectedEngine;
    });
  }

  List<DropdownMenuItem<String>> getLanguageDropDownMenuItems(
      dynamic languages) {
    var items = <DropdownMenuItem<String>>[];
    for (dynamic type in languages) {
      items.add(
          DropdownMenuItem(value: type as String, child: Text(type as String)));
    }
    return items;
  }

  void _onChange(String text) {
    setState(() {
      _newVoiceText = text;
    });
  }

  get_recipes_steps(context) async {
    print("im in get_recipes_steps");
    // response.stream.transform(utf8.decoder).listen((value) {
    //   print(value);
    // });
    if (widget.recipeList == "") {
      print("got an empty recipe desc");
      await _showMyDialog(context);
    } else {
      final Map<String, dynamic> data_converted =
          Map<String, dynamic>.from(widget.recipeList);
      recipe.clear();
      // recipeList.clear();
      for (String key in data_converted.keys) {
        // print(key);
        String name = data_converted[key]["line"];
        var image = data_converted[key]["images"];
        recipe.add({"id": key, "name": name, "image": image});
      }
      print(recipe);
      print(recipe.runtimeType);
      print(recipe.length);
      print("finished");

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CookingPage(list: recipe,recipeId: widget.recipeId,email: widget.email),
          // builder: (context) => ReviewPage(),
        ),
      );
    }
  }

  Future<void> _showMyDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Something is wrong..'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                // Text(''),
                Text('please try again.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
