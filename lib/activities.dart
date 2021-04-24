import 'dart:convert';
// import 'dart:html';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing_app/activitiesData.dart';
import 'package:testing_app/activitiesResults.dart';
import 'package:testing_app/activityPage.dart';
import 'dialog.dart';

class activities extends StatefulWidget {
  final String activityName;
  activities({this.activityName});
  @override
  _activitiesState createState() => _activitiesState();
}

class _activitiesState extends State<activities> {
  final dbRef = FirebaseDatabase.instance.reference().child("Categories");
  var dbRefUser = FirebaseDatabase.instance.reference().child("ParentUsers");
  // var dbRefUser = firebase.database().ref("ParentUsers");
  // var user1 = dbRefUser.child("1");
  List<Map<dynamic, dynamic>> lists = [];
  final catArray = ["One", "Two", "Three", "Four"];

  //Adding:
  //final activitiesData data = activitiesData(categoryName: 'test', activityNames: ["test1", "test2"]);
  List<String> activitesArray = [];

  get activityName => this.activityName;


  @override
  Widget build(BuildContext context) {
    final _controllerSearchActivity = TextEditingController();
    _controllerSearchActivity.text = "Search for an activity...";
    // if (this.activityName == null){
    //   print("activity name is null");
    // }
    // else{
    //   print("this is the activity name: " + activityName);
    // }

    // List<Map<dynamic, dynamic>> lists2 = [];
    // print("this is the info from dbRef: " + dbRefUser.child("ActivityName").toString());
    // dbRefUser.once().then((DataSnapshot snapshot){
    //   Map<dynamic, dynamic> values = snapshot.value;
    //   values.forEach((key,values) {
    //     lists2.add(values);
    //   });
    // });
    // print("THIS IS THE VALUE OF ACTIVITYNAME FOR USER: " + lists2[][].toString());

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
                  lists.add(values);
                });

                return new Container(
                    child: new Column(
                  children: [
                      new Container(
                        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                        child: TextField(
                          // onChanged: (text){
                          //   //on change of value
                          //   // print("Search Text: ${_controllerSearchActivity.text}");
                          // },
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
                            // suffixIcon: IconButton(
                            //   // onPressed: _controllerSearchActivity.clear,
                            //   onPressed: (){
                            //     Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //             builder: (context) =>
                            //                 activitiesResults(
                            //                   data: _controllerSearchActivity,
                            //                 )));
                            //   },
                            //   icon: Icon(Icons.search_outlined),
                            // ),
                            //contentPadding: EdgeInsets.all(20.0),
                            hintText: _controllerSearchActivity.text,
                            hintStyle: TextStyle(color: Colors.orange[900]),
                          ),
                        ),
                      ),
                      new Container(
                        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                        alignment: Alignment(-1.0, 1.0),
                        child: new Text("Recent activity",
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                    ),
                      new Container(
                        height: 100,
                        width: 400,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.orange[900],
                            width: 4,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Center(
                          child: Text("No Recent Activity", style: TextStyle(fontFamily: 'Montserrat', fontSize: 18, fontWeight: FontWeight.w600)),
                        ),
                      ),
              //        new Card(
              //           shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(5.0),
              //           side: BorderSide(width: 3, color: Colors.orange[900]))
              //   //         child: InkWell(
              // //             onTap: (){
              // //               Navigator.push(context, MaterialPageRoute(builder: (context) => activityPage(
              // //                 activityName: activityName,
              // //               )));
              // //             },
              // //             child: ListTile(
              // //               title: Text(activityName, style: TextStyle(fontFamily: 'Montserrat', fontSize: 18, fontWeight: FontWeight.w600)),
              // //             )
              // // )
              //       ),
                      new Container(
                        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                        alignment: Alignment(-1.0, 1.0),
                        child: new Text("Select a category",
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                    ),
                    CustomScrollView(
                     slivers: <Widget>[
                      GridView.builder(
                        primary: false,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemCount: lists.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              child: Material(
                                  child: InkWell(
                                      onTap: () {
                                        if (activitesArray != null) {
                                          activitesArray.clear();
                                          print(
                                              "This is the activities array cleared:");
                                          print(activitesArray);
                                        }
                                        for(var i = 0; i < lists[index][catArray[index]].length-1; i++){
                                          print("activity:" +
                                              lists[index][catArray[index]][
                                              "Activity" +
                                                  i.toString()]);
                                          activitesArray.add(lists[index]
                                          [catArray[index]][
                                          "Activity" +
                                              i.toString()]);
                                        }
                                        final activitiesData data =
                                            activitiesData(
                                                categoryName: lists[index]
                                                        [catArray[index]]
                                                    ["CategoryName"],
                                                activityNames: activitesArray);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    activitiesResults(
                                                      data: data,
                                                    )));
                                      },
                                      child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              side: BorderSide(
                                                  width: 3,
                                                  color: Colors.orange[900])),
                                          child: Center(
                                              child: Text(
                                                  lists[index][catArray[index]]
                                                      ["CategoryName"],
                                                  style: TextStyle(
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 18,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight
                                                          .w600)))))));
                        }),
                      ]
                      )
                  ],
                ));
              }
              return CircularProgressIndicator();
            }));
  }
}




// while (actLength != 0) {
//   // print("activity:" +
//   //     lists[index][catArray[index]][
//   //         "Activity" +
//   //             actIndex.toString()]);
//   activitesArray.add(lists[index]
//           [catArray[index]][
//       "Activity" +
//           actIndex.toString()]);
//   actIndex++;
//   actLength--;
// }
// print("This is the activities array:");
// print(activitesArray);
// print(lists[index][catArray[index]]
//     ["CategoryName"]);