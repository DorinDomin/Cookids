import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'loginscreen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:io' as Io;
import 'dart:convert';
class HomeScreen extends StatefulWidget {
  @override
  State createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<String> data = [
    "images/chef2.png",
    "images/recipe-book.png",
    "images/illustrations.png",
    "images/sound.png",
  ];
  List<String> dataText = [
    "Cookids",
    "Recipes",
    "Illustrations",
    "Voice Instructions",
  ];
  List<String> dataTextDesc = [
    "",
    "A VARIETY OF RECIPES",
    "USING THE COMMUNICATION BOARD",
    "LOUD AND CLEAR",
  ];
  List<Color> dataPageColor = [
    Colors.lightGreen[100],
    Colors.teal[50],
    Colors.purple[50],
    Colors.lightGreen[50],
  ];
  List<Color> dataTextColor = [
    null,
    Colors.teal[400],
    Colors.purple[400],
    Colors.lightGreen[400],
  ];
  int _currentPage = 0;
/*  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < data.length; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }*/
  Image imageFromBase64String(String base64String) {
    return Image.memory(base64Decode(base64String));
  }

  Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  String base64String(Uint8List data) {
    return base64Encode(data);
  }

  Widget circleBar(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: isActive ? 13 : 10,
      width: isActive ? 13 : 10,
      decoration: BoxDecoration(
          color: isActive
              ? Color.fromRGBO(102, 102, 102, 0.3)
              : Color.fromRGBO(171, 176, 174, 0.3),
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }
  Widget _buildContinueBtn(){
    if(_currentPage != null && _currentPage== dataText.length-1){
      //binaryImg();
     return Column(
       crossAxisAlignment: CrossAxisAlignment.end,
       children: [
         Container(
         padding: EdgeInsets.only(top:560),
         width: 60.0,
         child: RaisedButton(
           elevation: 5.0,
           onPressed: () {
             print('Continue Button Pressed');
             Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => LoginScreen()));
           },
           padding: EdgeInsets.all(15.0),
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(30.0),
             side: BorderSide(color: Colors.lightGreen[100]),
           ),
           color: dataPageColor[_currentPage],

           child:Icon(
             Icons.arrow_forward,
             color: Colors.black38,
             size: 32.0,
           ),
           /*Text(
             'Continue',
             style: TextStyle(
               color: Color(0xFF757575),
               letterSpacing: 1.5,
               fontSize: 18.0,
               fontWeight: FontWeight.bold,
               fontFamily: 'OpenSans',

             ),
           ),*/
         ),
       ),],
     );
    }
  else{
    return  SizedBox(height: 30.0);
    }
  }
  @override
  Widget build(BuildContext context) {
    // move to login page after 4 seconds
    /* Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => LoginScreen()
      )
      );
      // Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.bottomToTop, child: LoginScreen(),ctx: context));

    });*/
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          child: Container(
            key: ValueKey<String>(data[_currentPage]),
            decoration: BoxDecoration(
              color: dataPageColor[_currentPage],
              //(_currentPage != null&&_currentPage==0)? Colors.grey[100]: Colors.lightGreen[50],
              //isActive ? Color.fromRGBO(134, 235, 189, 0.3) : Color.fromRGBO(171, 176, 174, 0.3),
              //color: Colors.lightGreen[100],
            ),
          ),
        ),
        FractionallySizedBox(
          heightFactor: 0.55,
          child: PageView.builder(
            itemCount: data.length,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (BuildContext context, int index) {
              return FractionallySizedBox(
                widthFactor: 0.8,
                child: Container(
                  margin: const EdgeInsets.all(16),
                  child: Container(
                    alignment: Alignment.center,
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(data[index]),
                      // image: AssetImage(imageFromBase64String
                      // fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        //_buildPageIndicator(),
        // title
        Positioned(
          top: 420,
          child: (_currentPage != null && _currentPage == 0)
              ? Text('COOKIDS',
                  style: GoogleFonts.handlee(
                      textStyle: new TextStyle(
                    fontSize: 50.0,
                    //fontWeight: FontWeight.w900,
                    fontFamily: "Roboto",
                    inherit: true,
                    decoration: TextDecoration.none,
                    color: Colors.lightGreen[200],
                    shadows: [
                      Shadow(
                          // bottomLeft
                          offset: Offset(-1.5, -1.5),
                          color: Colors.black),
                      Shadow(
                          // bottomRight
                          offset: Offset(1.5, -1.5),
                          color: Colors.black),
                      Shadow(
                          // topRight
                          offset: Offset(1.5, 1.5),
                          color: Colors.black),
                      Shadow(
                          // topLeft
                          offset: Offset(-1.5, 1.5),
                          color: Colors.black),
                    ],
                  )))
              : Text(dataText[_currentPage],
                  style: GoogleFonts.originalSurfer(
                    textStyle: TextStyle(
                      fontSize: 40.0,
                      decoration: TextDecoration.none,
                      //fontWeight: FontWeight.bold,
                      color: dataTextColor[_currentPage],
                    ),
                  )),
          // description
        ),
        Positioned(
          top: 480,
          child: Text(dataTextDesc[_currentPage],
              style: GoogleFonts.openSansCondensed(
                textStyle: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 22.0,
                  //fontWeight: FontWeight.bold,
                  color: Colors.grey[400],
                ),
              )),
        ),
        /*if(_currentPage == data.length-1){
          Container(

            padding: EdgeInsets.symmetric(vertical: 25.0),
            width: double.infinity,
            child: RaisedButton(
              elevation: 5.0,
              onPressed: () => print('Continue Button Pressed'),
              padding: EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
                side: BorderSide(color: dataTextColor[_currentPage]),
              ),
              color: dataPageColor[_currentPage],
              child: Text(
                'Continue',
                style: TextStyle(
                  color: Color(0xFF757575),
                  letterSpacing: 1.5,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
          ),
        },*/
        _buildContinueBtn(),
        Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(bottom: 35),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              for (int i = 0; i < data.length; i++)
                if (i == _currentPage) ...[circleBar(true)] else
                  circleBar(false),
            ],
          ),
        ),
      ],
    );
  }
}
/*class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // move to login page after 4 seconds
    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => LoginScreen()
      )
      );
      // Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.bottomToTop, child: LoginScreen(),ctx: context));

    });
    return new Scaffold(
      // page style
      backgroundColor: Colors.lightGreen[100],
      body: Center(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget> [
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                    "images/chef2.png"
                  // height: 250,
                  // width: double.infinity,
                  // fit: BoxFit.cover,
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                    'COOKIDS',
                    style: GoogleFonts.handlee(
                        textStyle:
                        new TextStyle(fontSize:50.0,
                          // fontWeight: FontWeight.w300,
                          fontFamily: "Roboto",
                          inherit: true,
                          color: Colors.lightGreen[200],
                          shadows: [
                            Shadow( // bottomLeft
                                offset: Offset(-1.5, -1.5),
                                color: Colors.black
                            ),
                            Shadow( // bottomRight
                                offset: Offset(1.5, -1.5),
                                color: Colors.black
                            ),
                            Shadow( // topRight
                                offset: Offset(1.5, 1.5),
                                color: Colors.black
                            ),
                            Shadow( // topLeft
                                offset: Offset(-1.5, 1.5),
                                color: Colors.black
                            ),
                          ],
                        )
                    )
                ),
              ),

            ],

          )

      ),
    );
  }

}*/

