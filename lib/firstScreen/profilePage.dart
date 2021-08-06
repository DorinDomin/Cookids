import 'package:cookids/homePage/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cookids/beforeCooking/bodyIngridientsPage.dart';
import 'package:cookids/logIn/bodyLogin.dart';

import '../constants.dart';

class ProfilePage extends StatefulWidget {
  final String email;

  const ProfilePage({Key key, this.email}) : super(key: key);

  @override
  State createState() => new profilePage();
}

class profilePage extends State<ProfilePage> {
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
        ),
        body: Column(
          children: <Widget>[
            const SizedBox(height: 60),
            Container(
                padding: EdgeInsets.all(4),
                /*    height: 180,
                width: 160,*/
                decoration: BoxDecoration(
                  color: kPrimaryLightColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.asset("images/chefLogin.png")),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text("Change User Name:",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600)),
            ),
            RoundInputField(
              hintText: "Username",
              onChanged: (value) {},
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text("Change Email:",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600)),
            ),
            RoundInputField(
              hintText: "Email",
              onChanged: (value) {},
            ),
            const SizedBox(height: 50),
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
                    child: Text("Save Changes",
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
