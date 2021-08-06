import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'checktts.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;
  double windowHeight = 0;
  double windowWidth = 0;
  int _pageState = 0;
  double _loginYoffset = 0;
  double _registerYoffset = 0;
  var _backgroundColor = Colors.lightGreen[50];
  var _rectangleColor = Colors.lightGreen[50];
  final dataControllers = {'first_name': new TextEditingController(),
  'last_name': new TextEditingController(),
    'user_name': new TextEditingController(),
    'email':new TextEditingController(),
  'password':new TextEditingController()};

  // final TextEditingController userNameController = new TextEditingController();
  // final TextEditingController firstNameController = new TextEditingController();
  // final TextEditingController lastNameController = new TextEditingController();
  // final TextEditingController emailController = new TextEditingController();
  // final TextEditingController passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    windowHeight = MediaQuery.of(context).size.height;
    windowWidth = MediaQuery.of(context).size.width;

    switch(_pageState){
      case 0:
        _backgroundColor = Color(0xFFF5F5F5);
        _loginYoffset = windowHeight;
        _registerYoffset = windowHeight;
        break;
      case 1:
        _backgroundColor = Colors.orange[100];
        _rectangleColor = Colors.orange[50];
        _loginYoffset = 180;
        _registerYoffset = windowHeight;
        break;
      case 2:
        _backgroundColor = Colors.yellow[100];
        _rectangleColor = Colors.yellow[50];
        _loginYoffset= windowHeight;
        _registerYoffset = 180;
        break;
      //  just for check- delete ----------------------------------------------
      case 3:
        _backgroundColor = Colors.green[200];
        _rectangleColor = Colors.yellow[50];
        _loginYoffset= windowHeight;
        _registerYoffset = 180;
        break;
      case 4:
        _backgroundColor = Colors.red[200];
        _rectangleColor = Colors.yellow[50];
        _loginYoffset= windowHeight;
        _registerYoffset = 180;
        break;
      case 5:
        _backgroundColor = Colors.green[200];
        _rectangleColor = Colors.orange[50];
        _loginYoffset = 180;
        _registerYoffset = windowHeight;
        break;
      case 6:
        _backgroundColor = Colors.red[200];
        _rectangleColor = Colors.orange[50];
        _loginYoffset = 180;
        _registerYoffset = windowHeight;
        break;
    }

    return Scaffold(
      backgroundColor: _backgroundColor,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              /*Container(
                height: double.infinity,
                width: double.infinity,

              ),*/
              Visibility(
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                visible: (_pageState == 1)? true:false,
                child: Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(top: 60.0,left: 30),
                  child:  Column(
                    children: [
                      Text("LOGIN",
                          style: GoogleFonts.handlee(
                              textStyle: new TextStyle(
                                fontSize: 45.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Roboto",
                                decoration: TextDecoration.none,
                                color: _rectangleColor,
                              ))),
                      Text("Welcome Back",style: TextStyle(color: Colors.white,fontSize: 20)),
                    ],
                  ),
                ),
              ),
              Visibility(
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                visible: (_pageState == 2)? true:false,
                child: Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(top: 80.0,left: 30),
                  child:  Column(
                    children: [
                      Text("REGISTER",
                          style: GoogleFonts.handlee(
                              textStyle: new TextStyle(
                                fontSize: 45.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Roboto",
                                decoration: TextDecoration.none,
                                color: Colors.white))),
                     // Text("Welcome Back",style: TextStyle(color: Colors.white,fontSize: 20)),
                    ],
                  ),
                ),
              ),
             Visibility(
               maintainSize: true,
               maintainAnimation: true,
               maintainState: true,
               visible: (_pageState == 0)? true:false,
               child: Container(
                 alignment: Alignment.topCenter,
                   padding: EdgeInsets.only(top: 70.0),
                    child:  Image.asset("images/lets_cook.png"),
               ),
             ),
              Visibility(
                visible: (_pageState == 0)? true:false,
                child: Positioned(
                  top: 400.0,
                  left: 10,
                  child: Text("LET'S START COOKING!",
                      style: GoogleFonts.handlee(
                          textStyle: new TextStyle(
                            fontSize: 35.0,
                            fontWeight: FontWeight.bold,
                            //fontWeight: FontWeight.w900,
                            fontFamily: "Roboto",
                            inherit: true,
                            decoration: TextDecoration.none,
                            color: Color(0xFFCBAE82),
                          ))),
                ),
              ),
              _buildMoveToLoginBtn(),
              _buildMoveToRegisterBtn(),
               AnimatedContainer(
                width: 0.9*windowWidth,
                curve: Curves.fastLinearToSlowEaseIn,
                duration: Duration(milliseconds: 1000),
                transform: Matrix4.translationValues(20, _loginYoffset, 1),
                decoration: BoxDecoration(
                    color: _rectangleColor,
                    // image: DecorationImage(
                    //   image: AssetImage("images/chef2.png"),
                    //   alignment: Alignment.topCenter
                    // ),

                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                ),
                 child: Column(
                   children: [
                     _buildLoginPage(),
                   ],
                 ),
              ),
              AnimatedContainer(
                width: 0.9*windowWidth,
                curve: Curves.fastLinearToSlowEaseIn,
                duration: Duration(milliseconds: 1000),
                transform: Matrix4.translationValues(20, _registerYoffset, 1),
                decoration: BoxDecoration(
                  color: _rectangleColor,
                  // image: DecorationImage(
                  //   image: AssetImage("images/chef2.png"),
                  //   alignment: Alignment.topCenter
                  // ),

                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Column(
                  children: [
                    _buildRegisterPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // <------- http request ------->
  register_request(String first_name,last_name,user_name,email,password) async{

    print("im in register about to send out request");

/*    final response = await http.get(Uri.parse('http://10.0.2.2:5000/api/Register'));
    print("response status:");
    print(response.statusCode);*/

    var url = Uri.parse("http://10.0.2.2:5000/api/Register");
    var data = jsonEncode({
      'first_name': first_name,
      'last_name': last_name,
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
        setState(() {
          _pageState=3;
        });

    }
    else{
      print("#######no##########");
      print("A network error occurred");
      print(response.body);
      setState(() {
        _pageState=4;
      });
    }
  }
  login_request(String user_name,password) async{

    print("im in login about to send out request");

/*    final response = await http.get(Uri.parse('http://10.0.2.2:5000/api/Register'));
    print("response status:");
    print(response.statusCode);*/

    var url = Uri.parse("http://10.0.2.2:5000/api/Login");
    var data = jsonEncode({
      'user_name': user_name,
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
      setState(() {
        _pageState=5;
      });
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => CheckTtsScreen(mail: user_name,)));
    }
    else{
      print("#######no##########");
      print("A network error occurred");
      print(response.body);
      setState(() {
        _pageState=6;
      });
    }
  }

  Widget _buildUserNameTF(String indicator) {
     return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          //decoration: kBoxDecoration,
          height: 40.0,
          child: TextField(
            keyboardType: TextInputType.name,
            controller: dataControllers[indicator],
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              //border: InputBorder.none,
              //border: ,
              contentPadding: EdgeInsets.only(top: 4.0),
              prefixIcon: Icon(
                Icons.account_box,
                color: Colors.grey[400],
              ),
              hintText: 'Enter your Name',
              hintStyle: TextStyle(color: Colors.grey[400]),
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Text(
        //   'Email',
        // ),
        //SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          //decoration: kBoxDecoration,
          height: 40.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            controller: dataControllers['email'],
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              //border: InputBorder.none,
              //border: ,
              contentPadding: EdgeInsets.only(top: 4.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.grey[400],
              ),
              hintText: 'Enter Email',
              hintStyle: TextStyle(color: Colors.grey[400]),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Forgot Password?',
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 2.0,
        onPressed: () {
          print('Login Button Pressed');
          print(dataControllers['password'].text);
          print(dataControllers['user_name'].text);

          //  <------- send http request  ------->
          if (dataControllers['password'].text != "" && dataControllers['user_name'].text != ""){
            login_request(dataControllers['user_name'].text,dataControllers['password'].text);
          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color:Color.fromRGBO(202, 155, 82, 0.3),
        child: Text(
          'Login',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
  Widget _buildRegisterBtn(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 2.0,
        onPressed: (){
          print('Register Button Pressed');
          //  <------- send http request  ------->
          if (dataControllers['email'].text != "" && dataControllers['password'].text != ""
              && dataControllers['first_name'].text!="" && dataControllers['last_name'].text !=""
              && dataControllers['user_name'].text != ""){
               register_request(dataControllers['first_name'].text,dataControllers['last_name'].text,
                   dataControllers['user_name'].text,dataControllers['email'].text,dataControllers['password'].text);
          }

        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color:Color.fromRGBO(	203, 194, 109, 0.3),
        child: Text(
          'Register',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterPage(){
    return  Container(
      height: windowHeight,
      child:
      SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: 75.0,
          vertical: 50.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           /* Container(
              alignment: Alignment.topCenter,
              child: Image.asset(
                  "images/user-register.png"
              ),
            ),*/
            _buildUserNameTF('first_name'),
            SizedBox(height: 20.0),
            _buildUserNameTF('last_name'),
            SizedBox(height: 20.0),
            _buildUserNameTF('user_name'),
            SizedBox(height: 20.0),
            _buildEmailTF(),
            SizedBox(height: 20.0),
            _buildPasswordTF(),
            SizedBox(height: 20.0),
            //_buildRememberMeCheckbox(),
            _buildRegisterBtn(),
            //_buildSignInWithText(),
            // sign in with google/facebook
            //_buildSocialBtnRow(),
            _buildBackToLoginBtn(),
          ],
        ),
      ),
    );
  }
  Widget _buildLoginPage(){
    return  Container(
      height: windowHeight,
      child:
      SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: 75.0,
          vertical: 50.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           /* Container(
              alignment: Alignment.topCenter,
              child: Image.asset(
                  "images/user.png"
                // height: 250,
                // width: double.infinity,
                // fit: BoxFit.cover,
              ),
            ),*/
            SizedBox(height: 30.0),
            _buildUserNameTF('user_name'),
            SizedBox(height: 30.0),
            _buildPasswordTF(),
            _buildForgotPasswordBtn(),
            _buildRememberMeCheckbox(),
            _buildLoginBtn(),
            //_buildSignInWithText(),
            // sign in with google/facebook
            //_buildSocialBtnRow(),
            _buildSignupBtn(),
          ],
        ),
      ),
    );
  }

  Widget _buildMoveToLoginBtn(){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.only(top:460,left: 40),
            width: 0.9*windowWidth,
            child: RaisedButton(
              elevation: 5.0,
              onPressed: () {
                print('Move To Login Button Pressed');
                setState(() {
                  _pageState = 1;
                });

                // _buildLoginPage();

               /* Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) => LoginScreen()));*/
              },
              padding: EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
                //side: BorderSide(color: Colors.white),
              ),
              color: Color(0xFF9c64a6),
              child: Text(
                'Move To Login',
                style: GoogleFonts.nunito(
                    textStyle: new TextStyle(
                      fontSize: 18.0,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                      //fontWeight: FontWeight.w900,
                      fontFamily: "Roboto",
                      inherit: true,
                      decoration: TextDecoration.none,
                      color: Color(0xFFFFFFFF),
                    )),
              ),
            ),
          ),],
      );

      return  SizedBox(height: 30.0);

  }
  Widget _buildBackToLoginBtn(){
    return GestureDetector(
      onTap: (){
        print("Go back to login from register page was pressed");
        setState(() {
          _pageState = 1;
        });
      },
      child: Container(
        decoration: BoxDecoration(
            color: _rectangleColor,
            border: Border.all(
              color: Color.fromRGBO(	148, 175, 118, 0.3),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.all(15),
        child: Center(
          child: Text("Back To Login",
            style: TextStyle(
              color: Color.fromRGBO(	148, 175, 118, 0.3),
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildMoveToRegisterBtn(){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.only(top:535,left: 40),
            width: 0.9*windowWidth,
            child: RaisedButton(
              elevation: 5.0,
              onPressed: () {
                print('Move To Register Button Pressed');
                setState(() {
                  _pageState = 2;
                });
              },
              padding: EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
                side: BorderSide(color: Color(0xFFFFFFFF)),
              ),
              color: _backgroundColor,
              child: Text(
                'Create New Account',
                style:
                GoogleFonts.nunito(
                    textStyle: new TextStyle(
                      fontSize: 18.0,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                      //fontWeight: FontWeight.w900,
                      fontFamily: "Roboto",
                      inherit: true,
                      decoration: TextDecoration.none,
                      color: Color(0xFF883997),
                    )),

              ),
            ),
          ),],
      );

  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Text(
        //   'Password',
        // ),
        //SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(),
          height: 40.0,
          child: TextField(
            obscureText: true,
            controller: dataControllers['password'],
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              //border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 5.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.grey[400],
              ),
              hintText: 'Enter Password',
              hintStyle: TextStyle(color: Colors.grey[400]),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.grey),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.orange[500],
              activeColor: Colors.grey[350],
              onChanged: (value) {
                setState(() {
                  _rememberMe = value;
                });
              },
            ),
          ),
          Text(
            'Remember me',
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: (){
        print("Create mew account from login page was pressed");
        setState(() {
          _pageState = 2;
        });
      },
      child: Container(

        decoration: BoxDecoration(
          color:_rectangleColor,
          border: Border.all(
            color: Color.fromRGBO(	202, 155, 82, 0.5),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(30)
        ),
        padding: EdgeInsets.all(15),
        child: Center(
          child: Text("Create New Account",
          style: TextStyle(
            color: Color.fromRGBO(	202, 155, 82, 0.5),
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'OpenSans',
        ),
          ),
        ),
      ),
    );
    /*GestureDetector(
      onTap: () => print('Sign Up Button Pressed'),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Create New Account',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            *//*TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),*//*
          ],
        ),
      ),
    );*/
  }
  Widget _buildSocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

}
