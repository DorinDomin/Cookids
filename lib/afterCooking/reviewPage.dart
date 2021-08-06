import 'package:cookids/afterCooking/thankYouPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cookids/beforeCooking/bodyIngridientsPage.dart';

import '../constants.dart';

class ReviewPage extends StatefulWidget {
  final String email;
  const ReviewPage({Key key, this.email}) : super(key: key);

  @override
  State createState() => new revPage();
}

class revPage extends State<ReviewPage> {
  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;

    List<String> categories = [
      "images/logo.png",
      "images/logo.png",
      "images/logo.png"
    ];
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
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Text(
              "We Would Love To Recive Your Feedback!",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
          ),
          Container(
              padding: EdgeInsets.all(4),
              /*    height: 180,
                width: 160,*/
              decoration: BoxDecoration(
                color: kPrimaryLightColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.asset(
                "images/feedback.png",
                scale: 3,
              )),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Text(
              "How Much You Enjoyed This Recipe?",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
          ),

          Expanded(
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: GridView.count(
                    crossAxisCount: 5,
                    childAspectRatio: .60,
                    crossAxisSpacing: 0,
                    //mainAxisSpacing: 20,

                    children: <Widget>[
                      // ignore: deprecated_member_use
                      IconButton(
                        icon: Image.asset("images/1.png"),
                        iconSize: 30,
                        onPressed: () {
                          setState(() {});
                        },
                      ),
                      IconButton(
                        icon: Image.asset("images/2.png"),
                        iconSize: 30,
                        onPressed: () {
                          setState(() {});
                        },
                      ),
                      IconButton(
                        icon: Image.asset("images/3.png"),
                        iconSize: 30,
                        onPressed: () {
                          setState(() {});
                        },
                      ),
                      IconButton(
                        icon: Image.asset("images/4.png"),
                        iconSize: 30,
                        onPressed: () {
                          setState(() {});
                        },
                      ),
                      IconButton(
                        icon: Image.asset("images/5.png"),
                        iconSize: 30,
                        onPressed: () {
                          setState(() {});
                        },
                      ),
                    ]),
              ),

          ),
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
                        builder: (context) => ThankYouPage(email: widget.email),
                      ),
                    );
                  },
                  child: Text("Submit",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
