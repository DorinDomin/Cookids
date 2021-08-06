import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class CheckTtsScreen extends StatefulWidget {
  final String mail;

  const CheckTtsScreen({Key key, this.mail}) : super(key: key);

  @override
  State createState() => new CheckTtsScreenState(mail);
}

class CheckTtsScreenState extends State<CheckTtsScreen> {
  final String user_email;
  final FlutterTts flutterTts = FlutterTts();
  String _newVoiceText;
  String engine;
  String language;
  int _hear_counter = 0;
  Timer _timer;
  int seconds = 0;
  int minutes = 0;
  int hours = 0;

  CheckTtsScreenState(this.user_email);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: RaisedButton(
        child: Text(user_email),
        onPressed: () {
          _hear_counter++;
          if (_hear_counter == 1){
            startTimer();
            check_json_request();
          }
          print("press: "+ _hear_counter.toString() + " times");
          print("time: "+ hours.toString() +":"+ minutes.toString()+ ":"+ seconds.toString());
          _newVoiceText = "hello";
          _speak();
          if (_hear_counter == 2){
            _timer.cancel();
          }
        } ,
      ),
    );
  }
  check_json_request() async{

    print("im in check_json_request about to send out get request");

/*    final response = await http.get(Uri.parse('http://10.0.2.2:5000/api/Register'));
    print("response status:");
    print(response.statusCode);*/

    var url = Uri.parse("http://10.0.2.2:5000/api/CheckSentDelete");
    var data = null;
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await http.get(url);
    print("response status:");
    print(response.statusCode);
    print("\n");
    if (response.statusCode == 200) {
      print("~~~~~yes~~~~~~~~~");
      data = json.decode(response.body);
      print(data['messages']);
      for (var item in data['messages']) {
        print(item);
      }
    }
    else{
      print("#######no##########");
      print("A network error occurred");
      print(response.body);
    }
  }
  void startTimer(){
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          if (seconds < 0) {
            timer.cancel();
          } else {
            seconds = seconds + 1;
            if (seconds > 59) {
              minutes += 1;
              seconds = 0;
              if (minutes > 59) {
                hours += 1;
                minutes = 0;
              }
            }
          }
        },
      ),
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

/*  _getDefaultEngine() async {
    var def_engine = await flutterTts.getDefaultEngine;
    if (engine != null) {
      print("engine: " + def_engine);
      flutterTts.setEngine(def_engine);
      setState(() {
        engine = def_engine;
      });
      var items = flutterTts.getLanguages;
      print(items);
    }
  }*/
  _speak() async {
    if (engine == null) {
      _getDefaultEngine();
    }
    // await flutterTts.setVolume(1.0);
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
      items.add(DropdownMenuItem(
          value: type as String, child: Text(type as String)));
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
      items.add(DropdownMenuItem(
          value: type as String, child: Text(type as String)));
    }
    return items;
  }

  void _onChange(String text) {
    setState(() {
      _newVoiceText = text;
    });
  }
}

