import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:testing_app/dialog.dart';
import 'package:testing_app/edit_goal.dart';
import 'package:testing_app/timelog_manual_entry.dart';
import 'package:testing_app/user.dart';
import 'package:testing_app/userData.dart';
import 'package:testing_app/weekly_progress.dart';

/// Function: formatTime
/// Description: Function to format the timer to 00:00:00
/// Params: time in millisecond **/
String formatTime(int milliseconds){
  var secs = milliseconds ~/ 1000;
  var hours = (secs ~/ 3600).toString().padLeft(2, '0');
  var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
  var seconds = (secs % 60).toString().padLeft(2, '0');
  return "$hours:$minutes:$seconds";
}

/// Function: isDateInRange
/// Description: Function to check if the date is within this current week
/// Params: date in YYYY-MM-DD format **/
bool isDateInRange(String date){
  var parsedDate = DateTime.parse(date);
  DateTime now = DateTime.now();
  int currentDay = now.weekday;
  DateTime firstDayOfWeek = now.subtract(Duration(days: currentDay));
  DateTime lastDayOfWeek = firstDayOfWeek.add(Duration(days: 6));
  return parsedDate.isAfter(firstDayOfWeek) && parsedDate.isBefore(lastDayOfWeek);
}
/// Function: calcTime
/// Description: format totaltime into an int that can be added
/// Params: time **/
int calcTime(time){
  var prefix = '0000-01-01T';
  var parsedDate = DateTime.parse(prefix + time.toString());  //turn string into datetime
  time = parsedDate.minute + (parsedDate.hour * 60);
  return time;
}
/// Function: calculateTimeThisWeek
/// Description: Loops through the list of time to get the total time of all of them
/// Params: list of time **/
int calculateTimeThisWeek(List weeklyRecordedTime){
  var elapsedMin = 0;
  weeklyRecordedTime.forEach((time) {
    elapsedMin += calcTime(time);
  });
  return elapsedMin;
}

/// TIMELOG CLASS
/// Description: this class lets the user start a timer and save their time. It shows their progress,
///   and from here they can navigate to edit_goal and weekly_progress
/// Functions: initState(), getUsersTimelogs(), dispose(), handleStartStop()**/
class timelog extends StatefulWidget{
  user userInfo;
  final GoogleSignInAccount gsi;

  timelog({Key key, this.gsi, this.userInfo}) : super(key: key);

  @override
  _timelogState createState() => _timelogState();
}

class _timelogState extends State<timelog>{

  final dbRef = FirebaseDatabase.instance.reference().child("ParentUsers");
  final timelogRef = FirebaseDatabase.instance.reference().child("TimeLogs");
  String entryKey;
  String childName, parentName, email;
  int weeklyGoal, totalRecordedTime;
  var usersTimelogsThisWeek;
  List<Map<dynamic, dynamic>> userInfoList = [];
  List<Map<dynamic, dynamic>> timelogInfo = [];
  List weeklyRecordedTime = [];

  //Initialize timer variables
  Stopwatch _stopwatch;
  Timer _timer;
  Timer _updatetimer;

  DateTime startTime;
  DateTime stopTime;


  @override
  void initState() {
    getUsersTimelogs();
    _stopwatch = Stopwatch();
    //re render every 30ms
    _timer = new Timer.periodic(new Duration(milliseconds: 30), (timer) {
      setState(() { }); //re render the page
    });

    super.initState();
  }

  /// Function: getUsersTimeLogs
  /// Description: gets all the users timelogs for a given week from database
  /// Params: none **/
  Future <void> getUsersTimelogs() async {

    // Get all the time log associated with that user
    DataSnapshot timelogData = await timelogRef.orderByChild('UserID')
        .equalTo(widget.userInfo.userId).once();

    Map<dynamic, dynamic> timelogvalues = timelogData.value;

    timelogInfo.clear();
    weeklyRecordedTime.clear();
    timelogvalues.forEach((key, value){
      timelogInfo.add(timelogvalues);
      print("looping, values = " + timelogvalues.toString());
      print("timelogInfo[0][key]['TotalTime']: "+ timelogInfo[0][key]['TotalTime']);
      print("timelogInfo[0][key]['StartTime']: "+ timelogInfo[0][key]['StartTime']);
      var inWeeklyRange = isDateInRange(timelogInfo[0][key]['StartTime']);
      if(inWeeklyRange){
        print("this date is within this week");
        weeklyRecordedTime.add(timelogInfo[0][key]['TotalTime']);
      }
    });
    totalRecordedTime = calculateTimeThisWeek(weeklyRecordedTime);
  }

  @override
  void dispose(){
    _timer.cancel();
    _updatetimer.cancel();
    super.dispose();
  }

  /// Function: handleStartStop
  /// Description: handles if the timerr starts or stops
  /// Params: none **/
  void handleStartStop(){
    if(_stopwatch.isRunning){
      _stopwatch.stop();
    }
    else{
      _stopwatch.start();
      if(_stopwatch.elapsedMilliseconds == 0){
        startTime = new DateTime.now();
      }
    }
    setState(() { }); //re render the page
  }

