import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing_app/activitiesData.dart';
import 'package:testing_app/user.dart';
import 'timelog.dart';

String formatTime(int milliseconds){
  var secs = milliseconds ~/ 1000;
  var hours = (secs ~/ 3600).toString().padLeft(2, '0');
  var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
  var seconds = (secs % 60).toString().padLeft(2, '0');
  return "$hours:$minutes:$seconds";
}


class activityPage extends StatefulWidget{

  final String activityName;
  user userInfo;
  activityPage( { this.activityName, this.userInfo } );

  @override
  _activityPage createState() => _activityPage();

}

class _activityPage extends State<activityPage> {

  final stepsArray = ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten"];
  List<Map<dynamic, dynamic>> lists = [];
  final dbRef = FirebaseDatabase.instance.reference().child("Activities");
  int stepsIndex;
  int stepLen = 0;
  int imageNum = 0;
  Future myFuture;
      // .orderByChild("ActivityName")
      // .equalTo(activityName);

  @override
  void initState() {

    print("activity to push: " + widget.activityName);
    widget.userInfo.setRecentActivity(widget.activityName);

    super.initState();
  }

  void pushRecentActivity(){
    print("this will eventual start the timer");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.activityName, style: TextStyle(color: Colors.white, fontSize:24)),
          backgroundColor: Colors.orange[900],
          centerTitle: true,
        ),
        bottomNavigationBar: Container(
          height: 150,
          color: Colors.grey[300],
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(30, 0, 5, 0),
                  child: Text("00:00:00", style: TextStyle(fontSize: 35.0)),)
              ),
              Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 30, 0),
                    child: SizedBox(
                      width: 100.0,
                      height: 50.0,
                      child: ElevatedButton(
                          onPressed: () { pushRecentActivity(); },
                          child: Text('START TIME', style: TextStyle(fontSize: 15.0))),
                    ),
              )
              )
            ],
          )
        ),
        body: FutureBuilder(
            future: dbRef.orderByChild("ActivityName").equalTo(widget.activityName).once(),
            builder: (context, AsyncSnapshot<DataSnapshot> snapshot){
            if (snapshot.hasData){
              lists.clear();
              Map<dynamic, dynamic> values = snapshot.data.value;
              values.forEach((key, values){
                lists.add(values);
              });
              //print("== snapshot " + snapshot.toString());
              //print("== lists " + lists.toString());

              if(lists[0]["Steps"] != null){
                //print("entered steps if statement");
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
              return
                SingleChildScrollView(
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
                        ),
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