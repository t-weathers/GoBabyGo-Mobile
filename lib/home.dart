import 'package:flutter/material.dart';
import 'package:testing_app/activities.dart';
import 'package:testing_app/faq.dart';
import 'package:testing_app/profile.dart';
import 'package:testing_app/timelog.dart';
import 'package:testing_app/main.dart';
import 'package:testing_app/user.dart';
import 'my_flutter_app_icons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'constants.dart';

/// MYHOMEPAGE CLASS
/// * Description: this class displays the navigation bar and controls navigation to screens
/// * Functions: N/A
/// **/

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
  //grab all the information associated with an authenticated user. Store in variables accessible within home.dart
  void initState(){
    googleSignIn = widget.gsi;
    sign = widget.signIn;
    childsName = widget.childsName;
    parentsName = widget.parentsName;
    currUser = new user(googleSignIn.email);

    currUser.populateInfo(googleSignIn.email);
    super.initState();
    ContextKeeper().init(context);
  }

  //List of screens passed in with screen pertinent information -- Profile, Time Log, Activities, FAQ
  List<Widget> _buildScreens() {
    return [
      profile(gsi: googleSignIn, signIn: sign, parent: parentsName, child: childsName),
      timelog(gsi: googleSignIn, userInfo: currUser),
      activities(userInfo: currUser),
      faq()
    ];
  }

  //list of navbar items and their styling -- Profile, Time Log, Activities, FAQ
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: new Icon(MyFlutterApp.user),
        title: profilePageTitle,
        activeColorPrimary: Colors.orange[900],
        inactiveColorPrimary: Colors.grey[600],
      ),
      PersistentBottomNavBarItem(
        icon: Icon(MyFlutterApp.future),
        title: timeLogPageTitle,
        activeColorPrimary: Colors.orange[900],
        inactiveColorPrimary: Colors.grey[600],
      ),
      PersistentBottomNavBarItem(
        icon: Icon(MyFlutterApp.steering_wheel),
        title: activitiesPageTitle,
        activeColorPrimary: Colors.orange[900],
        inactiveColorPrimary: Colors.grey[600],
      ),
      PersistentBottomNavBarItem(
        icon: Icon(MyFlutterApp.information),
        title: faqPageTitle,
        activeColorPrimary: Colors.orange[900],
        inactiveColorPrimary: Colors.grey[600],
      ),
    ];
  }

  //code taken from https://pub.dev/packages/persistent_bottom_nav_bar -- no changes made
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
        borderRadius: BorderRadius.circular(-1.0),
        colorBehindNavBar: Colors.grey[200],
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
