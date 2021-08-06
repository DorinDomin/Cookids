import 'package:cookids/firstScreen/profilePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cookids/beforeCooking/bodyIngridientsPage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants.dart';


class IngridientPage extends StatefulWidget {
  final String recipeId;
  final String email;
  final List<Map<String,dynamic>> list;
  // final List<Map<String,dynamic>> recipelist;
  var recipeList;
  IngridientPage({Key key, @required this.recipeId,@required this.email,@required this.list,@required this.recipeList}):super(key: key);
  // IngridientPage({Key key, @required this.recipeId,@required this.list,@required this.recipelist}):super(key: key);
  @override
  State createState() => new ingriPage();
}

class ingriPage extends State<IngridientPage> {
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
    ),body: BodyIngridientPage(recipeId: widget.recipeId,email: widget.email,list: widget.list,recipeList: widget.recipeList),
    );
  }

}


