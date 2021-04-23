import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class timelogManualEntry extends StatefulWidget{
  timelogManualEntry({Key key, this.userId}) : super(key: key);
  final String userId;
  @override
  _timeLogManualEntryState createState() => _timeLogManualEntryState();
}

class _timeLogManualEntryState extends State<timelogManualEntry>{


  TimeOfDay startTime = null;
  TimeOfDay endTime = null;
  DateTime date = null;

  String dateString = "";
  String startString = "";
  String endString = "";


 /* Widget build(BuildContext context) => RaisedButton(
      child: Text(widget.userId),
      onPressed: () async{
        final selectedDate = await pickDate(context);
        if (selectedDate == null) return;


        print(selectedDate);

        final selectedStart = await pickTime(context);
        print(selectedStart);

      });
*/
  Future <DateTime> pickDate(BuildContext context) => showDatePicker(
      context: context, initialDate: DateTime.now().add(Duration(seconds: 1)), firstDate: DateTime(2021), lastDate: DateTime.now(),

  );

  Future <TimeOfDay> pickTime(BuildContext context){
    final now = DateTime.now();
    return showTimePicker(context: context, initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
    );

  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Time Log', style: TextStyle(color: Colors.white, fontSize:24)),
        backgroundColor: Colors.orange[900],
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 250.0,
                  height: 50.0,
                  child: ElevatedButton(
                      onPressed: () async{

                        final d = await pickDate(context);
                        if (d!=null) {
                          date = d;
                          dateString = date.month.toString() + "/" +
                              date.day.toString() + "/" + date.year.toString();
                        }


                        print(date);
                        print(dateString);



                      },
                    child: Text("Date", style: TextStyle(fontSize: 20.0))),
                ),
                Visibility(
                  child: SizedBox(
                    width: 250.0,
                    height: 25.0,
                    child: Text(dateString, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),)
                  ),
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: (date != null) ? true : false,
                ),
                SizedBox(height: 75),
                SizedBox(
                  width: 250.0,
                  height: 50.0,
                  child: ElevatedButton(
                      onPressed: () async{


                        final st = await pickTime(context);
                        if (st!=null){
                          startTime = st;
                          startString = startTime.hour.toString() + ":" + startTime.minute.toString();
                          print(startString);
                        }
                        print(startTime);

                      },
                      child: Text("Start Time", style: TextStyle(fontSize: 20.0))),
                ),
                SizedBox(height: 75),
                SizedBox(
                  width: 250.0,
                  height: 50.0,
                  child: ElevatedButton(
                      onPressed: () async{

                        final et = await pickTime(context);
                        if (et!=null) {

                          endTime = et;
                          endString = endTime.hour.toString() + ":" + endTime.minute.toString();
                        }
                        print(endTime);

                      },
                      child: Text("End Time", style: TextStyle(fontSize: 20.0))),
                ),
                SizedBox(height: 75),
                SizedBox(
                  width: 250.0,
                  height: 50.0,
                  child: RaisedButton(
                      onPressed: () async{
                        if (endTime != null && startTime != null && date != null){
                          final dbRef = FirebaseDatabase.instance.reference().child("TimeLogs");
                          String logdate = date.month.toString()+date.day.toString() + date.year.toString();
                          int totTimeMinute = 0;
                          if (startTime.minute >= endTime.minute)
                            totTimeMinute = startTime.minute - endTime.minute;
                          else
                            totTimeMinute = 60 + startTime.minute - endTime.minute;

                          String totTime = (startTime.hour - endTime.hour).toString() + ":" + totTimeMinute.toString() + ":" + "00";
                          String k = widget.userId;

                          String endT = date.year.toString() + "-" + date.month.toString() + "-" + date.day.toString() + " " + endTime.hour.toString() + ":" + endTime.minute.toString() + ":" + "00";
                          String startT = date.year.toString() + "-" + date.month.toString() + "-" + date.day.toString() + " " + startTime.hour.toString() + ":" + startTime.minute.toString() + ":" + "00";
                          print("We can push to database");

                          dbRef.push().set({
                            'ActivityID': null,
                            'EndTime': endT,
                            'LogDate': logdate,
                            'Notes': null,
                            'StartTime': startT,
                            'TotalTime': totTime,
                            'UserID': k
                          } );

                          //do back navigation
                          Navigator.pop(context);
                        }
                      },
                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                      child: Text("Save Manual Entry", style: TextStyle(fontSize: 20.0))),
                ),


                ]

          ),
        ),
      )
    );
  }
  
}