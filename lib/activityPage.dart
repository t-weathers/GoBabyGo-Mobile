import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing_app/activitiesData.dart';

// class faq extends StatefulWidget{
//   @override
//   _faqState createState() => _faqState();
// //SteeringRoute createState1() => SteeringRoute();
// }
//
// class _faqState extends State<faq>{


// class activityPage extends StatefulWidget{
//   activityPage(activitiesData data);
//
//   @override
//   _activityPage createState() => _activityPage();
//   }
//
// class _activityPage extends State<activityPage> {

class activityPage extends StatelessWidget{

  final String activityName;
  activityPage(this.activityName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text(activityName),
    backgroundColor: Colors.orange[900]
    ),
    body: new Container(
      child: new Text("We did it!"),
    ),
    );
  }
}
