import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart' as cf;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:testing_app/timelog.dart';
import 'package:testing_app/user.dart';
import 'package:testing_app/userData.dart';

class TimeLogEntry{
  String key;
  String EndTime;
  String StartTime;
  String date;
  String notes;
  String UserId;
  String totalTime;

  TimeLogEntry(this.EndTime,this.StartTime,this.date,this.notes,this.UserId,this.totalTime);

  TimeLogEntry.fromSnapshot(DataSnapshot snapshot)  :
    key = snapshot.key,
    EndTime = snapshot.value["EndTime"],
    StartTime = snapshot.value["StartTime"],
    date = snapshot.value["LogDate"],
    notes = snapshot.value["Notes"],
    UserId = snapshot.value["UserID"],
    totalTime = snapshot.value["TotalTime"];

  toJson() {
    return {
      "EndTime": EndTime,
      "LogDate": date,
      "Notes": notes,
      "StartTime": StartTime,
      "TotalTime": totalTime,
      "UserID": UserId,
    };
  }
}

class weeklyProgress extends StatefulWidget{
  weeklyProgress({Key key, this.userInfo}) : super(key: key);
  //final String gsi;

  final user userInfo;
  @override
  _weeklyProgressState createState() => _weeklyProgressState();
}

class _weeklyProgressState extends State<weeklyProgress>{
  final dbRef = FirebaseDatabase.instance.reference().child("ParentUsers");
  final timelogRef = FirebaseDatabase.instance;
  TextEditingController _c;
  List<TimeLogEntry> timelogEntries = [];
  StreamSubscription<Event> _onTimeLogChangedSubscription;
  StreamSubscription<Event> _onTimeLogAddedSubscription;
  Query _timelogRef;

  @override
  void initState() {
    super.initState();
    _c = new TextEditingController();
    _timelogRef = timelogRef.reference().child("TimeLogs").orderByChild("UserID").equalTo(widget.userInfo.userId);

    _onTimeLogAddedSubscription = _timelogRef.onChildAdded.listen(_onTimeLogEntryAdded);
    _onTimeLogChangedSubscription = _timelogRef.onChildChanged.listen(_onEntryChanged);
    _sortTimeLogEntries();
  }

  @override
  void dispose() {
    _onTimeLogAddedSubscription.cancel();
    _onTimeLogChangedSubscription.cancel();
    super.dispose();
  }

  _sortTimeLogEntries(){
    //so long as the list is not empty, sort it in reverse order
    if (timelogEntries.isNotEmpty) {
      timelogEntries.sort((a, b) => b.StartTime.compareTo(a.StartTime));
    }
  }


  _updateTimeLogEntry(TimeLogEntry entry) {
    //Toggle completed
    if (entry != null) {
      _timelogRef.reference().child(entry.key).set(entry.toJson());
    }
  }


  Future _editNote(hint,index) async{
    BuildContext dialogContext;
    await showDialog(
      context: context,
        builder: (BuildContext context)
    {
      dialogContext = context;
      return SimpleDialog(
        title: ListTile(
          title: const Text("EDIT NOTE", style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 15)),
        ),
        titlePadding: EdgeInsets.fromLTRB(5.0, 5.0, 45.0, 0.0),
        contentPadding: EdgeInsets.fromLTRB(70.0, 0.0, 60.0, 0.0),
        children: <Widget>[
          SizedBox(
              height: 60,

              child: new TextField(
                controller: _c,
                autofocus: true,
                decoration: new InputDecoration(
                  hintText: hint,
                ),
              )
          ),
          SizedBox(
            height: 25,
            child: ElevatedButton(
              onPressed: () {
                print(_c.text);
                TimeLogEntry newT = new TimeLogEntry(
                    timelogEntries[index].EndTime,
                    timelogEntries[index].StartTime, timelogEntries[index].date,
                    _c.text.toString(), timelogEntries[index].UserId,
                    timelogEntries[index].totalTime);
                newT.key = timelogEntries[index].key;
                _updateTimeLogEntry(newT);
                Navigator.pop(dialogContext);
              },
              child: Text('Save', style: TextStyle(fontSize: 20.0)),),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 25,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: Text('Cancel', style: TextStyle(fontSize: 20.0)),),

          ),
          SizedBox(height: 20),
        ],
      );
    },
    );
    //update data with _c.text

  }

  _onEntryChanged(Event event) {
    var oldEntry = timelogEntries.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    setState(() {
      timelogEntries[timelogEntries.indexOf(oldEntry)] = TimeLogEntry.fromSnapshot(event.snapshot);
      _sortTimeLogEntries();
    });
  }

  _onTimeLogEntryAdded(Event event) {
    setState(() {
      timelogEntries.add(TimeLogEntry.fromSnapshot(event.snapshot));
      _sortTimeLogEntries();
    });
  }

  Widget _showEntries() {
    if (timelogEntries.length > 0){
      return ListView.builder(
        shrinkWrap: true,
        itemCount: timelogEntries.length,
        itemBuilder: (BuildContext context, int index){
          //String id = timelogEntries[index].key;
          //String EndTime = timelogEntries[index].EndTime;
          String StartTime = timelogEntries[index].StartTime;
          //String date = timelogEntries[index].date;
          String notes = timelogEntries[index].notes;
          //String userid = timelogEntries[index].UserId;
          String totalTime = timelogEntries[index].totalTime;
          DateTime logDate = DateTime.parse(StartTime);
          String logdateString = logDate.month.toString() + "/" + logDate.day.toString() + "/" + logDate.year.toString();


          //DateTime datenew = DateTime.parse(EndTime);
          return Card(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child:Text(
                            logdateString,

                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Text(
                              totalTime
                        ),
                      ],
                    ),

                    Row(
                      children: <Widget>[
                        Expanded(
                          child:Container(
                            width: 250,
                            child:Text("Notes: " + notes),
                          ),
                        ),

                       IconButton(
                        icon: const Icon(Icons.note_add),
                        tooltip: 'Edit Note',
                        color: Colors.orange[900],
                        iconSize: 34.0,
                        onPressed: (){
                          //when the icon is pressed
                          print("pressed edit note " + index.toString());
                          //update the timelog note
                          _editNote(timelogEntries[index].notes,index);
                          print("back to updateTimeLogEntry");
                          _updateTimeLogEntry(timelogEntries[index]);
                          },
                        ),
                      ]
                    ),
                    //Text("Notes: " + lists[index]["Notes"]),
                  ],
                ),
              )
          );
        },
      );
    }
    else{
      return Text("Try Adding some timelog entries");
    }
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('Weekly Progress', style: TextStyle(color: Colors.white, fontSize:24)),
          backgroundColor: Colors.orange[900],
          //automaticallyImplyLeading: false,
          centerTitle: true,
        ),
          body: Center(
            child: SingleChildScrollView(
                child: _showEntries()
            )
          )
    );
  }

}