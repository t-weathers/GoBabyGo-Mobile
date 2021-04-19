import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:math' as math;


class editGoal extends StatefulWidget{
  @override
  _editGoalState createState() => _editGoalState();
}

class _editGoalState extends State<editGoal>{

  int hour = 0; //this will eventuall need to be calculated from the user's goal
  int minute = 0;

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

  // Set the users weekly goal here
  void setGoal(){
    print("user wants to set goal as: " + hour.toString() + ":" + minute.toString());
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