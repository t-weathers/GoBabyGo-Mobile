
// import 'package:flutter/dart.html';
// import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing_app/activitiesData.dart';
import 'package:testing_app/activityPage.dart';
import 'package:testing_app/user.dart';

/// ACTIVITIES RESULTS CLASS
/// * Description: this class displays the activities returned from a category selection on activities.dart
/// * Functions: none
/// **/

class activitiesResults extends StatelessWidget{

  final activitiesData data;
  user userInfo;

  activitiesResults({this.data, this.userInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${data.categoryName}', style: TextStyle(color: Colors.white, fontSize:24)),
          backgroundColor: Colors.orange[900],
          centerTitle: true,
      ),
        //allows the page to be scrolled
        body: new SingleChildScrollView(
        child: new Column(
          children: [
            new Container(
              padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
              alignment: Alignment(-1.0, 1.0),
              child: new Text("Select an activity", style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, fontSize: 18)),
            ),
            //displays all of the activities in a listview
            ListView.builder(
              padding: const EdgeInsets.all(8),
              shrinkWrap: true,
              itemCount: data.activityNames.length,
              itemBuilder: (BuildContext context, int index){
                return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(width: 3, color: Colors.orange[900])),
                  child: InkWell(
                    onTap: (){
                      //after an activity has been selected, push the activity to the activityPage along with the user's information
                      Navigator.push(context, MaterialPageRoute(builder: (context) => activityPage(
                          activityName: this.data.activityNames[index],
                          userInfo: userInfo
                      )
                      ));
                    },
                      //a single activity
                    child: ListTile(
                      title: Text('${data.activityNames[index]}', style: TextStyle(fontFamily: 'Montserrat', fontSize: 15)),
                    )
                )
                );
              },
            )
          ],
        )
        ),
        );
  }
}