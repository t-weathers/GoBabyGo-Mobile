import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:testing_app/timelog_manual_entry.dart';

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
        backgroundColor: Colors.orange[900],
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(formatTime(_stopwatch.elapsedMilliseconds), style: TextStyle(fontSize: 48.0)),
                SizedBox(height: 50),
                ElevatedButton(onPressed: handleStartStop,
                    child: Text(_stopwatch.isRunning ? 'Stop Time' : 'Start Time')),
                FlatButton(onPressed: () {
                    //navigate to new page here
                    print("manual entry prressed");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => timelogManualEntry()),
                    );
                  },
                    child: Text("Manual Entry", style: TextStyle(decoration: TextDecoration.underline))),
                SizedBox(height: 100),
                _goalButtons()
              ]
          ),
        )
      )
    );
  }
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

Widget _goalButtons() {
  return ButtonBar(
    mainAxisSize: MainAxisSize.min,
      children: <Widget>[
      new RaisedButton(
        color: Colors.white,
        textColor: Colors.black,
        splashColor: Colors.orange[900],
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: Colors.black, width: 1.5),),
        child: new Text("Edit Goal"),
        onPressed: null,
      ),
      new RaisedButton(
        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: Colors.black, width: 1.5),),
        child: new Text("Weekly Progress"),
        onPressed: null,
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