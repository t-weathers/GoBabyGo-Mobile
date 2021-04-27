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
  activityPage( { this.activityName } );

  final stepsArray = ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten"];
  List<Map<dynamic, dynamic>> lists = [];
  final dbRef = FirebaseDatabase.instance.reference().child("Activities");
  int stepsIndex;
  int stepLen = 0;
  int imageNum = 0;
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
              print("== snapshot " + snapshot.toString());
              print("== lists " + lists.toString());

              if(lists[0]["Steps"] != null){
                print("entered steps if statement");
                stepLen = lists[0]["Steps"].length;
              }
              if(lists[0]["Images"] != null){
                print("entered images if statement");

                if(lists[0]["Images"]["One"] == "Nothing to show here"){
                  imageNum=0;
                }
                else{
                  imageNum = lists[0]["Images"].length;
                }

              }
              print("STEPLEN == " + stepLen.toString());
              print("IMAGENUM == " + imageNum.toString());

              //return SingleChildScrollView(
              // return Container(
              //     child: Column(
                    //mainAxisSize: MainAxisSize.max,
              return SingleChildScrollView(
                    child: Column(

                    children: <Widget>[
                      SizedBox(height: 10),
                      Container(
                          padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                          child: Text(lists[0]["Description"],
                              style: TextStyle(fontFamily: 'Montserrat', fontSize: 15, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic))
                      ),
                      Divider(
                          color: Colors.black
                      ),
                      for (var stepsIndex = 0; stepsIndex < stepLen ; stepsIndex++)
                        Container(
                            padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                            child: Column(
                              children: <Widget>[
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Step " + (stepsIndex + 1).toString(), style: TextStyle(fontFamily: 'Montserrat', fontSize: 16, fontWeight: FontWeight.w700))
                                ),
                                SizedBox(height: 10),
                                Text(lists[0]["Steps"][stepsArray[stepsIndex]])
                              ],
                            )
                            // child: Text("Step: " + (stepsIndex + 1).toString() + "\n" + lists[0]["Steps"][stepsArray[stepsIndex]] + '\n',
                            //     style: TextStyle(fontFamily: 'Montserrat', fontSize: 16, fontWeight: FontWeight.w700))
                        ),

                      // ListView.builder(
                      //   itemCount: stepLen,
                      //   itemBuilder: (BuildContext context, int index) {
                      //     return new Text("Step: " + (index + 1).toString() + " " + lists[0]["Steps"][index] + '\n',
                      //     style: TextStyle(fontFamily: 'Montserrat', fontSize: 16, fontWeight: FontWeight.w700));
                      //   }
                      // ),
                      SizedBox(height: 20),
                      for (var imageIndex = 0; imageIndex < imageNum; imageIndex++)
                        Container(
                          child: Padding(
                              padding: EdgeInsets.all(30),
                              child: Image.network(lists[0]["Images"][stepsArray[imageIndex]].toString(),fit: BoxFit.cover,
                            loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null ?
                                  loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                      : null,
                                ),
                              );
                            },
                          )),
                        )
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