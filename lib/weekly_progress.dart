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
  TextEditingController _c;
  List<Map<dynamic, dynamic>> lists = [];
  @override
  void initState() {
    super.initState();
    _c = new TextEditingController();
  }

  Future _editNote(index) async{

    await showDialog(
      context: context,
        child: new SimpleDialog(
          title: ListTile(
            title: const Text("EDIT NOTE", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 15)),
          ),
          titlePadding: EdgeInsets.fromLTRB(5.0, 5.0, 45.0, 0.0),
          contentPadding: EdgeInsets.fromLTRB(70.0, 0.0, 60.0, 0.0),
          children: <Widget>[
            SizedBox(
                height: 100,

                child: new TextField(
                  controller: _c,
                  autofocus: true,
                  decoration: new InputDecoration(
                    hintText: lists[index]["Notes"],
                  ),
                )
            ),
            SizedBox(
              height: 10,
              child: ElevatedButton(
                onPressed: () {
                  print(_c.text);
                  // TODO push new saved note to database
                  Navigator.pop(context, true);
                  // TODO create confirmation note
                },
                child: Text('Save', style: TextStyle(fontSize: 10.0)),),
            ),
            SizedBox(
              height: 10,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text('Cancel', style: TextStyle(fontSize: 10.0)),),
            ),
            SizedBox(height: 20),
          ],
        )
    );

    //update data with _c.text

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
                                padding: const EdgeInsets.fromLTRB(10,10,10,10),
                                itemCount: lists.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Column(
                                        children: <Widget>[
                                          Text("Time Length: " + lists[index]["TotalTime"]),
                                          Text("Date: " + lists[index]["LogDate"]),
                                          IconButton(
                                            icon: const Icon(Icons.note_add),
                                            tooltip: 'Edit Note',
                                            color: Colors.orange[900],
                                            iconSize: 34.0,
                                            onPressed: (){
                                              //when the icon is pressed
                                              print("pressed edit note " + index.toString());
                                              _editNote(index);
                                            },
                                          ),
                                          Text("Notes: " + lists[index]["Notes"]),
                                          //Text("Notes: " + lists[index]["Notes"]),
                                        ],
                                      ),
                                    )
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