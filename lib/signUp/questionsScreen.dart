import 'package:flutter/material.dart';

import 'bodyQuestions.dart';
import 'package:cookids/httpRequests.dart';

class QuestionScreen extends StatelessWidget {
  final String email;
  QuestionScreen({Key key, @required this.email}):super(key: key);
  @override
  void initState() {
    load_recoRecipes(email);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BodyQuestions(email: email));
  }
}
