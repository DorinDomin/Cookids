
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cookids/firstScreen/bodyFirstscreen.dart';

class FirstScreen extends StatefulWidget {
  @override
  State createState() => new firstScreen();
}

class firstScreen extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(

     body: BodyLogo(),
   );
  }
}



