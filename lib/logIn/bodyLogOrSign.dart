import 'package:cookids/signUp/signupScreen.dart';

import '../constants.dart';
import 'package:cookids/logIn/loginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BodyLogOrSign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
        child: Column(
      children: <Widget>[
        const SizedBox(height: 500),
        RoundedButton(
          text: "Log In",
          press: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return LogInScreen();
                },
              ),
            );
          },

        ),
        RoundedButton(
          text: "Sign Up",
          color: Colors.black54,
          press: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return SignUpScreen();
                },
              ),
            );
          },

        )
      ],
    ));
  }
}

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  const RoundedButton({
    Key key, this.text, this.press, this.color=Colors.black, this.textColor=kPrimaryLightColor,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
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
            color: color,
            onPressed: press,
            child: Text(text,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                   color: textColor)),
          )),
    );
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
              bottom: 100,
              left: 6,
              child: Image.asset(
                "images/chefLogin.png",
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
