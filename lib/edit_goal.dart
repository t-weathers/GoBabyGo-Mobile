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
import 'constants.dart';

import 'package:testing_app/weekly_progress.dart';

/// EDIT GOAL CLASS
/// * Description: this class lets the user edit their weekly goal and stores in the db
/// * Functions: initState, handleIncreaseHour, handleDecreaseHour, handleIncreaseMin,
/// * handleDecreaseMin, _notifyGoalSet, setGoal
/// **/
class editGoal extends StatefulWidget{
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
    super.initState();
  }

  /// Function: handleIncreaseHour
  /// Description: increases the hour variable by one, then reloads the page to reflect that change
  /// Params: none **/
  void handleIncreaseHour(){
    hour++;
    setState(() { });
  }

  /// Function: handleDecreaseHour
  /// Description: decreases the hour variable by one, then reloads the page to reflect that change
  /// Params: none **/
  void handleDecreaseHour(){
    if(hour>0){
      hour--;
    }
    setState(() { });
  }

  /// Function: handleIncreaseMin
  /// Description: increases the minute variable by one, then reloads the page to reflect that change
  /// Params: none **/
  void handleIncreaseMin(){
    if(minute==59){
      minute=00;
    }
    else{
      minute++;
    }
    setState(() { });
  }

  /// Function: handleDecreaseMin
  /// Description: decreases the minute variable by one, then reloads the page to reflect that change
  /// Params: none **/
  void handleDecreaseMin(){
    if(minute==0){
      minute=59;
    }
    else{
      minute--;
    }
    setState(() { });
  }

  /// Function: _notifyGoalSet
  /// Description: Called after weekly goal is updated in the db. displays pop up dialog.
  /// Params: none **/
  Future _notifyGoalSet() async {
    BuildContext dialogContext;
    await showDialog(
        context: context,
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

  /// Function: setGoal
  /// Description: called when user clicks "set goal". Updates users weakly goal in the database.
  /// Params: none **/
  void setGoal(){
    int totalMin = (hour * 60) + minute;
    widget.userInfo.setWeeklyGoal(totalMin);
    _notifyGoalSet();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text(editGoalPageTitle, style: TextStyle(color: Colors.white, fontSize:24)),
          backgroundColor: Colors.orange[900],
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
                                  //print("button pressed");
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

  //widget that holds the grey boxes with hours and minutes in it
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
      //width: 140,
      height: 100,
      child: Text(stringTime, style: TextStyle(fontSize: 40.0))
    );
  }

}