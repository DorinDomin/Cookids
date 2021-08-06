import 'dart:convert';
import 'package:http/http.dart' as http;

List<Map<String,dynamic>> easyRecipesList = [];
List<Map<String,dynamic>> mediumRecipesList = [];
List<Map<String,dynamic>> hardRecipesList = [];
Map recipes = Map<String, List<Map<String,dynamic>>>();
Map recoRecipes = Map<String, List<Map<String,dynamic>>>();
// List<List<Map<String,dynamic>>> recipesList = [];
// recipesList.add(new List<Map<String,dynamic>>);
bool errorFlag = false;
bool recErrorFlag = false;
// Map recErrorFlag = {"result": false,"code": 0};
bool called = false;

load_recipes() async{
  if (!called){
    called = true;
    var dummpy = await get_recipes_by_id("Easy",easyRecipesList);
    dummpy = await get_recipes_by_id("Medium",mediumRecipesList);
    dummpy = await get_recipes_by_id("Hard",hardRecipesList);
    recipes["Easy"] = easyRecipesList;
    recipes["Medium"] = mediumRecipesList;
    recipes["Hard"] = hardRecipesList;
    print(recipes);
  }

}
load_recoRecipes(String email) async{
    var dummpy = await send_recommend_request(email,"Easy");
    dummpy = await send_recommend_request(email,"Medium");
    dummpy = await send_recommend_request(email,"Hard");
    print(recoRecipes);
}
load_recipes_by_id(String id) async{
  if (id == "Easy"){
    var x = await get_recipes_by_id("Easy",easyRecipesList);
    recipes["Easy"] = easyRecipesList;
  }else{
    if (id == "Medium"){
      var x = await get_recipes_by_id("Medium",mediumRecipesList);
      recipes["Medium"] = mediumRecipesList;
    }else{
      if (id == "Hard"){
        var x = await get_recipes_by_id("Hard",hardRecipesList);
        recipes["Hard"] = hardRecipesList;
      }
    }
  }
}
check() async{
  print("check");
}
get_recipes_by_id(String id,List<Map<String,dynamic>> list) async{
  print("loading recipes..");

  var url = Uri.parse("http://10.0.2.2:5000/api/RecommendRecipe?level="+id);
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
    print(id);
    // print(response.body);
    dataRec = json.decode(response.body);
    final Map<String, dynamic> data_convert = Map<String, dynamic>.from(dataRec['list']);
    list.clear();
    for (String key in data_convert.keys){
      // print(key);
      String name = data_convert[key]["name"];
      var image = data_convert[key]["image"].toString();
      var element = {"id": key,
        "name": name,
        "image":image};
      list.add(element);
      // recipesList[name] = image;
    }
    // for (String key in data.keys){
    //   print(key);
    //   print(data[key]);
    //
    // }
    print(list.runtimeType);
    print(list.length);
    print("finished");
  }
  else{
    errorFlag = true;
  }
}
send_recommend_request(String email, levelId) async {
  print("getting reco recipes..");
  // Map<String, dynamic> recipesList = get_recipes_by_id(levelId,context);
  var url = Uri.parse("http://10.0.2.2:5000/api/RecommendRecipe");
  var data = jsonEncode({
    'email': email,
  });
  var headers = {"Connection": "keep-alive", "Accept": "application/json"};
  var dataRec = null;
  var response = await http.post(url, headers: headers, body: data);
  // response.stream.transform(utf8.decoder).listen((value) {
  //   print(value);
  // });
  print("response status:");
  print(response.statusCode);
  print("\n");
  if (response.statusCode == 200) {
    print("~~~~~yes~~~~~~~~~");
    // print("moving to recommendation page");
    // dataRec = json.decode(response.body);
    // dataRec = await response.stream.bytesToString();
    // dataRec = json.decode(dataRec);
    dataRec = json.decode(response.body);
    print(dataRec['name']);
    print(dataRec['image'].toString());
    print("type: ");
    print(dataRec['image'].runtimeType);
    recoRecipes[levelId] = {
      "name": dataRec['name'],
      "image": dataRec['image'].toString(),
      "recipeId": dataRec['id']
    };
    // print(dataRec['id']);
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) {
    //       return RecPage(
    //           name: dataRec['name'],
    //           email: email,
    //           image: dataRec['image'].toString(),
    //           recipeId: dataRec['id']);
    //     },
    //   ),
    // );
  } else {
    recErrorFlag = true;
    // recErrorFlag["result"] = true;
    // recErrorFlag["code"] = response.statusCode;
    print("#######no##########");
    // await get_recipes_by_id(levelId, context);
    // print("this is the list i got from recipes request: ");
  }
}


