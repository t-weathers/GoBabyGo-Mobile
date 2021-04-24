import 'dart:async';
import 'dart:convert';
//import 'dart:js';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testing_app/create_account1.dart';
import 'package:testing_app/home.dart';
import 'package:testing_app/loginGoogle.dart';
import 'package:flutter/foundation.dart';


import 'loginApple.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';




//From get data from internet

Future<Album> fetchAlbum() async {
  final response = await http.get('http://127.0.0.1:5000/');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final String data;

  Album({this.data});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      data: json['data'],
    );
  }
}

//// END /////

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Go Baby Go',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.orange,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Montserrat'
      ),
      home: LoginPage(title: 'Go Baby Go'),
      routes: <String, WidgetBuilder> {
        '/MyHomePage': (BuildContext context) => MyHomePage(),
        
    },
    );
  }
}
class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  bool isIOS;



  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final dbRef = FirebaseDatabase.instance.reference().child("ParentUsers");


  bool _isLoggedIn = false;

  //await Firebase.intializeApp();


  String parentName, childName;
  String entryKey;
  List<Map<dynamic, dynamic>> lists = [];
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;
  GoogleSignInAccount _googleSignInAccount;


  Future<String> login() async {
    try {
    //  print("here");

      _googleSignInAccount = await _googleSignIn
          .signIn();
     // print("here!");
      if (_googleSignInAccount == null){
        print('Google Signin ERROR! user: null');
        return null;
      }

      final GoogleSignInAuthentication _googleSignInAuthentication = await _googleSignInAccount
          .authentication;
      //print("here!!");
      final AuthCredential credential = GoogleAuthProvider.getCredential
        (idToken: _googleSignInAuthentication.idToken,
          accessToken: _googleSignInAuthentication.accessToken);
      //print("here!!!");
      final AuthResult authResult = await _auth.signInWithCredential(
          credential);
      //print("here!!!!");
      final FirebaseUser _user = authResult.user;
      //print("here!!!!!");

    //  print('here!!');
      assert(!_user.isAnonymous);
      assert(await _user.getIdToken() != null);
      //print("here!!!!!!");
      //print('here!!!');
      final FirebaseUser currentUser = await _auth.currentUser();
      assert(_user.uid == currentUser.uid);
      //print("here!!!!!!!");
      //print("Signing in with google: $_user");

      //right here I want to push to the realtime database with Default Child as default, Default Parent Name, Email Address
      DataSnapshot data = await dbRef.orderByChild('Email').equalTo(_googleSignInAccount.email).once();
      if (data.value == null){
       // String newKey = data.value.keys[0];
        print("this is a new entry!");
        dbRef.push().set({
          'ChildFirstName': 'default:none',
          'Email': _googleSignInAccount.email,
          'FirstName': _googleSignInAccount.displayName,
          'LastName': 'default: none',
          'RecentActivity': 'default: none so far',
          'WeeklyGoal': 150
        });
      }
      else{
        print("this entry exists in database");
      }

      //start here
      DataSnapshot data1 = await dbRef.orderByChild('Email').equalTo(
          _googleSignInAccount.email).once();

      Map<dynamic, dynamic> values = data1.value;

      lists.clear();
      values.forEach((key, value){
        lists.add(values);
        // print(key);
        entryKey = key;
        //print(value);

        //  childName = dbRef.child(key).child("ChildFirstName").once().toString();
        //  parentName = dbRef.child(key).child("FirstName").toString();

      });
      //print(data.value.toString().);
      // print("printing lists!");
      // print(lists);




      childName = lists[0][entryKey]['ChildFirstName'];
      parentName = lists[0][entryKey]['FirstName'];



      //end here
     /* DataSnapshot data = await dbRef.child("1").once();
      if (data.value == null){
        print("does not exist, create!");
        dbRef.child(_googleSignInAccount.email).set({
          'ChildFirstName': 'default:none_test',
          'Email': _googleSignInAccount.email,
          'FirstName': _googleSignInAccount.displayName,
          'LastName': 'default: none',
          'RecentActivity': 'default: none so far',
          'WeeklyGoal': 150
        });
      }*/


     /* dbRef.push().set({
        'ChildFirstName': 'default:none',
        'Email': _googleSignInAccount.email,
        'FirstName': _googleSignInAccount.displayName,
        'LastName': 'default: none',
        'RecentActivity': 'default: none so far',
        'WeeklyGoal': 150
      });*/
      return 'signInWithGoogle succeeded: $_user';


      //print("Here");


      setState(() {
        _isLoggedIn = true;
      });

  }

  catch  (err){
  print(err);
  }
}


  Widget _buildAppleButton(){
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    if (isIOS){
      return _signInAppleButton();
    }
    else{
      return SizedBox(height:30);
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        color: Colors.orange[900],
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                    "assets/GoBabyGo_WEBLOGO.png",
                    fit: BoxFit.contain,
                    alignment: FractionalOffset.center,
                    height: 150,
                  
                  ),
              SizedBox(height: 150),
              _signInGoogleButton(),

              SizedBox(height:30),
              _buildAppleButton(),
             // _signInAppleButton(),
             // SizedBox(height:30),
             // _createAccountButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInGoogleButton() {
    return RaisedButton(
      splashColor: Colors.grey,
      color: Colors.white,
      onPressed: () async {
         await login();
        // print("Here");
         //print("CurrentUsersEmail: $_user");
        // Scaffold.of(context).showSnackBar(SnackBar(content: Text(_googleSignIn.currentUser.email),));
        // Navigator.push(context, MterialPageRoute(builder: (context) => MyHomePage(gsi: _googleSignIn),
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage(gsi: _googleSignInAccount, signIn: _googleSignIn, parentsName: parentName, childsName: childName),
         ),
         );

        // Navigator.pushNamedAndRemoveUntil(context, "/MyHomePage", (_) => false);
        // Scaffold.of(context).showSnackBar(SnackBar(content: Text(_googleSignIn.currentUser.email),));
         //Navigator.pushNamedAndRemoveUntil(context, "/MyHomePage", (_) => false);
       // Navigator.push(
        //  context,
         // MaterialPageRoute(builder: (context) => home()),
        //);
      },
      //onPressed: () {
 //         Navigator.push(
   //         context,
     //       MaterialPageRoute(builder: (context) => LoginGoogle()),
       //   );
      //},
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      
      
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[600],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _signInAppleButton(){
    return RaisedButton(
      splashColor: Colors.grey,
      color: Colors.white,
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginApple()),
          );
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      
      
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //change to apple logo
            Image(image: AssetImage("assets/apple_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Apple',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[600],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _createAccountButton(){
    return RaisedButton(
      splashColor: Colors.grey,
      color: Colors.white,
      onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateAccount1()),
          );
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
                'Create Account',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[600],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


}