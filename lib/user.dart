import 'package:firebase_database/firebase_database.dart';


/** Class to hold all information about the current user
 *  functions: populateInfo()
 * **/
class user {
  String userId = "null";
  String childName = "null";
  String email = "null";
  String name = "null";
  String recentActivity = "null";
  int weeklyGoal = 0;

  user(this.email);

  /** populateInfo(): function can be called to re populate all the info within the user.
   * takes in the user's email as an argument **/
  Future <void> populateInfo(String userEmail) async{
    print("entering populate info");
    final dbRef = FirebaseDatabase.instance.reference().child("ParentUsers");
    List<Map<dynamic, dynamic>> userInfo = [];

    //it warns to "indexOn": "Email" here. Maybe look into that?
    DataSnapshot data = await dbRef.orderByChild('Email').equalTo(
        userEmail).once();

    Map<dynamic, dynamic> values = data.value;

    userInfo.clear();
    values.forEach((key, value){
      userInfo.add(values);
      userId = key; //this is the user ID
    });
    childName = userInfo[0][userId]['ChildFirstName'];
    name = userInfo[0][userId]['FirstName'];
    weeklyGoal = userInfo[0][userId]['WeeklyGoal'];
    recentActivity = userInfo[0][userId]['RecentActivity'];
    email = userEmail;
  }

}