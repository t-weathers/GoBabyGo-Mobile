import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:testing_app/dialog.dart';
import 'package:testing_app/edit_goal.dart';
import 'package:testing_app/timelog_manual_entry.dart';
import 'package:testing_app/userData.dart';
import 'package:testing_app/weekly_progress.dart';


String formatTime(int milliseconds){
  var secs = milliseconds ~/ 1000;
  var hours = (secs ~/ 3600).toString().padLeft(2, '0');
  var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
  var seconds = (secs % 60).toString().padLeft(2, '0');
  return "$hours:$minutes:$seconds";
}

bool isDateInRange(String date){
  //Sunday - Saturday == each week range
  //print("INSIDE ISDATEINRANGE()");
  var parsedDate = DateTime.parse(date);
  //print("DATE: " + parsedDate.toString());

  DateTime now = DateTime.now();
  int currentDay = now.weekday;
  DateTime firstDayOfWeek = now.subtract(Duration(days: currentDay));
  DateTime lastDayOfWeek = firstDayOfWeek.add(Duration(days: 6));
  //print("first day of week: "+ firstDayOfWeek.toString());
  //print("last day of week: "+ lastDayOfWeek.toString());
  return parsedDate.isAfter(firstDayOfWeek) && parsedDate.isBefore(lastDayOfWeek);
}

int calculateTimeThisWeek(List weeklyRecordedTime){
  //DateTime total = 0;
  var prefix = '0000-01-01T';
  var elapsedMin = 0;
  //  loop through each time log
  weeklyRecordedTime.forEach((time) {
    var parsedDate = DateTime.parse(prefix + time.toString());  //turn string into datetime
    elapsedMin = elapsedMin + parsedDate.minute + (parsedDate.hour * 60); //add hours and min to elapsed min
  });
  //print("elapsed min: " + elapsedMin.toString());
  return elapsedMin;
}

class timelog extends StatefulWidget{
  timelog({Key key, this.gsi, this.signIn, this.parent, this.child}) : super(key: key);
  //final String gsi;
  final GoogleSignInAccount gsi;
  final GoogleSignIn signIn;
  final child;
  final parent;

  //widget.gsi.email
  @override
  _timelogState createState() => _timelogState();
}

class _timelogState extends State<timelog>{

  final dbRef = FirebaseDatabase.instance.reference().child("ParentUsers");
  final timelogRef = FirebaseDatabase.instance.reference().child("TimeLogs");
  String entryKey;
  String childName, parentName, email;
  int weeklyGoal, totalRecordedTime;
  List<Map<dynamic, dynamic>> userInfo = [];
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
    super.initState();

    populateInfo();
    _stopwatch = Stopwatch();
    //re render every 30ms
    _timer = new Timer.periodic(new Duration(milliseconds: 30), (timer) {
      setState(() { }); //re render the page
    });

    //every ten min this page will update info from the database. To often? or good? idk...
    // _updatetimer = new Timer.periodic(new Duration(minutes: 10), (updatetimer) {
    //   print("printing");
    //   populateInfo();
    // });

  }

  //FROM PROFILE.DART
  Future <void> populateInfo() async {

    //it warns to "indexOn": "Email" here. Maybe look into that?
    DataSnapshot data = await dbRef.orderByChild('Email').equalTo(
        widget.gsi.email).once();

    Map<dynamic, dynamic> values = data.value;

    userInfo.clear();
    values.forEach((key, value){
      userInfo.add(values);
      entryKey = key; //this is the user ID

    });
    //print("This is the list of all users: ???");
    //print(userInfo);

    childName = userInfo[0][entryKey]['ChildFirstName'];
    parentName = userInfo[0][entryKey]['FirstName'];
    weeklyGoal = userInfo[0][entryKey]['WeeklyGoal'];
    print("userID: " + entryKey);

    // Now we get all the time log associated with that user
    DataSnapshot timelogData = await timelogRef.orderByChild('UserID').equalTo(entryKey).once();
    Map<dynamic, dynamic> timelogvalues = timelogData.value;

    timelogInfo.clear();
    weeklyRecordedTime.clear();
    timelogvalues.forEach((key, value){
      timelogInfo.add(timelogvalues);
      //print("looping, values = " + timelogvalues.toString());
      //print("timelogInfo[0][key]['TotalTime']: "+ timelogInfo[0][key]['TotalTime']);
      //print("timelogInfo[0][key]['StartTime']: "+ timelogInfo[0][key]['StartTime']);
      var inWeeklyRange = isDateInRange(timelogInfo[0][key]['StartTime']);
      if(inWeeklyRange){
        //print("this date is within this week");
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

  //function to handle if the timer starts or stops
  void handleStartStop(){
    if(_stopwatch.isRunning){
      _stopwatch.stop();
    }
    else{
      _stopwatch.start();
      if(_stopwatch.elapsedMilliseconds == 0){
        startTime = new DateTime.now();
        //print("start time: " + startTime.toString());
      }
    }
    setState(() { }); //re render the page
  }

  Future _handleTimeSave() async {
    //DateTime now = new DateTime.now();
    //DateTime date = new DateTime(now.year, now.month, now.day);

    DateTime dateToday = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    String todaysDate = dateToday.month.toString()+dateToday.day.toString()+dateToday.year.toString();

    stopTime = new DateTime.now();

    await showDialog(
        context: context,
        child: new SimpleDialog(
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
                        onPressed: () => Navigator.pop(context, true),
                        child: Text('Continue', style: TextStyle(fontSize: 20.0)),),
            ),
            SizedBox(height: 30),
          ],
        ));


    //add new timelog entry to the database
    final dbRef = FirebaseDatabase.instance.reference().child("TimeLogs");

    var timeLogData = {
      'ActivityID': null,
      'EndTime': stopTime.toString(),
      'LogDate': todaysDate,
      'Notes': "none",
      'StartTime': startTime.toString(),
      'TotalTime': formatTime(_stopwatch.elapsedMilliseconds).toString(),
      'UserID': entryKey.toString()
    };
    //print("timeLogData: " + timeLogData.toString());

    //push new time log entry
    dbRef.push().set(timeLogData);
    populateInfo();
    _stopwatch.reset();

  }

  @override
  Widget build(BuildContext context){

    final user = new userData(entryKey, userInfo);

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
                    child: Text(_stopwatch.isRunning ? 'PAUSE TIME' : 'START TIME', style: TextStyle(fontSize: 20.0)),),
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
                      MaterialPageRoute(builder: (context) => timelogManualEntry(userId: entryKey,)),
                    );
                  },
                    child: Text("Manual Entry", style: TextStyle(decoration: TextDecoration.underline))),
                SizedBox(height: 50),
                _progressText(weeklyGoal, totalRecordedTime),
                _progresssBar(weeklyGoal, totalRecordedTime),
                _goalButtons(context, user)
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

Widget _goalButtons(BuildContext context, final user) {
  return ButtonBar(
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
          //navigate to new page here
          //print("edit goal pressed");
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => editGoal(user: user)
            ),
          );
        },
      ),
      new RaisedButton(
        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: Colors.black, width: 1.5),),
        child: new Text("WEEKLY PROGRESS"),
        onPressed: () {
          //navigate to new page here
          //print("weekly progress pressed");
          Navigator.push(context, MaterialPageRoute(builder: (context) => weeklyProgress(user:user)),
          );
        },
        color: Colors.white,
        textColor: Colors.black,
        splashColor: Colors.orange[900],
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10)
      )
    ]
  );
}