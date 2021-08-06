import 'package:cookids/logIn/loginScreen.dart';
import 'package:cookids/logIn/logOrSign.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cookids/constants.dart';


class BodyLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
        child: Column(
      children: <Widget>[
        const SizedBox(height: 500),
        Container(
          width: size.width * 0.8,
          /*    decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.all(Radius.circular(29))),*/
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              // ignore: deprecated_member_use
              child: FlatButton(

                color: Colors.black,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LogOrSign();
                      },
                    ),
                  );
                },
                child: Text("Let's Start Cooking!",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryLightColor)),
              )),
        )
      ],
    ));
  }
}

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
              top: 300,
              left: 3,
              child: Image.asset(
                "images/kids.png",
                width: size.width,
                height: size.height,
              )),
          Positioned(
              bottom: 100,
              left: 6,
              child: Image.asset(
                "images/logo.png",
                width: size.width,
                height: size.height,
              )),
          // Positioned.directional(
          //   child: TextButton(onPressed: (){}, child: Text("Let's Start!")),
          // ),
          child,
        ],
      ),
    );
  }
}
