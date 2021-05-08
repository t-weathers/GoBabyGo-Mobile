import 'dart:convert';
// import 'dart:html';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing_app/activitiesData.dart';
import 'package:testing_app/activitiesResults.dart';
import 'package:testing_app/activityPage.dart';
import 'package:testing_app/user.dart';
import 'dialog.dart';


/// ACTIVITIES CLASS
/// * Description: this class displays the activity categories, recent activity and lets users search for activities
/// * Functions: handleCategoryClicked
/// **/
class activities extends StatefulWidget {
  final String activityName;
  user userInfo;

  activities({this.activityName, this.userInfo});
  @override
  _activitiesState createState() => _activitiesState();
}

class _activitiesState extends State<activities> {
  final dbRef = FirebaseDatabase.instance.reference().child("Categories");
  var dbRefUser = FirebaseDatabase.instance.reference().child("ParentUsers");
  List<Map<dynamic, dynamic>> lists = [];
  final catArray = ["One", "Two", "Three", "Four"];
  List<String> activitesArray = [];

  get activityName => this.activityName;

  /// Function: handleCategoryClicked
  /// Description: creates an activities data object with all the activities related to that category
  /// Params: index of the category selected **/
  activitiesData handleCategoryClicked(index){
    if (activitesArray != null) {
      activitesArray.clear();
    }
    for(var i = 0; i < lists[index].length-1; i++){
      activitesArray.add(lists[index]["Activity" + i.toString()]);
    }
    return activitiesData(categoryName: lists[index]["CategoryName"],  activityNames: activitesArray);
  }


  @override
  Widget build(BuildContext context) {
    final _controllerSearchActivity = TextEditingController();
    _controllerSearchActivity.text = "Search for an activity...";

    return Scaffold(
        appBar: AppBar(
          title: Text('Activities',
              style: TextStyle(color: Colors.white, fontSize: 24)),
          backgroundColor: Colors.orange[900],
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: dbRef.once(),
            builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
              if (snapshot.hasData) {
                lists.clear();
                Map<dynamic, dynamic> values = snapshot.data.value;
                values.forEach((key, value) {
                  lists.add(value);
                });

                return SingleChildScrollView(
                    child: new Column(
                      children: [
                        new Container(
                          padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                          child: TextField(
                            controller: _controllerSearchActivity,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(40.0),
                                ),
                              ),
                              suffixIcon: IconButton(
                                onPressed: _controllerSearchActivity.clear,
                                icon: Icon(Icons.search_rounded),
                              ),
                              hintText: _controllerSearchActivity.text,
                              hintStyle: TextStyle(color: Colors.orange[900]),
                            ),
                          ),
                        ),
                        new Container(
                          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          alignment: Alignment(-1.0, 1.0),
                          child: new Text("Recent activity",
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                          child: new Container(
                              child: Material(
                                  child: InkWell(
                                      onTap: () {
                                        if(widget.userInfo.recentActivity!="default: none so far") {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      activityPage(
                                                          activityName: widget
                                                              .userInfo
                                                              .recentActivity,
                                                          userInfo: widget
                                                              .userInfo
                                                      )
                                              ));
                                        }
                                      },
                                      child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5.0),
                                              side: BorderSide(
                                                  width: 3,
                                                  color: Colors.orange[900])),
                                          child: Center(
                                              child: Padding(padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 30.0),
                                                      child: Text(widget.userInfo.recentActivity=="default: none so far" ? "No Recent Activity" : widget.userInfo.recentActivity,
                                                          style: TextStyle(fontFamily: 'Montserrat', fontSize: 18, fontWeight: FontWeight.w600))),
                                          ))))
                          )
                        ),
                        new Container(
                          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          alignment: Alignment(-1.0, 1.0),
                          child: new Text("Categories",
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                        ),
                        new GridView.builder(
                            primary: false,
                            padding: EdgeInsets.all(10),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                            itemCount: lists.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return Container(
                                  child: Material(
                                    child: InkWell(
                                        onTap: () {
                                            final activitiesData data = handleCategoryClicked(index);
                                            Navigator.of(context).push(MaterialPageRoute(
                                              builder:
                                                  (context) => activitiesResults(data: data, userInfo: widget.userInfo),
                                            ),
                                            ).then((_) {
                                              setState(() { });
                                            });
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        side: BorderSide(
                                            width: 3,
                                            color: Colors.orange[900])),
                                        child: Center(
                                          child: Text(lists[index]["CategoryName"],
                                              style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600)
                                          )))))
                              );
                            }
                        )
                      ]
                    )
              );
              }
              return CircularProgressIndicator();
            })
    );
  }
}