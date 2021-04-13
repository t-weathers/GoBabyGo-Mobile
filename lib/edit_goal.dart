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
    if(minute==60){
      minute=0;
    }
    else{
      minute++;
    }
    setState(() { });
  }

  void handleDecreaseMin(){
    if(minute==0){
      minute=60;
    }
    else{
      minute--;
    }
    setState(() { });
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
                  RaisedButton(onPressed: () {
                    print("set goal button pressed");
                  },
                      color: Colors.orange[900],
                      textColor: Colors.black,
                      padding: EdgeInsets.fromLTRB(40, 12, 40, 12),
                      splashColor: Colors.orange[900],
                    child: Text("SET GOAL"))
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
                child: Center(
                          child: Column(
                          children: <Widget>[
                            Text('Hours', style: TextStyle(fontSize: 25.0)),
                            SizedBox(height: 20),
                            Transform.rotate(angle: 90 * math.pi / 180,
                              child: IconButton(
                                icon: const Icon(Icons.arrow_back_ios, size: 50),
                                tooltip: 'Increase Hours',
                                onPressed: () {
                                  print("button pressed");
                                  handleIncreaseHour();
                                },
                              ),
                            ),
                            _timeBox(hour),
                            Transform.rotate(angle: 270 * math.pi / 180,
                              child: IconButton(
                                icon: const Icon(Icons.arrow_back_ios, size: 50),
                                tooltip: 'Decrease Hours',
                                onPressed: () {
                                  print("button pressed");
                                  handleDecreaseHour();
                                },
                              ),
                            )

            ]))),
            Expanded(
                child: Center(
                    child: Column(
                        children: <Widget>[
                          Text('Minutes', style: TextStyle(fontSize: 25.0)),
                          SizedBox(height: 20),
                          Transform.rotate(angle: 90 * math.pi / 180,
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back_ios, size: 50),
                              tooltip: 'Increase minutes',
                              onPressed: () {
                                print("button pressed");
                                handleIncreaseMin();
                              },
                            ),
                          ),
                          _timeBox(minute),
                          Transform.rotate(angle: 270 * math.pi / 180,
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back_ios, size: 50),
                              tooltip: 'Decrease Minutes',
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

  Widget _timeBox(time){
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12)
      ),
      padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
      margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
      child: Text(time.toString(), style: TextStyle(fontSize: 60.0))
    );
  }

}