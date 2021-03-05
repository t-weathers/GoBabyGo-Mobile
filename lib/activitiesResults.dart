
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing_app/activitiesData.dart';

class activitiesResults extends StatelessWidget{

  final activitiesData data;

  activitiesResults({this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${data.categoryName}'),
          backgroundColor: Colors.orange[900]
      ),
      body: Text('${data.activityNames[0]} ${data.activityNames[1]}, ')
    );
  }

}