  /// Function: _handleTimeSave
  /// Description: once the user clicks "save time" button, this is called.
  ///   This function does the following:
  ///   * pops up a dialoug
  ///   * updates the database
  ///   * updates total recorded time
  ///   * rerrenders the page
  ///   * restarts the stopwatch
  /// Params:  none **/
  Future _handleTimeSave() async {
    DateTime dateToday = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    String todaysDate = dateToday.month.toString()+dateToday.day.toString()+dateToday.year.toString();

    stopTime = new DateTime.now();
    BuildContext dialogContext;
    await showDialog(
        context: context,
        builder: (BuildContext context){
          dialogContext = context;
        return SimpleDialog(
          title: ListTile(
              title: const Text("TIME SAVED", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 25)),
              trailing: Icon(
                  Icons.check,
                  color: Colors.orange[900],
                  size: 34.0),
          ),
          titlePadding: EdgeInsets.fromLTRB(45.0, 30.0, 45.0, 0.0),
          contentPadding: EdgeInsets.fromLTRB(70.0, 10.0, 60.0, 0.0),
          children: <Widget>[
            Text(formatTime(_stopwatch.elapsedMilliseconds), style: TextStyle(fontSize: 45.0)),
            SizedBox(height: 30),
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


    //add new timelog entry to the database
    final dbRef = FirebaseDatabase.instance.reference().child("TimeLogs");

    var timeLogData = {
      'ActivityID': null,
      'EndTime': stopTime.toString(),
      'LogDate': todaysDate,
      'Notes': "none",
      'StartTime': startTime.toString(),
      'TotalTime': formatTime(_stopwatch.elapsedMilliseconds).toString(),
      'UserID': widget.userInfo.userId
    };

    //push new time log entry
    dbRef.push().set(timeLogData);
    totalRecordedTime += calcTime(formatTime(_stopwatch.elapsedMilliseconds)); //update the total recorded time
    setState(() { }); //re render the page
    _stopwatch.reset(); //reset the stopwatch

  }

  @override
  Widget build(BuildContext context){

    return new Scaffold(
      appBar: AppBar(
        title: Text('Time Log', style: TextStyle(color: Colors.white, fontSize:24)),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.orange[900],
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(formatTime(_stopwatch.elapsedMilliseconds), style: TextStyle(fontSize: 60.0)),
                SizedBox(height: 30),
                SizedBox(
                  width: 250.0,
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: handleStartStop,
                    child: Text(_stopwatch.isRunning ? 'PAUSE TIME' : 'START TIME',
                        style: TextStyle(fontSize: 20.0)),),
                ),
                SizedBox(height: 10),
                Visibility(
                  child: SizedBox(
                    width: 250.0,
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: _handleTimeSave,
                      color: Colors.black,
                      textColor: Colors.white,
                      child: Text('Save Time', style: TextStyle(fontSize: 20.0)),),
                  ),
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: (_stopwatch.isRunning || _stopwatch.elapsedMilliseconds==0) ? false : true,
                ),
                FlatButton(onPressed: () {
                    //navigate to new page here
                    //print("manual entry pressed");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => timelogManualEntry(userId: widget.userInfo.userId,)),
                    );
                  },
                    child: Text("Manual Entry", style: TextStyle(decoration: TextDecoration.underline))),
                SizedBox(height: 50),
                _progressText(widget.userInfo.weeklyGoal, totalRecordedTime),
                _progresssBar(widget.userInfo.weeklyGoal, totalRecordedTime),
                ButtonBar(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new RaisedButton(
                        color: Colors.white,
                        textColor: Colors.black,
                        splashColor: Colors.orange[900],
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: Colors.black, width: 1.5),),
                        child: new Text("EDIT GOAL"),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder:
                                (context) => editGoal(userInfo: widget.userInfo),
                          ),
                          ).then((_) {
                            setState(() { });
                          });
                        },
                      ),
                      new RaisedButton(
                          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: Colors.black, width: 1.5),),
                          child: new Text(" TIMELOGS "),
                          onPressed: () {
                            //navigate to new page here
                            //print("weekly progress pressed");
                            Navigator.push(context, MaterialPageRoute(builder: (context) => weeklyProgress(userInfo: widget.userInfo)),);
                          },
                          color: Colors.white,
                          textColor: Colors.black,
                          splashColor: Colors.orange[900],
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10)
                      )
                    ]
                ),
              ]
          ),
        )
      )
    );
  }
}

Widget _progressText(int weeklyGoal, int totalRecordedTime){
  var notSet = false;
  if(weeklyGoal == 0 || weeklyGoal == null){
    notSet = true;
  }

  if(totalRecordedTime==null){
    totalRecordedTime = 0;
  }

  return Container(
    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
    child: Center(
      child: Row(
        children: <Widget>[
          Expanded(child: Text(
            'Weekly Goal: ' + (notSet ? '(Not Set)' : weeklyGoal.toString() + ' min'),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          )),
          Expanded(child: Padding(
              padding: EdgeInsets.fromLTRB(60, 0, 10, 0),
              child: Text('Progress: ' + totalRecordedTime.toString() + ' min',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          )))
        ],
      ),
    ),
  );
}

Widget _progresssBar(int weeklyGoal, int totalRecordedTime){

  double ratio = 0.0;
  double percent = 0.0;

  if(weeklyGoal != null && totalRecordedTime !=null){
    ratio = totalRecordedTime/weeklyGoal;
    percent = ratio * 100;
  }
  return Container(
    padding: const EdgeInsets.all(20.0),
    child: Center(
      child: Row(
        children: <Widget>[
          Expanded(child: LinearProgressIndicator(
              value: ratio, //this will be pulled from users progress
              semanticsLabel: 'Progress towards goal',
              minHeight: 30
          ),),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(double.parse((percent).toStringAsFixed(2)).toString()+"%"),
          ),

        ],
      ),
    ),
  );
}