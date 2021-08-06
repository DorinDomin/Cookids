
import 'package:cookids/firstScreen/profilePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cookids/constants.dart';

import 'package:cookids/homePage/bodyRecommend.dart';

class RecPage extends StatefulWidget {
  final String name;
  var image;
  final String recipeId;
  final String email;
  RecPage({Key key, @required this.name,@required this.image,@required this.recipeId,@required this.email}):super(key: key);

  @override
  State createState() => new recPage();
}

class recPage extends State<RecPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
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
      ),
      body: BodyReccomend(name: widget.name,image: widget.image,recipeId: widget.recipeId,email: widget.email),
      // body: BodyReccomend(name: widget.name,image: widget.image),
    );
  }

}



