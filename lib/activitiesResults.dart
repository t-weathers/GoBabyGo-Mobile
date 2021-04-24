
// import 'package:flutter/dart.html';
// import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing_app/activitiesData.dart';
import 'package:testing_app/activityPage.dart';
import 'package:testing_app/activities.dart';

class activitiesResults extends StatelessWidget{

  final activitiesData data;

  activitiesResults({this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${data.categoryName}', style: TextStyle(color: Colors.white, fontSize:24)),
          backgroundColor: Colors.orange[900],
          centerTitle: true,
      ),
      //body: Text('${data.activityNames[0]} ${data.activityNames[1]}, ')
        body: new Container(
        child: new Column(
          children: [
            new Container(
              padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
              alignment: Alignment(-1.0, 1.0),
              child: new Text("Select an activity", style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, fontSize: 20)),
            ),
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
                      Text("This is the activity that got tapped on: " + '${data.activityNames[index]}');
                      Navigator.push(context, MaterialPageRoute(builder: (context) => activityPage(
                          activityName: this.data.activityNames[index],
                      )));
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => activities(
                      //     activityName: this.data.activityNames[index],
                      // )));
                    },
                    child: ListTile(
                      title: Text('${data.activityNames[index]}', style: TextStyle(fontFamily: 'Montserrat', fontSize: 18, fontWeight: FontWeight.w600)),
                    )
                )
                );
              },
            )
          ],
        )
        )
        );
  }
}