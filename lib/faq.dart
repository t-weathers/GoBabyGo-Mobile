import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:math' as math;



import 'dialog.dart';

class faq extends StatefulWidget{
  @override
  _faqState createState() => _faqState();
}

/// FAQ CLASS
/// Description:The FAQ page uses future builder to dynamically pull all FAQs from firebase.
/// By dynamically grabbing these, we populated the UI with text boxes that are generated from
/// firebase. When the text box is clicked, an alert dialog shows up, indicating the answer to the FAQ.
/// Then, the user must click OK to return from dialog box.
/// Functions: **/
class _faqState extends State<faq>{

  List<Map<dynamic, dynamic>> faqInfoList = [];
  dialog myDialog = new dialog();
  List keyArray = [];

  @override
  Widget build(BuildContext context){

    return new Scaffold(
      appBar: AppBar(
        title: Text('FAQ', style: TextStyle(color: Colors.white, fontSize:24)),
        backgroundColor: Colors.orange[900],
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: FirebaseDatabase.instance.reference().child("faqCategories").once(),
        builder: (context, AsyncSnapshot<DataSnapshot> snapshot){

          if (snapshot.hasData){
            faqInfoList.clear();
            keyArray.clear();
            Map<dynamic, dynamic> values = snapshot.data.value;
            values.forEach((key, value){
              faqInfoList.add(value);
              keyArray.add(key);
            });

            return new ListView.builder(
              shrinkWrap: true,
              itemCount: faqInfoList.length,
              itemBuilder:(BuildContext context, int index){

                return
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                          height:25
                      ),
                  Container(
                  width: MediaQuery.of(context).size.width / 1.1,
                  height: MediaQuery.of(context).size.height / 8,
                  //children:
                  child: RaisedButton(
                    elevation: 8.0,
                    // shape: Border.all(color: Colors.amber, width: 1.0),
                    shape: RoundedRectangleBorder(  borderRadius: BorderRadius.circular(20.0), side: BorderSide(color: Colors.orange[900], width: 1.5
                    ),
                    ),
                    color:Colors.white,
                    textColor: Colors.grey[600],
                    splashColor: Colors.orange,
                    onPressed: (){
                      //activityContentList[0]["Steps"][stepsArray[stepsIndex]]
                      myDialog.info(context, faqInfoList[index]["question"], faqInfoList[index]["answer"]);
                    },
                    child: Row(
                      children: <Widget> [
                        Expanded(
                          flex: 8,
                          child: Container(
                            child: Text(faqInfoList[index]["question"], style: TextStyle(fontSize:18, color:Colors.grey[600])), alignment: Alignment.centerLeft
                        )),
                        Expanded(
                            flex: 2,
                            child: Align(
                                child: Transform.rotate(angle: 270 * math.pi / 180,
                                  child: Icon(Icons.arrow_back_ios),
                                    alignment: Alignment.center,
                                  ),
                                ),
                        )
                      ],
                    ),
                  ),
                ),
                ],
                  );
              }
            );
          }
          return CircularProgressIndicator();
        }
      )

    );
  }
}