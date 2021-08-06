import 'dart:convert';

import 'package:cookids/logIn/bodyLogOrSign.dart';
import 'package:cookids/signUp/signupScreen.dart';
import 'package:flutter/material.dart';
import 'package:cookids/homePage/homepage.dart';
import 'package:http/http.dart' as http;

class Body extends StatelessWidget {
  Body({
    Key key,
  }) : super(key: key);
  int error = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final emailTextEditor = RoundInputField(
      hintText: "Enter Your Email",
      onChanged: (value) {},
    );
    final passTextEditor = RoundedPasswordField(
      hintText: "Enter Your Password",
      onChanged: (value) {},
    );
    return Background(
      child: Column(children: <Widget>[
        const SizedBox(height: 300),
        emailTextEditor,
        passTextEditor,
        SizedBox(height: 100),
        RoundedButton(
          text: "Log Me In!",
          press: () async {
            var send_to_check = await login_request(emailTextEditor.data.text,passTextEditor.userpassword.text,context);
            // pls write wrong email or password here:
            print("error: "+error.toString());
            // pls print to user an error:
            // if error == 0 or 200 or 410 or 500: print to user that something is wrong, pls try later
            // if error == 404: print to user that something is wrong with his info- beacuse not found

          },
          color: Colors.black,
        ),
        AlreadyHaveAnAccountCheck(press: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return SignUpScreen();
              },
            ),
          );
        })
      ]),
    );
  }

  login_request(String email,password,context) async{

    print("im in login about to send out request");

/*    final response = await http.get(Uri.parse('http://10.0.2.2:5000/api/Register'));
    print("response status:");
    print(response.statusCode);*/

    var url = Uri.parse("http://10.0.2.2:5000/api/Login");
    var data = jsonEncode({
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
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return HomePage(email: email);
          },
        ),
      );
      //   Navigator.pushReplacement(context, MaterialPageRoute(
      //       builder: (context) => CheckTtsScreen(mail: user_name,)));
    }
    else{
      error = response.statusCode;
      print("#######no##########");
      //print(response.body);
      // setState(() {
      //   _pageState=6;
      // });
    }
  }
}

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function press;

  const AlreadyHaveAnAccountCheck({
    Key key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Don't have an account? " : "Already have an account? ",
          style: TextStyle(color: Colors.black),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "Sign up!" : "Log in!",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String hintText;
  final userpassword = new TextEditingController();
  RoundedPasswordField({
    Key key,
    this.hintText,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        child: TextField(
      obscureText: true,
      controller: userpassword,
      onChanged: onChanged,
      decoration: InputDecoration(
          hintText: hintText,
          icon: Icon(Icons.lock),
          suffixIcon: Icon(Icons.visibility),
          border: InputBorder.none),
    ));
  }
}

class RoundInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final data = new TextEditingController();

   RoundInputField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
          controller: data,
          onChanged: onChanged,
          decoration: InputDecoration(
              icon: Icon(Icons.person),
              hintText: hintText,
              border: InputBorder.none)),
    );
  }
}

class TextFieldContainer extends StatelessWidget {
  final Widget child;

  const TextFieldContainer({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}

class Background extends StatelessWidget {
  final Widget child;
  Background({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
              top: 100,
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
