import 'dart:convert';

import 'package:cookids/beforeCooking/openingPage.dart';
import 'package:cookids/homePage/levelPage.dart';
import 'package:cookids/logIn/logOrSign.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cookids/constants.dart';
import 'package:cookids/homePage/recommendpage.dart';
import 'package:cookids/homePage/homepage.dart';
import 'package:cookids/login/bodyLogOrSign.dart';
import 'package:cookids/signUp/questionsScreen.dart';
import 'package:http/http.dart' as http;

class BodyReccomend extends StatelessWidget {
  final String name;
  var image;
  final String recipeId;
  final String email;

  BodyReccomend({Key key, @required this.name,@required this.image,@required this.recipeId,@required this.email}):super(key: key);
  int error = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Column(
      children: <Widget>[
        Container(
          height: size.height * .2,
          decoration: BoxDecoration(
              color: Color(0xFFE8F5E9),
              image: DecorationImage(
                  scale: 3,
                  alignment: Alignment.center,
                  colorFilter: new ColorFilter.mode(
                      Color(0xFFE8F5E9).withOpacity(0.6), BlendMode.dstATop),
                  image: AssetImage("images/kidCook.png"))),
        ),
        SizedBox(height: 20),
        Text(
          'We though you might like this recipe-',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 30),
        ),
        SizedBox(height: 20),

        Text(
          name,
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 30),

        // convert_binary_to_image(),
        Container(
          height: size.height * .2,
          // child: new Image.memory(utf8.encode(image.toString())),
          child: new Image.memory(base64Decode(image.toString())),
          // decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(14),
          //     color: Color(0xFFE8F5E9),
          //
          //     image: DecorationImage(
          //         scale: 2,
          //         alignment: Alignment.center,
          //         /*colorFilter: new ColorFilter.mode(
          //                     Color(0xFFE8F5E9).withOpacity(0.6), BlendMode.dstATop)*/
          //         image: AssetImage("images/pizza.jpg"))
          //         // convert_binary_to_image(image))),
          //         // image: AssetImage("images/pizza.jpg"))
          // ),
        ),
        SizedBox(height: 30),
        ClipRRect(
            borderRadius: BorderRadius.circular(20),
            // ignore: deprecated_member_use
            child: FlatButton(
              color: Color(0xFFEF9A9A),
              onPressed: () async {
                // var reco = await send_recommend_request(
                //     "shira@gmail.com", context);
                //
                // print("error: " + error.toString());
                // convert_binary_to_image();
                // print("recipe id in recommended: ");
                // print(recipeId);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {return OpeningPage(recipeId: recipeId,email: email);},
                  ),
                );
              },
              child: Text("Start This Recipe",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryLightColor)),
            ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          // ignore: deprecated_member_use
          child: FlatButton(
            color: Colors.black,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {return HomePage(email: email);},
                ),
              );
            },
            child: Text("no thanks",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryLightColor)),
          ),
        ),
      ],
    );
  }
  send_recommend_request(String email,context) async{

    print("im in questions about to send out request");

    var url = Uri.parse("http://10.0.2.2:5000/api/RecommendRecipe");
    var data = jsonEncode({
      'email': email,
    });
    var headers = {"Connection": "keep-alive","Accept": "application/json"};
    var dataRec = null;
    var response = await http.post(url,
        body: data,headers: headers);
    // response.stream.transform(utf8.decoder).listen((value) {
    //   print(value);
    // });
    print("response status:");
    print(response.statusCode);
    print("\n");
    if (response.statusCode == 200){
      print("~~~~~yes~~~~~~~~~");
      dataRec = json.decode(response.body);
      print(dataRec['name']);
      print(dataRec['image']);

    }
    else{
      error = response.statusCode;
      print("#######no##########");
      // לכל שגיאה אחרת צריך להתעלם מדף ההמלצות או לעבור לעמוד הבא ישר
    }
  }
  convert_binary_to_image(){
    print("*********************************************");
    print(image);
    print(image.runtimeType);
    // print(image.toString());
    var sss = utf8.encode(image.toString());
    print(sss);
    print(sss.runtimeType);
    print("converting!!!!");
    // var image = utf8.decode(base64.decode(img));
    // print(utf8.decode(sss));
    // var img = base64.decode(image.toString());
    // print("converting!!!!");
    var recImage = new Image.memory(sss);
    print(recImage.runtimeType);

    return recImage;
  }
}
