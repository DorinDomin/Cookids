import 'package:cookids/logIn/bodyLogOrSign.dart';
import 'package:cookids/logIn/bodyLogin.dart';
import 'package:cookids/logIn/loginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cookids/homePage/homepage.dart';
import 'package:cookids/dataForQuestions.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cookids/httpRequests.dart';

import '../constants.dart';
// String _currentChoice = questionTwo[0];
var _singleNotifierQ2;
var _singleNotifierQ3;
var _singleNotifierQ4;

class BodyQuestions extends StatelessWidget {
  final String email;
  BodyQuestions({Key key, @required this.email}):super(key: key);

  int error = 0;
  final _ageController = TextEditingController();

  // var hear = 0;
  // var adult = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.02),

            Text(
              "We just have a questions..",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Positioned(
                top: 100,
                child: Image.asset(
                  "images/kidwrite.png",
                  height: size.height * 0.35,
                )),
            Container(
              width: size.width * 0.8,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)),
              // ignore: deprecated_member_use
              child: FlatButton(
                child: Text('what is your age?',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey)),
                //onTap: () =>_showSingleChoiceDialog(context),
                onPressed: () => _showTextDialog(context),
              ),
            ),
            SizedBox(height: 17),
            // ignore: deprecated_member_use
            Container(
              width: size.width * 0.8,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)),
              // ignore: deprecated_member_use
              child: FlatButton(
                child: Text('Can you read?',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey)),
                //onTap: () =>_showSingleChoiceDialog(context),
                onPressed: () => _showSingleChoiceDialogQ2(context),
              ),
            ),
            SizedBox(height: 17),
            Container(
              width: size.width * 0.8,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)),
              // ignore: deprecated_member_use
              child: FlatButton(
                child: Text('Do you need audio help?',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey)),
                //onTap: () =>_showSingleChoiceDialog(context),
                onPressed: () => _showSingleChoiceDialogQ3(context),
              ),
            ),
            SizedBox(height: 17),
            Container(
              width: size.width * 0.8,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)),
              // ignore: deprecated_member_use
              child: FlatButton(
                child: Text('do you need the help of an adult?',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey)),
                //onTap: () =>_showSingleChoiceDialog(context),
                onPressed: () => _showSingleChoiceDialogQ4(context),
              ),
            ),
            SizedBox(height: 17),
            RoundedButton(
              text: "I'm ready to start!",
              color: Colors.black54,
              press: () async {
                int read = 0;
                int hear = 0;
                int adult = 4;
                // var send_to_check = await send_answers_request(emailTextEditor.data.text,passTextEditor.userpassword.text,context);
                print(_ageController.text);
                // print(_currentChoice);
                if (_ageController.text!="") {
                  if (_singleNotifierQ2 !=null){
                    read = questionTwo.indexOf(
                        _singleNotifierQ2.currentChoich(2));
                    print("read:");
                    print(_singleNotifierQ2.currentChoich(2));
                    print(read);
                  }
                  if (_singleNotifierQ3!=null){
                    hear = questionThree.indexOf(
                        _singleNotifierQ3.currentChoich(3));
                    //if (_singleNotifierQ3.currentChoich == )
                    // remember to cast to int 012 hear!!!
                    print("hear:");
                    print(_singleNotifierQ3.currentChoich(3));
                    print(hear);
                  }
                  if (_singleNotifierQ4!=null){
                    adult = questionFour.indexOf(
                        _singleNotifierQ4.currentChoich(4));
                    print("adult:");
                    print(_singleNotifierQ4.currentChoich(4));
                    print(adult);
                  }
                  var send_to_check = await send_answers_request(
                      email, _ageController.text, read, hear,
                      adult, context);

                  print("error: " + error.toString());
                  // pls print to user the error:
                  // if error == 400: print to user that something is wrong with the data
                  // else (any other error): print to user that something is wrong, pls try later
                }
                else{
                  print("its empty!");
                  if (_ageController.text!=""){
                    var send_to_check = await send_answers_request(
                        email, _ageController.text, read, hear,
                        adult, context);

                    print("error: " + error.toString());
                    // pls print to user the error:
                    // if error == 400: print to user that something is wrong with the data
                    // else (any other error): print to user that something is wrong, pls try later
                  }else{
                    // pls print to user he needs to answer all the questions
                  }


                }

              },
            ),

            //OrDivider(),
          ],
        ));
  }
  send_answers_request(String email,age,read,hear,adult_help,context) async{

    print("im in questions about to send out request");

    var url = Uri.parse("http://10.0.2.2:5000/api/Questions");
    var data = jsonEncode({
      'email': email,
      'age':  age,
      'read': read,
      'hear':hear,
      'adult': adult_help,
    });
    var response = await http.post(url,
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

    }
    else{
      error = response.statusCode;
      print("#######no##########");
    }
  }


  _showSingleChoiceDialogQ2(BuildContext context) => showDialog(
      context: context,
      builder: (context) {
        _singleNotifierQ2 = Provider.of<SingleNotifier>(context);
        if (_singleNotifierQ2.currentChoich(2) ==null){
          _singleNotifierQ2.updateChoice(questionTwo[0]);
          print("_singleNotifierQ2 first: ");
          print(_singleNotifierQ2.currentChoich(2));
        }

        return AlertDialog(
          title: Text('select one options:'),
          content: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: questionTwo
                    .map((e) => RadioListTile(
                  title: Text(e),
                  value: e,
                  groupValue: _singleNotifierQ2.currentChoich(2),
                  selected: _singleNotifierQ2.currentChoich(2) == e,
                  onChanged: (value) {
                    _singleNotifierQ2.updateChoice(value);
                    //read = value;
                    Navigator.of(context).pop();
                  },
                ))
                    .toList(),
              ),
            ),
          ),
        );
      });

  _showSingleChoiceDialogQ3(BuildContext context) => showDialog(
      context: context,
      builder: (context) {
        _singleNotifierQ3 = Provider.of<SingleNotifier>(context);
        if (_singleNotifierQ3.currentChoich(3) ==null){
          _singleNotifierQ3.updateChoice(questionThree[0]);
          print("_singleNotifierQ3 first: ");
          print(_singleNotifierQ3.currentChoich(3));
        }


        return AlertDialog(
          title: Text('select one options:'),
          content: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: questionThree
                    .map((e) => RadioListTile(
                  title: Text(e),
                  value: e,
                  groupValue: _singleNotifierQ3.currentChoich(3),
                  selected: _singleNotifierQ3.currentChoich(3) == e,
                  onChanged: (value) {
                    _singleNotifierQ3.updateChoice(value);
                    Navigator.of(context).pop();
                  },
                ))
                    .toList(),
              ),
            ),
          ),
        );
      });

  _showSingleChoiceDialogQ4(BuildContext context) => showDialog(
      context: context,
      builder: (context) {
        _singleNotifierQ4 = Provider.of<SingleNotifier>(context);
        if (_singleNotifierQ4.currentChoich(4) ==null){
          _singleNotifierQ4.updateChoice(questionFour[0]);
          print("_singleNotifierQ4 first: ");
          print(_singleNotifierQ4.currentChoich(4));
        }

        return AlertDialog(
          title: Text('select one options:'),
          content: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: questionFour
                    .map((e) => RadioListTile(
                  title: Text(e),
                  value: e,
                  groupValue: _singleNotifierQ4.currentChoich(4),
                  selected: _singleNotifierQ4.currentChoich(4) == e,
                  onChanged: (value) {
                    _singleNotifierQ4.updateChoice(value);
                    Navigator.of(context).pop();
                  },
                ))
                    .toList(),
              ),
            ),
          ),
        );
      });

  _showTextDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) {
        final _singleNotifier = Provider.of<SingleNotifier>(context);
        return AlertDialog(
          title: Text('Age:'),
          content: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                TextFormField(
                keyboardType: TextInputType.text,
                controller: _ageController,
                decoration: InputDecoration(
                  hintText: 'enter you note',
                  icon: Icon(Icons.note_add),
                ),
              ),
                  ]
              ),
            ),
          ),
        );
      });

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
          child,
        ],
      ),
    );
  }
}

