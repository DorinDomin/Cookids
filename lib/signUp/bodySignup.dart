import 'dart:convert';

import 'package:cookids/logIn/bodyLogOrSign.dart';
import 'package:cookids/logIn/bodyLogin.dart';
import 'package:cookids/logIn/loginScreen.dart';
import 'package:cookids/signUp/questionsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cookids/homePage/homepage.dart';
import 'package:http/http.dart' as http;

class BodySignUp extends StatelessWidget {
  int error = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
  final usernameTextE = RoundInputField(
    hintText: "Username",
    onChanged: (value) {},
  );
  final emailTextE = RoundInputField(
    hintText: "Email",
    onChanged: (value) {},
  );
  final passwordTextE = RoundedPasswordField(
    hintText: "Password",
    onChanged: (value) {},
  );
  final confirmPassTextE = RoundedPasswordField(
    hintText: "Confirm Password",
    onChanged: (value) {},
  );
    return Background(
        child: Column(
      children: <Widget>[
        const SizedBox(height: 250),
        usernameTextE,
        emailTextE,
        passwordTextE,
        confirmPassTextE,
        SizedBox(height: 17),
        RoundedButton(
          text: "Sign Up!",
          color: Colors.black54,
          press: () async{
            if (passwordTextE.userpassword.text != confirmPassTextE.userpassword.text){
              // pls print to user that the password is different from confirm password
            }
            var send_to_check = await register_request(usernameTextE.data.text,emailTextE.data.text,passwordTextE.userpassword.text,context);
            print("error: "+error.toString());
            // pls print to user an error:
            // if error == 0 or 200 or 410 or 500: print to user that something is wrong, pls try later
            // if error == 400: print to user that something is wrong with his info
            // if error == 405: print to user that user name not valid
            // if error == 406: print to user that password not valid
            // if error == 407: print to user that email not valid

          },
        ),
        SizedBox(height: size.height * 0.02),
        AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LogInScreen();
                  },
                ),
              );
            }),
        //OrDivider(),
      ],
    ));
  }

  register_request(String user_name,email,password,context) async{

    print("im in register about to send out request");
    if (user_name == "" || email == "" || password == ""){
      error = 400;
      return;
    }
/*    final response = await http.get(Uri.parse('http://10.0.2.2:5000/api/Register'));
    print("response status:");
    print(response.statusCode);*/

    var url = Uri.parse("http://10.0.2.2:5000/api/Register");
    var data = jsonEncode({
      // 'first_name': first_name,
      // 'last_name': last_name,
      'user_name': user_name,
      'email': email,
      'password':  password
    });
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await http.post(url,
        /*headers: {
      'Content-Type': 'application/json',
        },*/
        body: data);
    print("response status:");
    print(response.statusCode);
    print("\n");
    if (response.statusCode == 200){
      print("~~~~~yes~~~~~~~~~");
      error = 200;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return QuestionScreen(email: email);
          },
        ),
      );

    }
    else{
      error = response.statusCode;
      print("#######no##########");
      print("Something is wrong..");
      //print(response.body);
    }
  }

}

class OrDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        width: size.width * 0.8,
        child: Row(
          children: <Widget>[
            buildDivider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text("OR",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600)),
            ),
            buildDivider(),
          ],
        ));
  }
}

class buildDivider extends StatelessWidget {
  const buildDivider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Divider(
      color: Colors.black,
      height: 1.5,
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
              top: 70,
              child: Image.asset(
                "images/chefLogin.png",
                width: size.width * 0.3,
              )),
          child,
        ],
      ),
    );
  }
}
