import 'package:cookids/firstScreen/profilePage.dart';
import 'package:cookids/homePage/bodyLevelPage.dart';
import 'package:flutter/material.dart';
import 'package:cookids/constants.dart';
import 'package:cookids/beforeCooking/ingridientsPage.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import 'dart:convert';

class OpeningPage extends StatelessWidget {
  final String recipeId;
  final String email;
  OpeningPage({Key key, @required this.recipeId,@required this.email}):super(key: key);
  int error = 0;
  List<Map<String,dynamic>> ingrsList = [];
  // List<Map<String,dynamic>> recipeList = [];

  //final pruduct

/*  //constroctor
  const OpeningPage({
    key key,
  this.pruduct
}) : super {key:key};*/

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                      return ProfilePage(email: email);
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
            const SizedBox(height: 100),
            Container(
                padding: EdgeInsets.all(4),
                /*    height: 180,
                width: 160,*/
                decoration: BoxDecoration(
                  color: kPrimaryLightColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.asset("images/open.png")),
            const SizedBox(height: 50),
            ClipRRect(
                borderRadius: BorderRadius.circular(20),
                // ignore: deprecated_member_use
                child: FlatButton(
                  color: Colors.black,
                  onPressed: () async {
                    var reco = await get_ingrids_by_id(context);

                    print("error: " + error.toString());

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) {
                    //       return IngridientPage(recipeId: recipeId);
                    //     },
                    //   ),
                    // );
                  },
                  child: Text("lets pick up the ingredients!",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryLightColor)),
                )),
          ],
        ));
  }
  get_ingrids_by_id(context) async{
    print("im in get_ingrids about to send out request");
    print("recipe id: ");
    print(recipeId);
    var url = Uri.parse("http://10.0.2.2:5000/api/SelectRecipe?id="+recipeId);
    // var data = jsonEncode({
    //   'id': email,
    // });
    var headers = {"Connection": "keep-alive","Accept": "application/json"};
    var dataRec = null;
    var response = await http.get(url,headers: headers);
    // response.stream.transform(utf8.decoder).listen((value) {
    //   print(value);
    // });
    print("response status:");
    print(response.statusCode);
    print("\n");
    if (response.statusCode == 200){
      print("~~~~~yes~~~~~~~~~");
      print(response.body);
      dataRec = json.decode(response.body);
      var ingrids = dataRec["ingredients"];
      var recipes = dataRec["recipe"];
      if (ingrids == "" || recipes == ""){
        print("got an empty ingredients or recipe desc");
        await _showMyDialog(context);
      }
      else {
        final Map<String, dynamic> data_converted = Map<String, dynamic>.from(dataRec['ingredients']);
        // final Map<String, dynamic> recipe_data_converted = Map<String, dynamic>.from(dataRec['ingredients']);
        ingrsList.clear();
        // recipeList.clear();
        for (String key in data_converted.keys){
          // print(key);
          String name = data_converted[key]["line"];
          var image = data_converted[key]["images"];
          // print("images received: ");
          // List<String> stringList = image != null ? List.from(image) : null;
          // print(image);
          // if (name !="apple"){
          //   print(image[0]);
          // }
          ingrsList.add({"id": key,
            "name": name,
            "image":image});
        }
        print(ingrsList);
        print(ingrsList.runtimeType);
        print(ingrsList.length);
        print("finished");
        // print(base64Decode(((ingrsList[1]["image"])[0])));
        // print(ingrsList[1]["image"][0]);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return IngridientPage(recipeId: recipeId,email: email,list: ingrsList,recipeList:dataRec['recipe'] );
            },
          ),
        );
      }
      // print(dataRec['list']);
      // print("type: ");
      // print(dataRec['list'].runtimeType);
      // final Map<String, dynamic> data2 = Map<String, dynamic>.from(dataRec['list']);
      // // final Map<String, dynamic> data = new Map<String,dynamic>();
      // // print(data2.runtimeType);
      // // print(data2);
      // recipesList.clear();
      // for (String key in data2.keys){
      //   // print(key);
      //   String name = data2[key]["name"];
      //   var image = data2[key]["image"].toString();
      //   var element = {"id": key,
      //     "name": name,
      //     "image":image};
      //   // print(name);
      //   // print(image);
      //   recipesList.add(element);
      //   // recipesList[name] = image;
      // }
      // // for (String key in data.keys){
      // //   print(key);
      // //   print(data[key]);
      // //
      // // }
      // print(recipesList.runtimeType);
      // print(recipesList.length);
      // print("finished");


    }
    else{
      error = response.statusCode;
      print("#######no##########");
      print("could not fing ingredients or recipe desc- 404 error");
      await _showMyDialog(context);
      // Map<String, dynamic> data2 = new Map<String,dynamic>();
      // return data2;

      // לכל שגיאה אחרת צריך להתעלם מדף ההמלצות או לעבור לעמוד הבא ישר
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) {
      //       return LevelPage(categoryId: levelId);
      //     },
      //   ),
      // );
    }
  }

  Future<void> _showMyDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Something is wrong..'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                // Text(''),
                Text('please try again.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}

