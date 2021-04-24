import 'package:flutter/material.dart';

class profile extends StatefulWidget{
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile>{
  @override
  TextEditingController _controllerParentName;
  TextEditingController _controllerChildName;
  TextEditingController _controllerEmail;

  Widget build(BuildContext context){
    final _controllerParentName = TextEditingController();
    _controllerParentName.text = "ParentName";
    final _controllerChildName = TextEditingController();
    _controllerChildName.text = "ChildName";
    final _controllerEmail = TextEditingController();
    _controllerEmail.text = "email";

    return new Scaffold(
        appBar: AppBar(
          title: Text('Profile', style: TextStyle(color: Colors.white, fontSize:24)),
          backgroundColor: Colors.orange[900],
          centerTitle: true,
        ),
        body: Container(
            child: Center(
                child:Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height:10),
                    Container(
                      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                      child: TextField(
                        onChanged: (text){
                          //on change of value
                          print("ParentName Text: ${_controllerParentName.text}");
                        },
                        controller: _controllerParentName,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(40.0),
                            ),
                          ),
                          //contentPadding: EdgeInsets.all(20.0),
                          labelText: "Parents Name",
                          alignLabelWithHint: true,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: _controllerParentName.text,
                          hintStyle: TextStyle(color: Colors.orange[900]),
                        ),
                      ),
                    ),
                    Container(          //Childs Name
                      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),

                      child: TextField(
                        onChanged: (text){
                          //on change of value
                          print("ChildName Text: ${_controllerChildName.text}");
                        },
                        controller: _controllerChildName,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(40.0),
                            ),
                          ),
                          //contentPadding: EdgeInsets.all(20.0),
                          labelText: "Child's Name",
                          alignLabelWithHint: true,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: _controllerChildName.text,
                          hintStyle: TextStyle(color: Colors.orange[900]),
                        ),
                      ),
                    ),
                    Container(                    //Email
                      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                      child: TextField(
                        onChanged: (text){
                          //on change of value
                          print("Email Text: ${_controllerEmail.text}");
                        },
                        controller: _controllerEmail,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(40.0),
                            ),
                          ),
                          //contentPadding: EdgeInsets.all(20.0),
                          labelText: "Email",
                          alignLabelWithHint: true,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintStyle: TextStyle(color: Colors.orange[900]),
                          hintText: _controllerEmail.text.toString(),
                        ),
                      ),
                    ),
                    RaisedButton(
                      splashColor: Colors.grey,
                      color: Colors.orange[900],
                      onPressed: () {
                        //TODO: //add validation
                        //add validation,
                        //submit form,
                        //push to next create acct page
                      },
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                      highlightElevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                'Save',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height:8.0, width: 10.0),
                    RaisedButton(
                      splashColor: Colors.grey,
                      color: Colors.grey,
                      onPressed: () {
                        //TODO: //add validation
                        //add validation,
                        //submit form,
                        //push to next create acct page
                      },
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                      highlightElevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
            )
        )
    );
  }
}