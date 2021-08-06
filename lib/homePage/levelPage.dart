
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cookids/constants.dart';

import 'package:cookids/homePage/bodyLevelPage.dart';

class LevelPage extends StatefulWidget {
  final List<Map<String,dynamic>> list;
  final String selected;
  final String email;
  LevelPage({Key key, @required this.list,@required this.selected,@required this.email}):super(key: key);

  @override
  State createState() => new levelPage();
}

class levelPage extends State<LevelPage> {
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
          onPressed: () {},
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
    body: BodyLevelPage(list: widget.list,selected: widget.selected,email: widget.email),
    );

  }
}

/*

AppBar buildAppBar() {
  return AppBar(
    backgroundColor: kPrimaryLightColor,
    elevation: 0,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: ()=>Navigator.pop(context),
      color: Colors.black,
    ),
    actions: <Widget>[
      IconButton(
        icon: Image.asset("images/logo.png"),
        iconSize: 18.0,
        onPressed: () {},
        color: Colors.black,
      ),
      SizedBox(
        width: defaultPadding / 2,
      )
    ],
  );
}

*/


