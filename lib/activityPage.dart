import 'package:firebase_database/firebase_database.dart';
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
  activityPage({this.activityName});
  final stepsArray = ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten"];
  List<Map<dynamic, dynamic>> lists = [];
  final dbRef = FirebaseDatabase.instance.reference().child("Activities");
  int stepsIndex;
      // .orderByChild("ActivityName")
      // .equalTo(activityName);

  // final dbRef = FirebaseDatabase.instance.reference().child("Activities");


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text(activityName, style: TextStyle(color: Colors.white, fontSize:24)),
          backgroundColor: Colors.orange[900],
          centerTitle: true,
    ),
      body: FutureBuilder(
      future: dbRef.orderByChild("ActivityName").equalTo(activityName).once(),
      builder: (context, AsyncSnapshot<DataSnapshot> snapshot){
        if (snapshot.hasData){
          lists.clear();
          Map<dynamic, dynamic> values = snapshot.data.value;
          values.forEach((key, values){
            lists.add(values);
          });

          return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: 10),
                  Container(
                      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                      child: Text("Activty Description: " + lists[0]["Description"],
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic))
                  ), Divider(
                      color: Colors.black
                  ),
                   for (var stepsIndex = 0; stepsIndex < lists[0]["Steps"].length ; stepsIndex++)
                    Text("Step: " + (stepsIndex + 1).toString() + " " + lists[0]["Steps"][stepsArray[stepsIndex]] + '\n',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
                  Container(
                    child: Text("Images", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
                  ),
                  for (var imageIndex = 0; imageIndex < lists[0]["Images"].length; imageIndex++)
                    Image.network(lists[0]["Images"][stepsArray[imageIndex]])
                ],
              ),
          );
        }
        return CircularProgressIndicator();
      }
    )
    );
  }
}





// for (var imageIndex = 0; imageIndex < 2 ; imageIndex++)
// Image.network(lists[0]["Images"][stepsArray[imageIndex]])
// return new Container(
//   child: new Text(lists[1]["Description"], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))
// );

// print("This is what the activityPage().activityName has: " + activityPage().activityName.toString());
// print("The name of the activty in list: " + lists[index]["ActivityName"]);
// print("the stored activity name: " + activityName);
// print("This is the length of the list: " + lists.length.toString());
// print(index);

// return new ListView.builder(
// shrinkWrap: true,
// itemCount: lists.length,
// itemBuilder: (BuildContext context, int index){
// if (lists[index]["ActivityName"] == activityName){
// print("This is what the activityPage().activityName has: " + activityPage().activityName.toString());
// // print("The name of the activty in list: " + lists[index]["ActivityName"]);
// // print("the stored activity name: " + activityName);
// // print("This is the length of the list: " + lists.length.toString());
// // print(index);
// return Card(
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: <Widget>[
// Text("Activty Description: " + lists[index]["Description"]),
// ],
// ),
//
// );
// }else{
// print("I guess its not a match");
// }
// });
// }