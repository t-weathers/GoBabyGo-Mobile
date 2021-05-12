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

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

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
        inactiveColorPrimary: Colors.grey[600],
      ),
      PersistentBottomNavBarItem(
        icon: Icon(MyFlutterApp.future),
        title: ("Time Log"),
        activeColorPrimary: Colors.orange[900],
        inactiveColorPrimary: Colors.grey[600],
      ),
      PersistentBottomNavBarItem(
        icon: Icon(MyFlutterApp.steering_wheel),
        title: ("Activities"),
        activeColorPrimary: Colors.orange[900],
        inactiveColorPrimary: Colors.grey[600],
      ),
      PersistentBottomNavBarItem(
        icon: Icon(MyFlutterApp.information),
        title: ("FAQ"),
        activeColorPrimary: Colors.orange[900],
        inactiveColorPrimary: Colors.grey[600],
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
      navBarStyle: NavBarStyle.style6, // Choose the nav bar style with this property.
    );
  }
  }
