import 'package:cookids/homePage/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cookids/beforeCooking/bodyIngridientsPage.dart';

import '../constants.dart';

class ThankYouPage extends StatefulWidget {
  final String email;

  const ThankYouPage({Key key, this.email}) : super(key: key);
  @override
  State createState() => new thankPage();
}

class thankPage extends State<ThankYouPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: appbarColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
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
        ),
        body: Column(
          children: <Widget>[
            const SizedBox(height: 100),
            Container(
                padding: EdgeInsets.all(4),
                /*    height: 180,
                width: 160,*/
                decoration: BoxDecoration(
                  color: kPrimaryLightColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.asset("images/thankyou.png")),
            const SizedBox(height: 200),

            Row(
              children: <Widget>[
                Expanded(
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.green,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(email: widget.email),
                        ),
                      );
                    },
                    child: Text("Back To Menu",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                )
              ],
            )
          ],
        ));
  }
}