class SingleNotifier extends ChangeNotifier {
  String _currentChoiceQ2;
  String _currentChoiceQ3;
  String _currentChoiceQ4;

  List<String> Q2list = questionTwo;
  List<String> Q3list = questionThree;
  List<String> Q4list = questionFour;

  String currentChoich(int qName){
    if (qName == 2){
      return _currentChoiceQ2;
    }
    if (qName == 3){
      return _currentChoiceQ3;
    }
    if (qName == 4){
      return _currentChoiceQ4;
    }
    return null;

  }

  updateChoice(String value) {
    if (Q2list.contains(value) && value != _currentChoiceQ2){
      _currentChoiceQ2 = value;
      notifyListeners();
    }
    if (Q3list.contains(value) && value != _currentChoiceQ3){
      _currentChoiceQ3 = value;
      notifyListeners();
    }
    if (Q4list.contains(value) && value != _currentChoiceQ4){
      _currentChoiceQ4 = value;
      notifyListeners();
    }

    // if (value != _currentChoice) {
    //   _currentChoice = value;
    //
    //   notifyListeners();
    // }
    // else{
    //   print("cant update to value: ");
    //   print(value);
    //   print("list says: ");
    //   print(list.contains(value));
    //   print("first condition says: ");
    //   print(value != _currentChoice);
    // }
  }
}
