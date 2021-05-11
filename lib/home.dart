import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:testing_app/activities.dart';
import 'package:testing_app/faq.dart';
import 'package:testing_app/profile.dart';
import 'package:testing_app/timelog.dart';
import 'package:testing_app/forum.dart';
import 'package:testing_app/user.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'my_flutter_app_icons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.gsi, this.signIn, this.parentsName, this.childsName}) : super(key: key);
  //final String gsi;
  final GoogleSignInAccount gsi;
  final GoogleSignIn signIn;
  final String parentsName;
  final String childsName;
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  //final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
  //_MyTimeLogPageState.createState() => _MyyTimeLogPageState();
}

//first page on login
//class _MyTimeLogPageState extends State<MyHomePage> {
class _MyHomePageState extends State<MyHomePage> {
  //final GoogleSignIn googleSI;

  //@override
  //_MyHomePageState({Key key, @required this.googleSI}) : super(key: key);
  //String googleSignIn;
  GoogleSignInAccount googleSignIn;
  user currUser;
  GoogleSignIn sign;
  String childsName;
  String parentsName;
  void initState(){
    googleSignIn = widget.gsi;
    sign = widget.signIn;
    childsName = widget.childsName;
    parentsName = widget.parentsName;
    currUser = new user(googleSignIn.email);

    currUser.populateInfo(googleSignIn.email);
    super.initState();
  }

  TextStyle style =
  TextStyle(fontFamily: 'Montserrat', color: Colors.white, fontSize: 20.0);
  TextStyle style1 =
  TextStyle(fontFamily: 'Montserrat', color: Colors.black, fontSize: 36.0);
  TextStyle connectStyle =
  TextStyle(fontFamily: 'Montserrat', color: Colors.black, fontSize: 16);

  // int _currentIndex = 0;
  // void onTappedBar(int index){
  //   setState((){
  //     _currentIndex = index;
  //   });
  // }
  // Widget getPage(int ind){
  //   switch (ind){
  //     case 0:
  //       return profile(gsi: googleSignIn, signIn: sign, parent: parentsName, child: childsName);
  //       break;
  //     case 1:
  //       return timelog(gsi: googleSignIn, userInfo: currUser);
  //       break;
  //     case 2:
  //       return activities(userInfo: currUser);
  //       break;
  //     case 3:
  //       return faq();
  //       break;
  //   }
  // }
  List<Widget> _buildScreens() {
    return [
      profile(gsi: googleSignIn, signIn: sign, parent: parentsName, child: childsName),
      timelog(gsi: googleSignIn, userInfo: currUser),
      activities(userInfo: currUser),
      faq()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: new Icon(MyFlutterApp.user),
        title: "Profile",
        activeColorPrimary: Colors.orange[900],
        inactiveColorPrimary: Colors.grey[350],
      ),
      PersistentBottomNavBarItem(
        icon: Icon(MyFlutterApp.future),
        title: ("Time Log"),
        activeColorPrimary: Colors.orange[900],
        inactiveColorPrimary: Colors.grey[350],
      ),
      PersistentBottomNavBarItem(
        icon: Icon(MyFlutterApp.steering_wheel),
        title: ("Activities"),
        activeColorPrimary: Colors.orange[900],
        inactiveColorPrimary: Colors.grey[350],
      ),
      PersistentBottomNavBarItem(
        icon: Icon(MyFlutterApp.information),
        title: ("FAQ"),
        activeColorPrimary: Colors.orange[900],
        inactiveColorPrimary: Colors.grey[350],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller;

    _controller = PersistentTabController(initialIndex: 0);

    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }

  //   return Scaffold(
  //    // appBar: AppBar(
  //      // title: Text('Profile'),
  //       //backgroundColor: Colors.grey,
  //       //centerTitle: true,
  //     //),
  //
  //     body: getPage(_currentIndex),
  //     bottomNavigationBar: BottomNavigationBar(
  //       //backgroundColor: Colors.grey,
  //       onTap: onTappedBar,
  //       currentIndex: _currentIndex,
  //       items: [
  //         BottomNavigationBarItem(
  //           icon: new Icon(MyFlutterApp.user),
  //           label: "Profile",
  //          // backgroundColor: Colors.orange[900],
  //           backgroundColor: Colors.grey[350],
  //           // backgroundColor: Colors.grey[600],
  //           //label: 'Profile',
  //          /// icon: Icon(MyFlutterApp.user),
  //         //  icon: IconButton({
  //          //   icon: Icon(MyFlutterApp.user),
  //            // onPressed: NULL,
  //           //}),
  //   ),
  // //  BottomNavigationBarItem(
  // //  label:'Forum',
  // //  icon: Icon(MyFlutterApp.chat),
  //
  //  // ),
  //   BottomNavigationBarItem(
  //   label:'Time Log',
  //   icon: Icon(MyFlutterApp.future),
  //     //backgroundColor: Colors.orange[900],
  //     backgroundColor: Colors.grey[350],
  //     // backgroundColor: Colors.grey[600],
  //   ),
  //   BottomNavigationBarItem(
  //   label: 'Activities',
  //   icon: Icon(MyFlutterApp.steering_wheel),
  //    // backgroundColor: Colors.orange[900],
  //     backgroundColor: Colors.grey[350],
  //     // backgroundColor: Colors.grey[600],
  //   ),
  //   BottomNavigationBarItem(
  //   label: 'FAQ',
  //   icon: Icon(MyFlutterApp.information),
  //    // backgroundColor: Colors.orange[900],
  //     backgroundColor: Colors.grey[350],
  //    // backgroundColor: Colors.grey[600],
  //   ),
  //
  //
  //
  //   ],
  //   selectedItemColor: Colors.orange[900],
  //
  //
  //
  //   ),
  //   );
  }
