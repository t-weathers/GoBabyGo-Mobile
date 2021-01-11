import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;


//From get data from internet





//// END /////
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Go Baby Go - About',
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
        //primarySwatch: Colors.orange,
        primaryColor: Colors.orange,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Go Baby Go'),
    );
  }
}

//first home page on login

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

//first page on login

class _MyHomePageState extends State<MyHomePage> {
  TextStyle style =
  TextStyle(fontFamily: 'Montserrat', color: Colors.white, fontSize: 20.0);
  TextStyle style1 =
  TextStyle(fontFamily: 'Montserrat', color: Colors.black, fontSize: 36.0);
  TextStyle connectStyle =
  TextStyle(fontFamily: 'Montserrat', color: Colors.black, fontSize: 16);

  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
        obscureText: false,
        style: style,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          hintStyle: TextStyle(color: Colors.white),
          filled: true,
          fillColor: Color.fromRGBO(235, 152, 78, 1.0),
          //border before being clicked
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(32.0),
          ),
          //border after click
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(32.0),
          ),
        ));
    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.grey[200],
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width/1.5,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        //THIS IS WHERE THE BUTTON CLICK GOES

        child: Text("The mission of GoBabyGo! is to provide innovative, accessible, and practical options to improve the lives of children with limited mobility.",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
      ),
    );

    final navBar = Material(
      elevation: 2.0,
      //borderRadius: BorderRadius.circular(8),
      color: Colors.orange[400],
      //color: Colors.white,
        child: Column(
          //width:MediaQuery.of(context).size.width/5,
            //color: Colors.orange[400],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //color: Colors.orange[400],
          children: [
            SizedBox(
              height:35,
              child: Image.asset(
                "assets/facebook.png",
                width:MediaQuery.of(context).size.width/4,
                height:35,
                //color: Colors.orange[400],
                //fit: BoxFit.contain,
              ),
            ), //Image.asset("assets/facebook.png", fit:BoxFit.contain),
            InkWell(child: new Text('Profile')
            ),
          ]
        ),


    );
    final connect = Material(
      elevation: 5.0,
      //widthFactor:0.5,
      borderRadius: BorderRadius.circular(15.0),
      color: Colors.grey[350],
      //width: MediaQuery.of(context).size.width/2,
      //child: MaterialButton(
      child: Container(

        width:MediaQuery.of(context).size.width/2,
        //width: MediaQuery.of(context).size.width/2,
        padding:EdgeInsets.fromLTRB(10.0, 7.5, 10.0, 7.5),
        //children:[ Text("Facebook\n Link1234",
        //textAlign: TextAlign.center,
       // style: connectStyle),
     child: Column(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
        // Text("Facebook", textAlign: TextAlign.center, style: connectStyle),
         SizedBox(
           height: 40.0,
           child: Image.asset(
             "assets/facebook.png",
             fit: BoxFit.contain,
           ),
         ), //Image.asset("assets/facebook.png", fit:BoxFit.contain),
         InkWell(child: new Text('@GoBabyGoOregon'),
             onTap: () => launch('https://www.facebook.com/GoBabyGoOregon/')
         ),
         //Text("Link1234", textAlign: TextAlign.center, style: connectStyle),
       ]
     )




      ),

    );
    final connect1 = Material(
      elevation: 5.0,
      //widthFactor:0.5,
      borderRadius: BorderRadius.circular(15.0),
      color: Colors.grey[350],
      //width: MediaQuery.of(context).size.width/2,
      //child: MaterialButton(
      child: Container(

          width:MediaQuery.of(context).size.width/2,
          //width: MediaQuery.of(context).size.width/2,
          padding:EdgeInsets.fromLTRB(10.0, 7.5, 10.0, 7.5),
          //children:[ Text("Facebook\n Link1234",
          //textAlign: TextAlign.center,
          // style: connectStyle),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
             //   Text("Instagram", textAlign: TextAlign.center, style: connectStyle),
                SizedBox(
                  height: 40.0,
                  child: Image.asset(
                    "assets/IG.png",
                    fit: BoxFit.contain,
                  ),
                ), //Image.asset("assets/facebook.png", fit:BoxFit.contain),
                InkWell(child: new Text('@gobabygo.oregon'),
                  onTap: () => launch('https://instagram.com/gobabygo.oregon?igshid=ka0wakbm5q3a')
                ),
               // Text("Link1234", textAlign: TextAlign.center, style: connectStyle),
              ]
          )




      ),

    );
    final connect2 = Material(
      elevation: 5.0,
      //widthFactor:0.5,
      borderRadius: BorderRadius.circular(15.0),
      color: Colors.grey[350],
      //width: MediaQuery.of(context).size.width/2,
      //child: MaterialButton(
      child: Container(

          width:MediaQuery.of(context).size.width/2,
          //width: MediaQuery.of(context).size.width/2,
          padding:EdgeInsets.fromLTRB(10.0, 7.5, 10.0, 7.5),
          //children:[ Text("Facebook\n Link1234",
          //textAlign: TextAlign.center,
          // style: connectStyle),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Text("Youtube", textAlign: TextAlign.center, style: connectStyle),
                SizedBox(
                  height: 40.0,
                  child: Image.asset(
                    "assets/youtube.png",
                    fit: BoxFit.contain,
                  ),
                ), //Image.asset("assets/facebook.png", fit:BoxFit.contain),
                InkWell(child: new Text('GoBabyGo Youtube'),
                    onTap: () => launch('https://www.youtube.com/user/GoBabyGoPL')
                ),
                //Text("Link1234", textAlign: TextAlign.center, style: connectStyle),
              ]
          )




      ),

    );
    final connect3 = Material(
      elevation: 5.0,
      //widthFactor:0.5,
      borderRadius: BorderRadius.circular(15.0),
      color: Colors.grey[350],
      //width: MediaQuery.of(context).size.width/2,
      //child: MaterialButton(
      child: Container(

          width:MediaQuery.of(context).size.width/2,
          //width: MediaQuery.of(context).size.width/2,
          padding:EdgeInsets.fromLTRB(10.0, 7.5, 10.0, 7.5),
          //children:[ Text("Facebook\n Link1234",
          //textAlign: TextAlign.center,
          // style: connectStyle),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               // Text("Email", textAlign: TextAlign.center, style: connectStyle),
                SizedBox(
                  height: 40.0,
                  child: Image.asset(
                    "assets/question.png",
                    fit: BoxFit.contain,
                  ),
                ), //Image.asset("assets/facebook.png", fit:BoxFit.contain),
                InkWell(child: new Text('Placeholder'),
                    onTap: () => launch('gobabygo.oregon@gmail.com')
                ),
               // Text("Link1234", textAlign: TextAlign.center, style: connectStyle),
              ]
          )




      ),

    );
    final signupButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.grey[200],
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width/1.5,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        //THIS IS WHERE THE BUTTON CLICK GOES

        // GBGHome: https://gobabygooregon.org/

        child: Column (
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              InkWell(child: new Text('GBG Home',
                style: style.copyWith(
                    color: Colors.black, fontWeight: FontWeight.bold, fontSize:18),),

                  onTap: () => launch('https://gobabygooregon.org/')
              ),
              InkWell(child: new Text('GBG Connect',
                style: style.copyWith(
                    color: Colors.black, fontWeight: FontWeight.bold, fontSize:18),),
                  onTap: () => launch('https://www.gbgconnect.com/')
              ),
              InkWell(child: new Text('gobabygo.oregon@gmail.com',
                style: style.copyWith(
                    color: Colors.black, fontWeight: FontWeight.bold, fontSize:18),),

                  onTap: () => launch('gobabygo.oregon@gmail.com')
              ),
              InkWell(child: new Text('DummyLink2',
                style: style.copyWith(
                    color: Colors.black, fontWeight: FontWeight.bold, fontSize:18),),
                  onTap: () => launch('https://gobabygooregon.org/')
              ),
              ]

        ),

        /*Text("GBGConnect: https://www.gbgconnect.com/\n"
            "GBGWebsite:\n"
            "Link3 Title:\n"
            "Link4 Title:",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize:18)),*/
      ),
    );

    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.orange[400], Colors.orange[400]])),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        Text("GoBabyGo - About",
                            style: style1,
                            textAlign: TextAlign.center),
                           // style: style.copyWith(
                            //color:Csolors.black, fontWeight:FontWeight.bold)),
                        SizedBox(
                          height:20.0,
                        ),
                       // emailField,

                        loginButon,
                        SizedBox(
                          height: 20.0,
                        ),
                      Text("Resource Links",
                        textAlign: TextAlign.center,
                        style: style.copyWith(
                            color:Colors.black, fontWeight:FontWeight.bold)),

                        SizedBox(
                          height:10.0,
                        ),
                        signupButton,
                        SizedBox(
                          height: 20,
                        ),
                        Text("Connect with Us!",
                          textAlign: TextAlign.center,
                          style: style.copyWith(
                              color:Colors.black, fontWeight:FontWeight.bold)),


                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:[
                            new Flexible(child: connect), //connect,
                            SizedBox(width: 5),
                            new Flexible(child: connect1), //connect1,
                            //new Flexible(child: connect1),
                          ],
                        ),
                        /*FractionallySizedBox(
                          alignment: Alignment.topCenter,
                          widthFactor: 0.5,
                          child: Container(
                            connect,
                          ),
                        ),*/
                      //  connect,
                        SizedBox(
                          height:10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:[
                            new Flexible(child: connect2), //connect,
                            SizedBox(width: 5),
                            new Flexible(child: connect3), //connect1,
                            //new Flexible(child: connect1),
                          ],
                        ),
                      // connect1,
                        /*SizedBox(
                          height: 25.0,
                          child: Imfage.asset("assets/IG.png",
                          fit:BoxFit.contain,
                        ),
                        ),*/
                        SizedBox(
                          height: 100.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:[
                            new Flexible(child: navBar), //connect,
                            SizedBox(width: 5),
                            new Flexible(child: navBar), //connect1,
                            SizedBox(width: 5),
                            new Flexible(child: navBar), //connect1,
                            SizedBox(width: 5),
                            new Flexible(child: navBar), //connect1,
                            SizedBox(width: 5),
                            new Flexible(child: navBar), //connect1,
                            //new Flexible(child: connect1),
                          ],
                        ),
                        //right here I need to add code for navigation bar using ROW()



                      ],
            ),
          ),
        ),
      ),
    );
  }
}