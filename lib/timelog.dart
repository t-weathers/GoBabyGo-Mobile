import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class timelog extends StatefulWidget{
  timelog({Key key, this.gsi}) : super(key: key);
  //final String gsi;
  final GoogleSignInAccount gsi;


  @override
  _timelogState createState() => _timelogState();
}

class _timelogState extends State<timelog>{

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
                SizedBox(height: 50),
                _startTimeButton(),
                SizedBox(height: 100),
                _goalButtons()
              ]
          ),
        )
      )
    );
  }
}

Widget _startTimeButton() {
  return RaisedButton(
    color: Colors.white,
    splashColor: Colors.grey,
    onPressed: null,
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
}
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