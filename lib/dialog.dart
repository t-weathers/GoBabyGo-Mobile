import 'package:flutter/material.dart';
class dialog{
  info(BuildContext context, String question, String answer){
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text(question),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(answer)
              ],
            ),
          ),
          actions: <Widget> [
            FlatButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Ok', style: TextStyle(fontSize: 26))),

          ],
        );
      }

    );
  }
}