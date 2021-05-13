import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing_app/activitiesData.dart';
import 'package:testing_app/user.dart';
import 'timelog.dart';

/*String formatTime(int milliseconds){
  var secs = milliseconds ~/ 1000;
  var hours = (secs ~/ 3600).toString().padLeft(2, '0');
  var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
  var seconds = (secs % 60).toString().padLeft(2, '0');
  return "$hours:$minutes:$seconds";
}*/

/// ACTIVITIES PAGE CLASS
/// * Description: Displays a specific activity. Displays it's description, disclaimer, steps, photos, and name
/// * Functions: none
/// **/
class activityPage extends StatefulWidget{

  final String activityName;
  user userInfo;
  activityPage( { this.activityName, this.userInfo } );

  @override
  _activityPage createState() => _activityPage();

}

class _activityPage extends State<activityPage> {

  List stepsArray = []; // will eventually contain Strings of keys for every step
  List imagesArray = []; // will eventually contain Strings of keys for every image
  List<Map<dynamic, dynamic>> activityContentList = [];
  List<Map<dynamic, dynamic>> activityInfoList = [];
  final dbRef = FirebaseDatabase.instance.reference().child("Activities");
  int stepsIndex;
  int stepLen = 0;
  int imageNum = 0; //contains the number of images
  String disclaimerMsg, description;
  Future myFuture;

  /// when page is created - show disclaimer message.
  @override
  void initState() {
    widget.userInfo.setRecentActivity(widget.activityName);
    super.initState();

    /// Gets disclaimer message and pops up disclaimer message
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      DataSnapshot data = await dbRef.orderByChild("ActivityName").equalTo(widget.activityName).once();

      activityInfoList.clear();
      Map<dynamic, dynamic> values = data.value;
      values.forEach((key, value){
        activityInfoList.add(value);
      });
      description = activityInfoList[0]["Description"];
      if(activityInfoList[0]["Disclaimer"] != null && activityInfoList[0]["Disclaimer"] != ""){
        disclaimerMsg = activityInfoList[0]["Disclaimer"];
      }
      else{
        disclaimerMsg = "No disclaimer message for this activity.";
      }

      await showDialog<String>(
        context: context,
        builder: (BuildContext context) => new AlertDialog(
          title: new Text("Disclaimer"),
          content: new Text(disclaimerMsg),
          actions: <Widget>[
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.activityName, style: TextStyle(color: Colors.white, fontSize:24)),
          backgroundColor: Colors.orange[900],
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: dbRef.orderByChild("ActivityName").equalTo(widget.activityName).once(),
            builder: (context, AsyncSnapshot<DataSnapshot> snapshot){

            if (snapshot.hasData){
              activityContentList.clear();
              Map<dynamic, dynamic> values = snapshot.data.value;
              values.forEach((key, values){
                activityContentList.add(values);
              });

              //populate stepsArray and figure out how many steps there are
              if(activityContentList[0]["Steps"] != null){
                stepLen = activityContentList[0]["Steps"].length;
                activityContentList[0]["Steps"].forEach((key, value){
                  stepsArray.add(key);
                });
              }

              //figure out if there are any images to display and if so, how many
              if(activityContentList[0]["Images"] != null){
                activityContentList[0]["Images"].forEach((key, value) {
                  imagesArray.add(key);
                  if(value.toLowerCase() == "nothing to show here" || value.toLowerCase() == "nothing to see here"){
                    imageNum = 0;
                  }
                  else{
                    imageNum++;
                  }
                });
              }
              return
                SingleChildScrollView(
                    child: Column(

                    children: <Widget>[
                      SizedBox(height: 10),
                      Container(
                          padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                          child: Text(activityContentList[0]["Description"],
                              style: TextStyle(fontFamily: 'Montserrat', fontSize: 15, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic))
                      ),
                      Divider(
                          color: Colors.black
                      ),
                      for (var stepsIndex = 0; stepsIndex < stepLen ; stepsIndex++)
                        Container(
                            padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                            child: Column(
                              children: <Widget>[
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Step " + (stepsIndex + 1).toString(), style: TextStyle(fontFamily: 'Montserrat', fontSize: 16, fontWeight: FontWeight.w700))
                                ),
                                SizedBox(height: 10),
                                Text(activityContentList[0]["Steps"][stepsArray[stepsIndex]])
                              ],
                            )
                        ),
                      SizedBox(height: 20),
                      for (var imageIndex = 0; imageIndex < imageNum; imageIndex++)
                        Container(
                          child: Padding(
                              padding: EdgeInsets.all(30),
                              child: Image.network(activityContentList[0]["Images"][imagesArray[imageIndex]].toString(),fit: BoxFit.cover,
                            loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null ?
                                  loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                      : null,
                                ),
                              );
                            },
                          )),
                        )
                    ],
                  ),
              );
          }
          return CircularProgressIndicator();
        }
      )
    );
  }
}