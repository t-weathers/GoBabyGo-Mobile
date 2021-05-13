import 'dart:convert';
// import 'dart:html';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing_app/activitiesData.dart';
import 'package:testing_app/activitiesResults.dart';
import 'package:testing_app/activitiesSearchResults.dart';
import 'package:testing_app/activityPage.dart';
import 'package:testing_app/user.dart';
import 'dialog.dart';


/// ACTIVITIES CLASS
/// * Description: this class displays the activity categories, recent activity and lets users search for activities
/// * Functions: handleCategoryClicked, getAllActivities, filterSearchTerms
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
  final dbRefAct = FirebaseDatabase.instance.reference().child("Activities");
  List<Map<dynamic, dynamic>> lists = [];
  final catArray = ["One", "Two", "Three", "Four"];
  List<String> activitesArray = [];

  TextEditingController _filter = TextEditingController(); // controls the text label we use as a search bar
  List activities = new List(); //activities we get from database as a result

  get activityName => this.activityName;

  /// initialize state
  @override
  void initState(){
    getAllActivities();
    super.initState();
  }

  /// Function: getAllActivities
  /// Description: calls firebase for all activity names to be searched. Called in initialize state
  /// Params: none **/
  Future <void> getAllActivities() async {
    // Get all the time log associated with that user
    DataSnapshot allActivitiesData = await dbRefAct.once();
    Map<dynamic, dynamic> activityValues = allActivitiesData.value;
    List tempList = new List();

    //add each activity name to the list
    activityValues.forEach((key, value) {
      tempList.add(value["ActivityName"]);
    });

    setState(() {
      activities = tempList; // set activities equal to the list of names
    });
  }

  /// Function: filterSearchTerms
  /// Description: returns a list of activities that contain the string the user entered
  /// Params: String filter **/
  List filterSearchTerms(filter){
    if(filter != null && filter.isNotEmpty){
      return activities.where((term) => term.toLowerCase().contains(filter.toLowerCase())).toList();
    }
    return [];
  }

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

  /// clean up
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _filter.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

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
                            controller: _filter,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(40.0),
                                ),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  if(_filter.text.isNotEmpty){
                                  List searchResults = filterSearchTerms(_filter.text);
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder:
                                        (context) => activitiesSearchResults(activities: searchResults, userInfo: widget.userInfo),
                                  ),
                                  ).then((_) {
                                    setState(() { });
                                  });}
                                  },
                                icon: Icon(Icons.search_rounded),
                                padding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                              ),
                              hintText: "Search Activities...",
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