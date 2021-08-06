import 'package:cookids/homePage/recommendpage.dart';
import 'package:cookids/logIn/logOrSign.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cookids/constants.dart';
import 'package:cookids/homePage/homepage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cookids/homePage/levelPage.dart';
import 'package:cookids/httpRequests.dart';

//https://www.youtube.com/watch?v=XBKzpTz65Io&ab_channel=TheFlutterWay
//https://www.youtube.com/watch?v=qQ75cxc5q8o&ab_channel=TheFlutterWay
//https://www.youtube.com/watch?v=SxAfj2eFs20&ab_channel=MosallasGroup

class BodyHomepage extends StatelessWidget {
  final String email;

  BodyHomepage({Key key, @required this.email}) : super(key: key);

  int error = 0;
  List<Map<String, dynamic>> recipesList = [];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Please Choose A Category:",
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: .85,
              crossAxisSpacing: 20,
              //mainAxisSpacing: 20,
              children: <Widget>[
                Cards(
                    srcPic: "images/easy.png",
                    title: "Easy",
                    press: () async {
                      load_recipes("Easy",context);

                    }),
                Cards(
                    srcPic: "images/medium.png",
                    title: "Medium",
                    press: () async {
                      load_recipes("Medium",context);
                    }),
                //SizedBox(width: 50),
                //Cards(srcPic: "images/hard.png", title: "Hard", press: () {})
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: GridView.count(
              crossAxisCount: 1,
              /*        childAspectRatio: .85,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,*/
              children: <Widget>[
                /* Cards(
                    srcPic: "images/easy.png",
                    title: "Easy",
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return RecPage();
                          },
                        ),
                      );
                    }),
                Cards(srcPic: "images/medium.png", title: "Medium", press: () {}),*/
                //SizedBox(width: 50),
                Cards(
                    srcPic: "images/hard.png",
                    title: "Hard",
                    press: () async {
                      load_recipes("Hard",context);
                    })
              ],
            ),
          ),
        ),
      ],
    )

        /* return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            //height: size.height * .4,
            decoration: BoxDecoration(
                color: Color(0xFFE8F5E9),
                image: DecorationImage(
                    scale: 3,
                    alignment: Alignment.center,
                    colorFilter: new ColorFilter.mode(
                        Color(0xFFE8F5E9).withOpacity(0.6), BlendMode.dstATop),
                    image: AssetImage("images/kidCook.png"))),
          ),
          SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                */ /*Container(
                  alignment: Alignment.center,
                  height: 52,
                  width: 52,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
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
                  ),
                ),*/ /*
                const SizedBox(height: 160),
                //Text("Choose A Level:", textAlign: TextAlign.center, style: TextStyle(fontSize:30)),

                Expanded(
                    child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: .85,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  children: <Widget>[
                    Cards(srcPic: "images/easy.png",title:"Easy",press:(){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return RecPage();
                          },
                        ),
                      );
                    }),
                    Cards(srcPic: "images/medium.png",title:"Medium",press:(){}),
                    //SizedBox(width: 50),
                    Cards(srcPic: "images/hard.png",title:"Hard",press:(){})

                  ],
                ))
              ],
            ),
          )),
        ],
      ),
    )*/
        ;
  }
  load_recipes(String category,context) async{
    if (!recErrorFlag && recoRecipes.containsKey(category) &&
        recoRecipes[category].length !=0){
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return RecPage(
                name: recoRecipes[category]['name'],
                email: email,
                image: recoRecipes[category]['image'].toString(),
                recipeId: recoRecipes[category]['id']);
          },
        ),
      );

    } else{
      var reco =
          await send_recommend_request(email, category, context);

      print("error: " + error.toString());
    }
  }

  send_recommend_request(String email, levelId, context) async {
    print("im in questions about to send out request");

    // Map<String, dynamic> recipesList = get_recipes_by_id(levelId,context);
    var url = Uri.parse("http://10.0.2.2:5000/api/RecommendRecipe");
    var data = jsonEncode({
      'email': email,
    });
    var headers = {"Connection": "keep-alive", "Accept": "application/json"};
    var dataRec = null;
    // var request = http.Request('POST',url);
    // request.persistentConnection = false;
    // request.body = data;
    // request.headers.addAll(headers);
    // request.persistentConnection = false;
    // // var response = await http.post(url,
    // //     body: data,headers: headers);
    // var response = await request.send();
    var response = await http.post(url, headers: headers, body: data);
    // response.stream.transform(utf8.decoder).listen((value) {
    //   print(value);
    // });
    print("response status:");
    print(response.statusCode);
    print("\n");
    if (response.statusCode == 200) {
      print("~~~~~yes~~~~~~~~~");
      print("moving to recommendation page");
      // dataRec = json.decode(response.body);
      // dataRec = await response.stream.bytesToString();
      // dataRec = json.decode(dataRec);
      dataRec = json.decode(response.body);
      print(dataRec['name']);
      print(dataRec['image'].toString());
      print("type: ");
      print(dataRec['image'].runtimeType);
      // print(dataRec['id']);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return RecPage(
                name: dataRec['name'],
                email: email,
                image: dataRec['image'].toString(),
                recipeId: dataRec['id']);
          },
        ),
      );
    } else {
      error = response.statusCode;
      print("#######no##########");
      await get_recipes_by_id(levelId, context);
      print("this is the list i got from recipes request: ");
      print(recipesList);
      if (recipesList.length == 0) {
        await _showMyDialog(context);
      } else {
        print("moving to levelPage");
        // לכל שגיאה אחרת צריך להתעלם מדף ההמלצות או לעבור לעמוד הבא ישר
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              // return LevelPage(list: recipesList);
              return LevelPage(
                  list: recipesList, selected: levelId, email: email);
            },
          ),
        );
      }
    }
  }

  get_recipes_by_id(String id, context) async {
    print("im in get_recipes about to send out request");
    if (recipes != null && recipes.containsKey(id) && recipes[id].length != 0) {
      print(
          "~~~~~~~~~~~no need to send a new request for recipes!~~~~~~~~~~~~~~");
      recipesList = recipes[id];
      return;
    } else {
      var url =
          Uri.parse("http://10.0.2.2:5000/api/RecommendRecipe?level=" + id);
      // var data = jsonEncode({
      //   'id': email,
      // });
      var headers = {"Connection": "keep-alive", "Accept": "application/json"};
      var dataRec = null;
      var response = await http.get(url, headers: headers);
      // response.stream.transform(utf8.decoder).listen((value) {
      //   print(value);
      // });
      print("response status:");
      print(response.statusCode);
      print("\n");
      if (response.statusCode == 200) {
        print("~~~~~yes~~~~~~~~~");
        print(response.body);
        dataRec = json.decode(response.body);
        // print(dataRec['list']);
        // print("type: ");
        // print(dataRec['list'].runtimeType);
        final Map<String, dynamic> data_convert =
            Map<String, dynamic>.from(dataRec['list']);
        // final Map<String, dynamic> data = new Map<String,dynamic>();
        // print(data2.runtimeType);
        // print(data2);
        recipesList.clear();
        for (String key in data_convert.keys) {
          // print(key);
          String name = data_convert[key]["name"];
          var image = data_convert[key]["image"].toString();
          var element = {"id": key, "name": name, "image": image};
          // print(name);
          // print(image);
          recipesList.add(element);
          // recipesList[name] = image;
        }
        // for (String key in data.keys){
        //   print(key);
        //   print(data[key]);
        //
        // }
        print(recipesList.runtimeType);
        print(recipesList.length);
        print("finished");
        // return data;

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) {
        //       return RecPage(name: dataRec['name'],image: dataRec['image'].toString());
        //     },
        //   ),
        // );

      } else {
        error = response.statusCode;
        print("#######no##########");
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

// send_recommend_request(String email,context) async{
//
//   print("im in questions about to send out request");
//
//   var url = Uri.parse("http://10.0.2.2:5000/api/RecommendRecipe");
//   var data = jsonEncode({
//     'email': email,
//   });
//   var headers = {"Connection": "keep-alive","Accept": "application/json"};
//   var dataRec = null;
//   // var response = await http.post(url,
//   //     body: data,headers: headers);
//   var request = await http.Request('POST',url);
//   request.headers.addAll(headers);
//   request.body = data;
//   var response = await request.send();
//
//   // response.stream.transform(utf8.decoder).listen((value) {
//   //   print(value);
//   // });
//   print("response status:");
//   print(response.statusCode);
//   print("\n");
//   if (response.statusCode == 200){
//     print("~~~~~yes~~~~~~~~~");
//     String rawData = await response.stream.transform(utf8.decoder).join();
//     dataRec = jsonDecode(rawData);
//     print(dataRec['name']);
//     print(dataRec['image']);
//     print("type: ");
//     print(dataRec['image'].runtimeType);
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) {
//           return RecPage(name: dataRec['name'],image: dataRec['image']);
//         },
//       ),
//     );
//
//   }
//   else{
//     error = response.statusCode;
//     print("#######no##########");
//     // לכל שגיאה אחרת צריך להתעלם מדף ההמלצות או לעבור לעמוד הבא ישר
//   }
// }

}

class Cards extends StatelessWidget {
  final String srcPic;
  final String title;
  final Function press;

  const Cards({
    Key key,
    this.srcPic,
    this.title,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Container(
          //alignment: Alignment.center,
          //padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 17),
                    blurRadius: 17,
                    spreadRadius: -23,
                    color: Colors.grey)
              ]),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: press,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Image.asset(srcPic),
                    Spacer(),
                    Text(title,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .title
                            .copyWith(fontSize: 20))
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
