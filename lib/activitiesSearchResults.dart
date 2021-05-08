import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing_app/activitiesData.dart';
import 'package:testing_app/activityPage.dart';
import 'package:testing_app/user.dart';

/// ACTIVITIES SEARCH RESULTS CLASS
/// * Description: this class displays the activities that match the users search
/// * Functions: none
/// **/
class activitiesSearchResults extends StatelessWidget {

  final List activities;
  user userInfo;

  activitiesSearchResults({this.activities, this.userInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results', style: TextStyle(color: Colors.white, fontSize:24)),
        backgroundColor: Colors.orange[900],
        centerTitle: true,
      ),
      body: new SingleChildScrollView(
          child: new Column(
            children: [
              new Container(
                padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                alignment: Alignment(-1.0, 1.0),
                child: new Text(activities.isEmpty ? "No results found" : "Select an activity", style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, fontSize: 18)),
              ),
              ListView.builder(
                padding: const EdgeInsets.all(8),
                shrinkWrap: true,
                itemCount: activities.length,
                itemBuilder: (BuildContext context, int index){
                  return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: BorderSide(width: 3, color: Colors.orange[900])),
                      child: InkWell(
                          onTap: (){
                            print("This is the activity that got tapped on: " + '${activities[index]}');
                            Text("This is the activity that got tapped on: " + '${activities[index]}');
                            Navigator.push(context, MaterialPageRoute(builder: (context) => activityPage(
                                activityName: activities[index],
                                userInfo: userInfo
                            )
                            ));
                          },
                          child: ListTile(
                            title: Text('${activities[index]}', style: TextStyle(fontFamily: 'Montserrat', fontSize: 15)),
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