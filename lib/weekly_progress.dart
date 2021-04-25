import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:testing_app/timelog.dart';
import 'package:testing_app/userData.dart';



class weeklyProgress extends StatefulWidget{
  weeklyProgress({Key key, this.user}) : super(key: key);
  //final String gsi;

  final userData user;
  @override
  _weeklyProgressState createState() => _weeklyProgressState();
}

class _weeklyProgressState extends State<weeklyProgress>{
  final dbRef = FirebaseDatabase.instance.reference().child("ParentUsers");
  final timelogRef = FirebaseDatabase.instance.reference().child("TimeLogs");
  List<Map<dynamic, dynamic>> lists = [];
  @override
  void initState() {
    super.initState();
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
            child: SingleChildScrollView(child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FutureBuilder(
                        future: timelogRef.orderByChild("UserID").equalTo(widget.user.userId).once(),
                        builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                          if (snapshot.hasData) {
                            lists.clear();
                            Map<dynamic, dynamic> values = snapshot.data.value;
                            if (values == null){
                              return Text("No entries in your Time Log");
                            }
                            else {
                              values.forEach((key, values) {
                                lists.add(values);
                              });
                            }
                            return new ListView.builder(
                                shrinkWrap: true,
                                itemCount: lists.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Card(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text("Time Length: " + lists[index]["TotalTime"]),
                                        Text("Date: " + lists[index]["LogDate"]),
                                        //Text("Notes: " + lists[index]["Notes"]),
                                      ],
                                    ),
                                  );
                                });
                          }
                          else{
                            return Text("No entries in your Time Log");
                          }
                          return CircularProgressIndicator();
                        })
                  ]
            ))
          )
    );
  }

}