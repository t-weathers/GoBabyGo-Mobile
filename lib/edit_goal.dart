import 'dart:async';
//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:testing_app/user.dart';
import 'package:testing_app/userData.dart';
import 'dart:math' as math;

import 'package:testing_app/weekly_progress.dart';


class editGoal extends StatefulWidget{
  //final userData user;
  user userInfo;

  editGoal({Key key, @required this.userInfo}) : super(key: key);

  @override
  _editGoalState createState() => _editGoalState();
}

class _editGoalState extends State<editGoal>{

  int hour = 0;
  int minute = 0;

  @override
  void initState() {
    hour = (widget.userInfo.weeklyGoal/60).floor(); //this will eventually need to be calculated from the user's goal
    minute = widget.userInfo.weeklyGoal % 60;
    print("userID: " + widget.userInfo.userId);
    print("user weekly goal: " + widget.userInfo.weeklyGoal.toString());
    super.initState();
  }


  void handleIncreaseHour(){
    hour++;
    setState(() { });
  }

  void handleDecreaseHour(){
    if(hour>0){
      hour--;
    }
    setState(() { });
  }

  void handleIncreaseMin(){
    if(minute==59){
      minute=00;
    }
    else{
      minute++;
    }
    setState(() { });
  }

  void handleDecreaseMin(){
    if(minute==0){
      minute=59;
    }
    else{
      minute--;
    }
    setState(() { });
  }

  Future _notifyGoalSet() async {
    BuildContext dialogContext;
    await showDialog(
        context: context,
        /*it shows a popup with few options which you can select, for option we
        created enums which we can use with switch statement, in this first switch
        will wait for the user to select the option which it can use with switch cases*/
        builder: (BuildContext context) {
          dialogContext = context;
          return SimpleDialog(
            title: ListTile(
              title: const Text("WEEKLY GOAL SET", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20)),
              trailing: Icon(
                  Icons.check,
                  color: Colors.orange[900],
                  size: 33.0),
            ),
            titlePadding: EdgeInsets.fromLTRB(27.0, 30.0, 27.0, 0.0),
            contentPadding: EdgeInsets.fromLTRB(70.0, 10.0, 60.0, 0.0),
            children: <Widget>[
              //SizedBox(height: 30),
              SizedBox(
                height: 40,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(dialogContext, true),
                  child: Text('Continue', style: TextStyle(fontSize: 20.0)),),
              ),
              SizedBox(height: 30),
            ],
          );
        });
  }

  // Set the users weekly goal here
  void setGoal(){
    int totalMin = (hour * 60) + minute;
    print("user wants to set goal as: " + totalMin.toString());
    /*final dbRef = FirebaseDatabase.instance.reference().child("ParentUsers").child(widget.userInfo.userId);

    var goalData = {
      'WeeklyGoal': totalMin
    };
    dbRef.update(goalData);*/
    widget.userInfo.setWeeklyGoal(totalMin);
    _notifyGoalSet();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('Edit Goal', style: TextStyle(color: Colors.white, fontSize:24)),
          backgroundColor: Colors.orange[900],
          //automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        body: Container(
              child: Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 50),
                      Text("Set your weekly goal", style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 80, 10, 10),
                        child: _goalSetter(hour, minute),
                      ),
                      SizedBox(height: 50),
                      SizedBox(width: 200, height: 50, child:
                      RaisedButton(onPressed: () {
                        setGoal();
                      },
                          color: Colors.orange[900],
                          textColor: Colors.black,
                          padding: EdgeInsets.fromLTRB(40, 12, 40, 12),
                          splashColor: Colors.orange[900],
                          child: Text("SET GOAL", style: TextStyle(fontSize: 20))))
                    ],
                  )
              ),
            )
    );
  }

  Widget _goalSetter(hour, minute){
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Center(
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 5,
                child: Center(

                          child: Column(
                          children: <Widget>[
                            Text('Hours', style: TextStyle(fontSize: 25.0)),
                            SizedBox(height: 20),
                            Transform.rotate(angle: 90 * math.pi / 180,
                              child: IconButton(
                                icon: const Icon(Icons.arrow_back_ios, size: 50),
                                tooltip: 'Increase Hours',
                                alignment: Alignment.center,
                                onPressed: () {
                                  print("button pressed");
                                  handleIncreaseHour();
                                },
                              ),
                            ),
                            _timeBox(hour, false),
                            Transform.rotate(angle: 270 * math.pi / 180,
                              child: IconButton(
                                icon: const Icon(Icons.arrow_back_ios, size: 50),
                                tooltip: 'Decrease Hours',
                                alignment: Alignment.center,
                                onPressed: () {
                                  //print("button pressed");
                                  handleDecreaseHour();
                                },
                              ),
                            )

            ]))),
            Expanded(
                flex: 5,
                child: Center(
                    child: Column(
                        children: <Widget>[
                          Text('Minutes', style: TextStyle(fontSize: 25.0)),
                          SizedBox(height: 20),
                          Transform.rotate(angle: 90 * math.pi / 180,
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back_ios, size: 50),
                              tooltip: 'Increase minutes',
                              alignment: Alignment.center,
                              onPressed: () {
                                print("button pressed");
                                handleIncreaseMin();
                              },
                            ),
                          ),
                          _timeBox(minute, true),
                          Transform.rotate(angle: 270 * math.pi / 180,
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back_ios, size: 50),
                              tooltip: 'Decrease Minutes',
                              alignment: Alignment.center,
                              onPressed: () {
                                print("button pressed");
                                handleDecreaseMin();
                              },
                            ),
                          )

                        ])))
          ],
        ),
      ),
    );
  }

  Widget _timeBox(time, isMinutes){
    String stringTime;
    if(isMinutes && time < 10){
      stringTime = "0" + time.toString();
    }
    else{
      stringTime = time.toString();
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12)
      ),
      padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
      //margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
      //width: 140,
      height: 100,
      child: Text(stringTime, style: TextStyle(fontSize: 40.0))
    );
  }

}


//OLD JUST IN CASE I FUCK UP
// return new Scaffold(
// appBar: AppBar(
// title: Text('Edit Goal', style: TextStyle(color: Colors.white, fontSize:24)),
// backgroundColor: Colors.orange[900],
// //automaticallyImplyLeading: false,
// centerTitle: true,
// ),
// body: StreamBuilder(
// stream: Firestore.instance.collection('ParentUsers').snapshots(),
// builder: (context, snapshot) {
// if(!snapshot.hasData) return const Text("Loading...");
// return Container(
// child: Center(
// child: Column(
// children: <Widget>[
// SizedBox(height: 50),
// Text("Set your weekly goal", style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
// Padding(
// padding: EdgeInsets.fromLTRB(10, 80, 10, 10),
// child: _goalSetter(hour, minute),
// ),
// SizedBox(height: 50),
// SizedBox(width: 200, height: 50, child:
// RaisedButton(onPressed: () {
// setGoal();
// },
// color: Colors.orange[900],
// textColor: Colors.black,
// padding: EdgeInsets.fromLTRB(40, 12, 40, 12),
// splashColor: Colors.orange[900],
// child: Text("SET GOAL", style: TextStyle(fontSize: 20))))
// ],
// )
// ),
// );
// }
// )
// );