import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:testing_app/edit_goal.dart';
import 'package:testing_app/timelog_manual_entry.dart';
import 'package:testing_app/weekly_progress.dart';

String formatTime(int milliseconds){
  var secs = milliseconds ~/ 1000;
  var hours = (secs ~/ 3600).toString().padLeft(2, '0');
  var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
  var seconds = (secs % 60).toString().padLeft(2, '0');
  return "$hours:$minutes:$seconds";
}

class timelog extends StatefulWidget{
  timelog({Key key, this.gsi}) : super(key: key);
  //final String gsi;
  final GoogleSignInAccount gsi;


  @override
  _timelogState createState() => _timelogState();
}

class _timelogState extends State<timelog>{

  //ADDING STUFF STARTING HERE
  Stopwatch _stopwatch;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
    //re render every 30ms
    _timer = new Timer.periodic(new Duration(milliseconds: 30), (timer) {
      setState(() { }); //re render the page
    });
  }

  @override
  void dispose(){
    _timer.cancel();
    super.dispose();
  }

  //function to handle if the timer starts or stops
  void handleStartStop(){
    if(_stopwatch.isRunning){
      _stopwatch.stop();
    }
    else{
      _stopwatch.start();
    }
    setState(() { }); //re render the page
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
                    child: Text(_stopwatch.isRunning ? 'STOP TIME' : 'START TIME', style: TextStyle(fontSize: 20.0)),),
                ),
                FlatButton(onPressed: () {
                    //navigate to new page here
                    print("manual entry pressed");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => timelogManualEntry()),
                    );
                  },
                    child: Text("Manual Entry", style: TextStyle(decoration: TextDecoration.underline))),
                SizedBox(height: 50),
                _progressText(),
                _progresssBar(),
                _goalButtons(context)
              ]
          ),
        )
      )
    );
  }
}

Widget _progressText(){
  return Container(
    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
    child: Center(
      child: Row(
        children: <Widget>[
          Expanded(child: Text(
            'Weekly Goal: (not set)',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          Spacer(),
          Expanded(child: Text(
            'Progress: 30 min',
            style: TextStyle(fontWeight: FontWeight.bold),
          ))
        ],
      ),
    ),
  );
}

Widget _progresssBar(){
  return Container(
    padding: const EdgeInsets.all(20.0),
    child: Center(
      child: Row(
        children: <Widget>[
          Expanded(child: LinearProgressIndicator(
              value: 0.3, //this will be pulled from users progress
              semanticsLabel: 'Progress towards goal',
              minHeight: 30
          ),),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text('30%'),
          ),

        ],
      ),
    ),
  );
}

/*Widget _startTimeButton() {
  return RaisedButton(
    color: Colors.white,
    splashColor: Colors.grey,
    onPressed: handleStartStop,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
    highlightElevation: 0,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              'START TIME',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          )
  );
}*/

Widget _goalButtons(BuildContext context) {
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
          print("edit goal pressed");
          Navigator.push(context, MaterialPageRoute(builder: (context) => editGoal()),
          );
        },
      ),
      new RaisedButton(
        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: Colors.black, width: 1.5),),
        child: new Text("WEEKLY PROGRESS"),
        onPressed: () {
          //navigate to new page here
          print("weekly progress pressed");
          Navigator.push(context, MaterialPageRoute(builder: (context) => weeklyProgress()),
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
// new Center(
// child: new ButtonBar(
// mainAxisSize: MainAxisSize.min,
// children: <Widget>[
// new RaisedButton(
// color: Colors.white,
// textColor: Colors.black,
// splashColor: Colors.orange[900],
// padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
// shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: Colors.black, width: 1.5),),
// child: new Text("Edit Goal"),
// onPressed: null,
// ),
// new RaisedButton(
// shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: Colors.black, width: 1.5),),
// child: new Text("Weekly Progress"),
// onPressed: null,
// color: Colors.white,
// textColor: Colors.black,
// splashColor: Colors.orange[900],
// padding: EdgeInsets.fromLTRB(10, 10, 10, 10)
// )
// ],
// )
// )