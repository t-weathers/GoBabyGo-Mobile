
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
      //body: Text('${data.activityNames[0]} ${data.activityNames[1]}, ')
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            shrinkWrap: true,
            itemCount: data.activityNames.length,
            itemBuilder: (BuildContext context, int index){
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                side: BorderSide(width: 3, color: Colors.orange[900])),
                child: ListTile(
                  title: Text('${data.activityNames[index]}'),
                )
              );
            },

            //




        )
    );
  }

}