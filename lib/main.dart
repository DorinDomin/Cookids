// env\Scripts\activate
// run.py
// python -m pip install numpy

import 'package:cookids/beforeCooking/ingridientsPage.dart';
import 'package:cookids/firstScreen/profilePage.dart';
import 'package:cookids/homePage/homepage.dart';
import 'package:cookids/homePage/levelPage.dart';
import 'package:cookids/homePage/recommendpage.dart';
import 'package:cookids/signUp/bodyQuestions.dart';
import 'package:cookids/signUp/questionsScreen.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_login/flutter_login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'afterCooking/reviewPage.dart';
import 'afterCooking/thankYouPage.dart';
import 'appscreens/homescreen.dart';
import 'package:cookids/constants.dart';
import 'package:cookids/httpRequests.dart';

import 'appscreens/loginscreen.dart';
import 'firstScreen/firstscreen.dart';

import 'package:flutter/services.dart';
import 'package:mongo_dart/mongo_dart.dart';

import 'logIn/loginScreen.dart';

void main() {
  load_recipes();
  // check();
  runApp(MultiProvider(
      providers:[ ChangeNotifierProvider<SingleNotifier>(create: (_) => SingleNotifier(),)
  ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "logo",
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kPrimaryLightColor,
      ),
      //load home page
      home: FirstScreen(),
    );
  }
}

