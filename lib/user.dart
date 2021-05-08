import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';


/// USER CLASS
/// Description: Class to hold all information about the current user.
/// Functions: populateInfo()  **/
class user {

  String userId = "null";
  String childName = "null";
  String email = "null";
  String name = "null";
  String recentActivity = "null";
  int weeklyGoal = 0;

  user(this.email);

  /// Function: populateInfo
  /// Description: function can be called to re populate all the info within the user.
  /// Params: userEmail which is the users email  **/
  Future <void> populateInfo(String userEmail) async{
    final dbRef = FirebaseDatabase.instance.reference().child("ParentUsers");
    List<Map<dynamic, dynamic>> userInfo = [];

    DataSnapshot data = await dbRef.orderByChild('Email').equalTo(
        userEmail).once();

    Map<dynamic, dynamic> values = data.value;

    userInfo.clear();
    values.forEach((key, value){
      userInfo.add(values);
      userId = key; //this is the user ID
    });

    // Set variables
    childName = userInfo[0][userId]['ChildFirstName'];
    name = userInfo[0][userId]['FirstName'];
    weeklyGoal = userInfo[0][userId]['WeeklyGoal'];
    recentActivity = userInfo[0][userId]['RecentActivity'];
    email = userEmail;
  }

  /// Function: setRecentActivity
  /// Description: updates recent activity in the database
  /// Params: newActivity which is the new activity to be set**/
  Future <void> setRecentActivity(String newActivity){
    this.recentActivity = newActivity;
    final dbRef = FirebaseDatabase.instance.reference().child("ParentUsers");
    dbRef.child(userId).update({
      'RecentActivity': newActivity
    });
  }

  /// Function: setWeeklyGoal
  /// Description: updates weekly goal in the database
  /// Params: newGoal which is the new goal to be set **/
  Future <void> setWeeklyGoal(int newGoal){
    this.weeklyGoal = newGoal;
    final dbRef = FirebaseDatabase.instance.reference().child("ParentUsers");
    dbRef.child(userId).update({
      'WeeklyGoal': newGoal
    });
  }

}