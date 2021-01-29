import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

class CreateAccount1 extends StatefulWidget {
    CreateAccount1({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _CreateAccount1 createState() => _CreateAccount1();
}

//0 is Parent
//1 is Clinician
//2 is Researcher
//3 is other

class _CreateAccount1 extends State<CreateAccount1>{

  final _formKey = GlobalKey<FormState>();

  String _chosenUserType = "";

  List<DropdownMenuItem<String>> userTypeList = [];

  List<DropdownMenuItem<String>> loadUserTypeList(){
      userTypeList = [];
      userTypeList.add(new DropdownMenuItem(
        child: new Text('Parent'),
        value: "Parent",
      ));
      userTypeList.add(new DropdownMenuItem(
        child: new Text('Clinician'),
        value: "Clinician",
      ));
      userTypeList.add(new DropdownMenuItem(
        child: new Text('Researcher'),
        value: "Researcher",
      ));
      userTypeList.add(new DropdownMenuItem(
        child: new Text('Other'),
        value: "Other",
      ));
      return userTypeList;
  }

  List<Widget> getFormWidget(List<DropdownMenuItem<String>> userTypeList){
    List<Widget> formWidget;

    formWidget.add(new DropdownButton(
        hint: new Text('Relationship to GoBabyGo'),
        items: userTypeList,
        value: _chosenUserType,
        onChanged: (value){
          setState((){
            _chosenUserType = value;
          });
        },
        isExpanded: true,
    ));

    return formWidget;

  }

  Widget submitButtom(){
    return ElevatedButton(
        onPressed: () {
          // Validate returns true if the form is valid, otherwise false.
          if (_formKey.currentState.validate()) {
            // If the form is valid, display a snackbar. In the real world,
            // you'd often call a server or save the information in a database.
          }
        },
        child: Text('Submit'),
    );

  }

  Widget firstName(){
    return TextFormField(
  // The validator receives the text that the user has entered.
      decoration: const InputDecoration(
        hintText: 'First Name',
        
      ),
      validator: (value) {
        if (value.isEmpty || !isAlpha(value)) {
          return 'Please enter some text';
        }
        return null;
      },
      );
  }

  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
              // Add TextFormFields and ElevatedButton here.
              firstName(),
            
              submitButtom(),

        ]
     )
    );
  }

   Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Container(
          firstName(),
        ));
  }
  
}