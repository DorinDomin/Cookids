import 'package:cookids/beforeCooking/openingPage.dart';
import 'package:cookids/homePage/recommendpage.dart';
import 'package:cookids/logIn/logOrSign.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cookids/constants.dart';
import 'package:cookids/homePage/levelPage.dart';
import 'dart:convert';
import 'package:cookids/httpRequests.dart';

//https://www.youtube.com/watch?v=XBKzpTz65Io&ab_channel=TheFlutterWay
//https://www.youtube.com/watch?v=qQ75cxc5q8o&ab_channel=TheFlutterWay
//https://www.youtube.com/watch?v=SxAfj2eFs20&ab_channel=MosallasGroup
class BodyLevelPage extends StatefulWidget {
  List<Map<String,dynamic>> list;
  final String selected;
  final String email;
  BodyLevelPage({Key key, @ required this.list,@required this.selected,@required this.email}):super(key: key);
  @override
  _BodyLevelPage createState() => _BodyLevelPage();
}

// צריך אחכ לשלוח מערך של מוצרים עבור כל רמה.
int selectedIndex = 0;
String check_index;
class _BodyLevelPage extends State<BodyLevelPage> with SingleTickerProviderStateMixin {
  // List<Map<String,dynamic>> list;
  // final String selected;
  // final String email;
  // BodyLevelPage({Key key, @ required this.list,@required this.selected,@required this.email}):super(key: key);

  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    if (recipes != null){
      if (!recipes.containsKey("Easy")){
        load_recipes_by_id("Easy");
      }
      if (!recipes.containsKey("Medium")){
        load_recipes_by_id("Medium");
      }
      if (!recipes.containsKey("Hard")){
        load_recipes_by_id("Hard");
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    // PropertyChangeProvider.of<BodyLevelPage>(context);
    // list.addListener(_listener);
    // check_index = selected;
    selectedIndex = __CategoriesState.categories.indexOf(widget.selected);
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(left: 5.0),
        children: <Widget>[
          SizedBox(height: 15.0),
          Text('Please Choose A recipe:',
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(fontWeight: FontWeight.bold),
          ),
          // SizedBox(height: 5.0),
          _Categories(widget.list,_tabController),
          Container(
              height: MediaQuery.of(context).size.height - 200.0,
              width: double.infinity,
              child: TabBarView(
                  controller: _tabController,
                  children: [
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: GridView.builder(
                              itemCount: widget.list.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 18,
                                childAspectRatio: 0.75,
                              ),
                              itemBuilder: (context, index) => ItemCard(
                                //pruduct
                                  press: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>OpeningPage(recipeId: widget.list[index]["id"],email: widget.email))),recipesList: widget.list[index]

                              )),
                        )),
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: GridView.builder(
                              itemCount: recipes["Medium"].length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 18,
                                childAspectRatio: 0.75,

                              ),
                              itemBuilder: (context, index) => ItemCard(
                                //pruduct
                                  press: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>OpeningPage(recipeId: recipes["Medium"][index]["id"],email: widget.email))),recipesList: recipes["Medium"][index]

                              )),
                        )),
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: GridView.builder(
                              itemCount: recipes["Hard"].length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 18,
                                childAspectRatio: 0.75,
                              ),
                              itemBuilder: (context, index) => ItemCard(
                                //pruduct
                                  press: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>OpeningPage(recipeId: recipes["Hard"][index]["id"],email: widget.email))),recipesList: recipes["Hard"][index]

                              )),
                        )),
                  ]
              )
          )
        ],
      ),
    );
  }
}

// }

class ItemCard extends StatelessWidget {
  final Function press;
  final Map<String, dynamic> recipesList;
  //final Pruduct pruduct;

  const ItemCard({
    Key key,
    //this.pruduct
    this.press,
    this.recipesList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
                padding: EdgeInsets.all(4),
                /*    height: 180,
                width: 160,*/
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                // child: Image.asset("images/pizza.jpg")),
                child: new Image.memory(base64Decode(recipesList["image"].toString()))),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20 / 4),
            child: Text(
              recipesList["name"],
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

class _Categories extends StatefulWidget {
  List<Map<String,dynamic>> list;
  TabController _tabController;
  _Categories(this.list,this._tabController);

  @override
  __CategoriesState createState() => __CategoriesState();
}

class __CategoriesState extends State<_Categories> {
  static List<String> categories = ["Easy", "Medium", "Hard"];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child:
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 65),
        child: TabBar(
            controller: widget._tabController,
            indicatorColor: Colors.transparent,
            labelColor: Color(0xFF050505),
            isScrollable: false,
            labelPadding: EdgeInsets.only(right: 22.0),
            unselectedLabelColor: Color(0xFF908F8F),
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            //For Selected tab
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
            //For Un-selected Tabs
            tabs: [
              Tab(
                child: Text('Easy',
                    style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 19.0,
                    )),
              ),
              Tab(
                child: Text('Medium',
                    style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 19.0,
                    )),
              ),
              Tab(
                child: Text('Hard',
                    style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 19.0,
                    )),
              )
            ]),
      ),
    );
  }
}
