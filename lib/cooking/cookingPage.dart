import 'dart:async';
import 'dart:convert';

import 'package:cookids/firstScreen/profilePage.dart';
// import 'package:cookids/object_detection_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:cookids/beforeCooking/bodyCookingPage.dart';
// import 'package:camera/camera.dart';
import 'package:cookids/afterCooking/reviewPage.dart';
import 'package:cookids/CameraDart.dart';
import '../constants.dart';
import 'package:cookids/main.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// import 'package:hooks_riverpod/hooks_riverpod.dart';

class CookingPage extends StatefulWidget {
  final List<Map<String,dynamic>> list;
  final String recipeId;
  final String email;

  CookingPage({required this.list,required this.recipeId,required this.email}):super();
  @override
  cookiPage createState() => cookiPage();
}

class cookiPage extends State<CookingPage> {
  int counter = 0;
  final FlutterTts flutterTts = FlutterTts();
  String _newVoiceText = "";
  String engine = "";
  String language = "";
  int _hear_counter = 0;
  bool timer_flg = false;
  late Timer _timer;
  int seconds = 0;
  int minutes = 0;
  int hours = 0;

/*  bool isWorking = false;
  String result = "";
  CameraController cameraController;
  CameraImage imgCamera;

  initCamera() {
    cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }

      setState(() {
        cameraController.startImageStream((imageFromStream) => {
              if (!isWorking)
                {
                  isWorking = true,
                  imgCamera = imageFromStream,
                }
            });
      });
    });
  }*/
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
    var microImg = Image.asset(
      "images/voiceToText.png",
      scale: 1,
    );
    print("timer on!");
    timer_flg = true;
    startTimer();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: appbarColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: (){
              if (_timer!=null && _timer.isActive){
                _timer.cancel();
              }

              Navigator.pop(context);
            }

          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.person,
                color: Colors.black,
              ),
              iconSize: 22,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ProfilePage(email: widget.email);
                    },
                  ),
                );
              },
              color: Colors.black,
            ),
            SizedBox(
              width: defaultPadding / 8,
            ),
            IconButton(
              icon: Image.asset("images/logo.png"),
              iconSize: 18.0,
              onPressed: () {},
              color: Colors.black,
            ),
          ],
        ),
        body: Column(
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
                                    .headline4!
                                    .copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                            const SizedBox(height: 15),
                            // startTimer(),
                            Row(
                              children: <Widget>[
                                new Image.memory(
                                  base64Decode((img).toString()),
                                  scale: 1.7,
                                ),
                                // Image.asset("images/banana.jpg", scale: 1.9),
                                Expanded(
                                    // ignore: deprecated_member_use
                                    child: FlatButton(
                                  onPressed: () {
                                    _hear_counter++;
                                    // if (_hear_counter == 1 && !timer_flg){
                                    //   print("timer on!");
                                    //   timer_flg = true;
                                    //   startTimer();
                                    // }
                                    print("press: "+ _hear_counter.toString() + " times");
                                    // print("time: "+ hours.toString() +":"+ minutes.toString()+ ":"+ seconds.toString());
                                    _newVoiceText = desc;
                                    _speak();
                                  },
                                  padding: EdgeInsets.all(0.2),
                                  child: Image.asset(
                                    "images/voiceToText.png",
                                    scale: 1,
                                  ),
                                ))
                              ],
                            ),
                           Stack(
                             children: [
                               Center(
                                 // ignore: deprecated_member_use
                                 child: FlatButton(
                                   //onPressed: () {hom();},
                                   onPressed: () {
                                     Home();
                                   },
                                   child: Container(
                                     height: 280,
                                     width: 360,
                                     child: Icon(Icons.photo_camera_front,
                                         color: Colors.blueAccent,
                                         size: 40),
                                   ),
                                 ),
                               )
                             ],
                           ),
                            //const SizedBox(height: 280),

                            // ignore: deprecated_member_use
                            Row(
                              children: <Widget>[
                                Expanded(
                                  // ignore: deprecated_member_use
                                  child: FlatButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    color: Colors.green,
                                    onPressed: () async{
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
                                        });
                                      } else {
                                        if (_timer!=null && _timer.isActive){
                                          _timer.cancel();
                                          timer_flg = true;
                                        }

                                        print("it took u:");
                                        print("time: "+ hours.toString() +":"+ minutes.toString()+ ":"+ seconds.toString());
                                        send_recipe_update_request(context);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ReviewPage(email: widget.email),
                                          ),
                                        );
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
  startTimer() async{
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer)
            {
              // print("checks cases in timer*********");
              minutes += 1;
        },
    );
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
    language = "";
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

  send_recipe_update_request(context) async{

    print("im in send_recipe_update_request about to send out request");

    var url = Uri.parse("http://10.0.2.2:5000/api/UpdateRecipeData");
    var data = jsonEncode({
      'email': "shira@gmail.com",
      'recipe_id': widget.recipeId,
      'time': minutes,
      'hear_clicking':_hear_counter,
    });
    var response = await http.post(url,
        body: data);
    print("response status:");
    print(response.statusCode);
    print("\n");
    // if (response.statusCode == 200){
    //   print("~~~~~yes~~~~~~~~~");
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) {
    //         return HomePage();
    //       },
    //     ),
    //   );
    //
    // }
    // else{
    //   error = response.statusCode;
    //   print("#######no##########");
    // }
  }
}


/*
class cookiPage extends State<CookingPage> {


  bool isWorking= false;
  String result="";
  CameraController cameraController;
  CameraImage imgCamera;

  initCamera()
  {
    cameraController= CameraController(cameras[0], ResolutionPreset.medium);
    cameraController.initialize().then((value)
    {
      if(!mounted)
      {
        return;
      }

      setState(() {
        cameraController.startImageStream((imageFromStream) =>
        {
          if(!isWorking)
            {
              isWorking = true,
              imgCamera = imageFromStream,
            }
        });
      });
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      backgroundColor: appbarColor,
      elevation: 0,
      leading: IconButton(
        icon:Icon(Icons.arrow_back, color: Colors.black,), onPressed: () => Navigator.pop(context),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.person,
            color: Colors.black,
          ),
          iconSize: 22,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ProfilePage();
                },
              ),
            );
          },
          color: Colors.black,
        ),
        SizedBox(
          width: defaultPadding / 8,
        ),
        IconButton(
          icon: Image.asset("images/logo.png"),
          iconSize: 18.0,
          onPressed: () {},
          color: Colors.black,
        ),
      ],
    ),body: BodyCookingPage(),
    );
  }
}


*/
