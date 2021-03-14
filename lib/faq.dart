import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';



import 'dialog.dart';

class faq extends StatefulWidget{
  @override
  _faqState createState() => _faqState();
  //SteeringRoute createState1() => SteeringRoute();
}

class _faqState extends State<faq>{

  final dbRef = FirebaseDatabase.instance.reference().child("faqCategories");
  List<Map<dynamic, dynamic>> lists = [];
  dialog myDialog = new dialog();
  final catArray = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen"];
  @override
  Widget build(BuildContext context){
  /*  final activityButton =     RaisedButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: Colors.red)),
      onPressed: () {},
      color: Colors.red,
      textColor: Colors.white,
      child: Text("Buy now".toUpperCase(),
          style: TextStyle(fontSize: 14)),
    );*/

    return new Scaffold(
      appBar: AppBar(
        title: Text('FAQ', style: TextStyle(color: Colors.white, fontSize:24)),
        backgroundColor: Colors.orange[900],
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: dbRef.once(),
        builder: (context, AsyncSnapshot<DataSnapshot> snapshot){
          if (snapshot.hasData){
            lists.clear();
            Map<dynamic, dynamic> values = snapshot.data.value;
            values.forEach((key, value){
              lists.add(values);
            });
           // if (lists != null){
            //  print(lists);
           // }

            return new ListView.builder(
              shrinkWrap: true,
              itemCount: lists.length,

              itemBuilder:(BuildContext context, int index){


               // print("List at index [index]: ");

                //print(lists[index]["four"]["question"]); //+ lists[index]);
                return
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                          height:25
                      ),
                  Container(
                  width: 295,
                  height: 65,
                  //children:
                  child:

                  RaisedButton(
                    elevation: 8.0,
                    // shape: Border.all(color: Colors.amber, width: 1.0),
                    shape: RoundedRectangleBorder(  borderRadius: BorderRadius.circular(20.0), side: BorderSide(color: Colors.orange[900], width: 1.5
                    ),
                    ),
                    color:Colors.white,
                    //color:Color.fromRGBO(200, 200, 200, 0.4),

                    // Text('Acceleration', style: TextStyle(fontSize:18)),




                    textColor: Colors.grey[600],
                    splashColor: Colors.orange,
                    //padding: EdgeInsets.symmetric(vertical: 30, horizontal: 100),
                    onPressed: (){
                      myDialog.info(context, lists[index][catArray[index]]["question"], lists[index][catArray[index]]["answer"]);

                    },
                    child: Row(
                      children: <Widget> [
                        Container(
                            width:235,
                            child: Text(lists[index][catArray[index]]["question"], style: TextStyle(fontSize:18, color:Colors.grey[600])), alignment: Alignment.centerLeft
                        ),
                        Align(child: Icon(Icons.arrow_downward), alignment: Alignment.centerRight),
                      ],
                    ),

                  ),

                ),

                ],
                  );


              }
            );
          }
          return CircularProgressIndicator();
        }
      )
   /*   body: Center(

        child: SingleChildScrollView(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            SizedBox(
              height: 25,
            ),

            Text(
              'Hi, how can we help?',
              style: TextStyle(fontSize: 24),



            ),

            SizedBox(
              height: 25,
            ),

            Container(
              width: 265,
              height: 65,

              child:
              RaisedButton(
                elevation: 8.0,
                // shape: Border.all(color: Colors.amber, width: 1.0),
                shape: RoundedRectangleBorder(  borderRadius: BorderRadius.circular(20.0), side: BorderSide(color: Colors.orangeAccent, width: 1.5
                ),
                ),
                color:Color.fromRGBO(200, 200, 200, 0.4),

                // Text('Acceleration', style: TextStyle(fontSize:18)),




                textColor: Colors.black54,
                splashColor: Colors.orange,
                //padding: EdgeInsets.symmetric(vertical: 30, horizontal: 100),
                onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SteeringRoute()),
                );},
                child: Row(
                  children: <Widget> [
                    Container(
                        width:200,
                        child: Text('Steering', style: TextStyle(fontSize:18)), alignment: Alignment.centerLeft
                    ),
                    Align(child: Icon(Icons.arrow_forward), alignment: Alignment.centerRight),
                  ],
                ),

              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: 265,
              height: 65,

              child:
            RaisedButton(
              elevation: 8.0,
              // shape: Border.all(color: Colors.amber, width: 1.0),
              shape: RoundedRectangleBorder(  borderRadius: BorderRadius.circular(20.0), side: BorderSide(color: Colors.orangeAccent, width: 1.5
              ),
              ),
              color:Color.fromRGBO(200, 200, 200, 0.4),

             // Text('Acceleration', style: TextStyle(fontSize:18)),




              textColor: Colors.black54,
              splashColor: Colors.orange,
              //padding: EdgeInsets.symmetric(vertical: 30, horizontal: 100),
              onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => AccelerationRoute()),
              );},
              child: Row(
                children: <Widget> [
                  Container(
                      width:200,
                      child: Text('Acceleration', style: TextStyle(fontSize:18)), alignment: Alignment.centerLeft
                  ),
                  Align(child: Icon(Icons.arrow_forward), alignment: Alignment.centerRight),
                ],
              ),

            ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: 265,
              height: 65,

              child:
              RaisedButton(
                elevation: 8.0,
                // shape: Border.all(color: Colors.amber, width: 1.0),
                shape: RoundedRectangleBorder(  borderRadius: BorderRadius.circular(20.0), side: BorderSide(color: Colors.orangeAccent, width: 1.5
                ),
                ),
                color:Color.fromRGBO(200, 200, 200, 0.4),

                // Text('Acceleration', style: TextStyle(fontSize:18)),




                textColor: Colors.black54,
                splashColor: Colors.orange,
                //padding: EdgeInsets.symmetric(vertical: 30, horizontal: 100),
                onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => OnRoute()),
                );},
                child: Row(
                  children: <Widget> [
                    Container(
                        width:200,
                        child: Text('Turning the Car On', style: TextStyle(fontSize:18)), alignment: Alignment.centerLeft
                    ),
                    Align(child: Icon(Icons.arrow_forward), alignment: Alignment.centerRight),
                  ],
                ),

              ),
            ),
            SizedBox(
              height: 30,
            ),

            Container(
              width: 265,
              height: 65,

              child:
              RaisedButton(
                elevation: 8.0,
                // shape: Border.all(color: Colors.amber, width: 1.0),
                shape: RoundedRectangleBorder(  borderRadius: BorderRadius.circular(20.0), side: BorderSide(color: Colors.orangeAccent, width: 1.5
                ),
                ),
                color:Color.fromRGBO(200, 200, 200, 0.4),

                // Text('Acceleration', style: TextStyle(fontSize:18)),




                textColor: Colors.black54,
                splashColor: Colors.orange,
                //padding: EdgeInsets.symmetric(vertical: 30, horizontal: 100),
                onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => BreakingRoute()),
                );},
                child: Row(
                  children: <Widget> [
                    Container(
                        width:200,
                        child: Text('Breaking', style: TextStyle(fontSize:18)), alignment: Alignment.centerLeft
                    ),
                    Align(child: Icon(Icons.arrow_forward), alignment: Alignment.centerRight),
                  ],
                ),

              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: 265,
              height: 65,

              child:
              RaisedButton(
                elevation: 8.0,
                // shape: Border.all(color: Colors.amber, width: 1.0),
                shape: RoundedRectangleBorder(  borderRadius: BorderRadius.circular(20.0), side: BorderSide(color: Colors.orangeAccent, width: 1.5
                ),
                ),
                color:Color.fromRGBO(200, 200, 200, 0.4),

                // Text('Acceleration', style: TextStyle(fontSize:18)),




                textColor: Colors.black54,
                splashColor: Colors.orange,
                //padding: EdgeInsets.symmetric(vertical: 30, horizontal: 100),
                onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => CleaningRoute()),
                );},
                child: Row(
                  children: <Widget> [
                    Container(
                      width:200,
                        child: Text('Cleaning', style: TextStyle(fontSize:18)), alignment: Alignment.centerLeft
                    ),


                    Align(child: Icon(Icons.arrow_forward), alignment: Alignment.centerRight),
                  ],
                ),

              ),
            ),
            SizedBox(
              height: 30,
            ),


            Container(
              width: 265,
              height: 65,

              child:
          RaisedButton(
            elevation: 8.0,
            // shape: Border.all(color: Colors.amber, width: 1.0),
            shape: RoundedRectangleBorder(  borderRadius: BorderRadius.circular(20.0), side: BorderSide(color: Colors.orangeAccent, width: 1.5
            ),
            ),
            color:Color.fromRGBO(200, 200, 200, 0.4),

            // Text('Acceleration', style: TextStyle(fontSize:18)),




            textColor: Colors.black54,
            splashColor: Colors.orange,
            //padding: EdgeInsets.symmetric(vertical: 30, horizontal: 100),
            onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SteeringRoute()),
            );},
            child: Row(
              children: <Widget> [
                Container(
                    width:200,
                    child: Text('Cleaning', style: TextStyle(fontSize:18)), alignment: Alignment.centerLeft
                    ),

                Align(child: Icon(Icons.arrow_forward), alignment: Alignment.centerRight),
              ],
            ),

          ),
        ),
        SizedBox(
          height: 30,
        ),
            Container(
              width: 265,
              height: 65,

              child:
              RaisedButton(
                elevation: 8.0,
                // shape: Border.all(color: Colors.amber, width: 1.0),
                shape: RoundedRectangleBorder(  borderRadius: BorderRadius.circular(20.0), side: BorderSide(color: Colors.orangeAccent, width: 1.5
                ),
                ),
                color:Color.fromRGBO(200, 200, 200, 0.4),

                // Text('Acceleration', style: TextStyle(fontSize:18)),




                textColor: Colors.black54,
                splashColor: Colors.orange,
                //padding: EdgeInsets.symmetric(vertical: 30, horizontal: 100),
                onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SteeringRoute()),
                );},
                child: Row(
                  children: <Widget> [
                    Container(
                        width:200,
                        child: Text('Cleaning', style: TextStyle(fontSize:18)), alignment: Alignment.centerLeft
                    ),
                    Align(child: Icon(Icons.arrow_forward), alignment: Alignment.centerRight),
                  ],
                ),

              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
          ),



      ),

      ),*/
    );
  }
}

class SteeringRoute extends StatelessWidget{




  dialog myDialog = new dialog();

  var questList = ["Q1", "Q2", "Q3", "Q4", "Q5", "Q6", "Q7", "Q8"];
  var answList = ["A1", "A2", "A3", "A4", "A5", "A6", "A7", "A8"];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ - Steering'),
        automaticallyImplyLeading: true,
        leading: IconButton(icon: Icon(Icons.arrow_back),
       onPressed:() => Navigator.pop(context, false)),
       // onPressed() => Navigator.pop(false),
        backgroundColor: Colors.grey,
        centerTitle: true,
      ),

      body: Center(

      child: SingleChildScrollView(

      child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
     // mainAxisAlignment: MainAxisAlignment.center,
     // crossAxisAlignment: CrossAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[

      SizedBox(
      height: 15,
    ),

    Row(
      children: <Widget>[
      Container(
        padding: EdgeInsets.all(16.0),
        child: Text('Categories  | ', style: TextStyle(fontSize:24)),
      ),
      Text('Steering Wheel', style: TextStyle(fontSize:24, fontWeight:FontWeight.bold)),
     // children: <Widget> [
     //   Text(

    //'Categories | ',
    //style: TextStyle(fontSize: 24)),
    //    Text('Steering Wheel', style: TextStyle(fontSize:24, fontWeight: FontWeight.bold)),

      //],
],

),

        SizedBox(
          height: 15,
        ),
        Container(
          width: 295,
          height: 65,

          child:
          RaisedButton(
            elevation: 8.0,
            // shape: Border.all(color: Colors.amber, width: 1.0),
            shape: RoundedRectangleBorder(  borderRadius: BorderRadius.circular(20.0), side: BorderSide(color: Colors.orangeAccent, width: 1.5
            ),
            ),
            color:Color.fromRGBO(200, 200, 200, 0.4),

            // Text('Acceleration', style: TextStyle(fontSize:18)),




            textColor: Colors.black54,
            splashColor: Colors.orange,
            //padding: EdgeInsets.symmetric(vertical: 30, horizontal: 100),
            onPressed: (){
              myDialog.info(context, "What to do if my steering wheel will not turn?", "This is a sample answer for question 1.. trying to see if the format is correct sample answer only");

            },
            child: Row(
              children: <Widget> [
                Container(
                    width:235,
                    child: Text('What to do if my steering wheel will not turn?', style: TextStyle(fontSize:18)), alignment: Alignment.centerLeft
                ),
                Align(child: Icon(Icons.arrow_downward), alignment: Alignment.centerRight),
              ],
            ),

          ),
        ),

        SizedBox(
          height: 30,
        ),
        Container(
          width: 295,
          height: 65,

          child:
          RaisedButton(
            elevation: 8.0,
            // shape: Border.all(color: Colors.amber, width: 1.0),
            shape: RoundedRectangleBorder(  borderRadius: BorderRadius.circular(20.0), side: BorderSide(color: Colors.orangeAccent, width: 1.5
            ),
            ),
            color:Color.fromRGBO(200, 200, 200, 0.4),

            // Text('Acceleration', style: TextStyle(fontSize:18)),




            textColor: Colors.black54,
            splashColor: Colors.orange,
            //padding: EdgeInsets.symmetric(vertical: 30, horizontal: 100),
            onPressed: (){
              myDialog.info(context, "What to do if my steering wheel will not turn?", "This is a sample answer for question 1.. trying to see if the format is correct sample answer only");

            },
            child: Row(
              children: <Widget> [
                Container(
                    width:235,
                    child: Text('Q1', style: TextStyle(fontSize:18)), alignment: Alignment.centerLeft
                ),
                Align(child: Icon(Icons.arrow_downward), alignment: Alignment.centerRight),
              ],
            ),

          ),
        ),

        SizedBox(
          height: 30,
        ),
        Container(
          width: 295,
          height: 65,

          child:
          RaisedButton(
            elevation: 8.0,
            // shape: Border.all(color: Colors.amber, width: 1.0),
            shape: RoundedRectangleBorder(  borderRadius: BorderRadius.circular(20.0), side: BorderSide(color: Colors.orangeAccent, width: 1.5
            ),
            ),
            color:Color.fromRGBO(200, 200, 200, 0.4),

            // Text('Acceleration', style: TextStyle(fontSize:18)),




            textColor: Colors.black54,
            splashColor: Colors.orange,
            //padding: EdgeInsets.symmetric(vertical: 30, horizontal: 100),
            onPressed: (){
              myDialog.info(context, "What to do if my steering wheel will not turn?", "This is a sample answer for question 1.. trying to see if the format is correct sample answer only");

            },
            child: Row(
              children: <Widget> [
                Container(
                    width:235,
                    child: Text('Q1', style: TextStyle(fontSize:18)), alignment: Alignment.centerLeft
                ),
                Align(child: Icon(Icons.arrow_downward), alignment: Alignment.centerRight),
              ],
            ),

          ),
        ),

        SizedBox(
          height: 30,
        ),
        Container(
          width: 295,
          height: 65,

          child:
          RaisedButton(
            elevation: 8.0,
            // shape: Border.all(color: Colors.amber, width: 1.0),
            shape: RoundedRectangleBorder(  borderRadius: BorderRadius.circular(20.0), side: BorderSide(color: Colors.orangeAccent, width: 1.5
            ),
            ),
            color:Color.fromRGBO(200, 200, 200, 0.4),

            // Text('Acceleration', style: TextStyle(fontSize:18)),




            textColor: Colors.black54,
            splashColor: Colors.orange,
            //padding: EdgeInsets.symmetric(vertical: 30, horizontal: 100),
            onPressed: (){
              myDialog.info(context, "What to do if my steering wheel will not turn?", "This is a sample answer for question 1.. trying to see if the format is correct sample answer only");

            },
            child: Row(
              children: <Widget> [
                Container(
                    width:235,
                    child: Text('Q1', style: TextStyle(fontSize:18)), alignment: Alignment.centerLeft
                ),
                Align(child: Icon(Icons.arrow_downward), alignment: Alignment.centerRight),
              ],
            ),

          ),
        ),

        SizedBox(
          height: 30,
        ),
        Container(
          width: 295,
          height: 65,

          child:
          RaisedButton(
            elevation: 8.0,
            // shape: Border.all(color: Colors.amber, width: 1.0),
            shape: RoundedRectangleBorder(  borderRadius: BorderRadius.circular(20.0), side: BorderSide(color: Colors.orangeAccent, width: 1.5
            ),
            ),
            color:Color.fromRGBO(200, 200, 200, 0.4),

            // Text('Acceleration', style: TextStyle(fontSize:18)),




            textColor: Colors.black54,
            splashColor: Colors.orange,
            //padding: EdgeInsets.symmetric(vertical: 30, horizontal: 100),
            onPressed: (){
              myDialog.info(context, "What to do if my steering wheel will not turn?", "This is a sample answer for question 1.. trying to see if the format is correct sample answer only");

            },
            child: Row(
              children: <Widget> [
                Container(
                    width:235,
                    child: Text('Q1', style: TextStyle(fontSize:18)), alignment: Alignment.centerLeft
                ),
                Align(child: Icon(Icons.arrow_downward), alignment: Alignment.centerRight),
              ],
            ),

          ),
        ),

        SizedBox(
          height: 30,
        ),
        Container(
          width: 295,
          height: 65,

          child:
          RaisedButton(
            elevation: 8.0,
            // shape: Border.all(color: Colors.amber, width: 1.0),
            shape: RoundedRectangleBorder(  borderRadius: BorderRadius.circular(20.0), side: BorderSide(color: Colors.orangeAccent, width: 1.5
            ),
            ),
            color:Color.fromRGBO(200, 200, 200, 0.4),

            // Text('Acceleration', style: TextStyle(fontSize:18)),




            textColor: Colors.black54,
            splashColor: Colors.orange,
            //padding: EdgeInsets.symmetric(vertical: 30, horizontal: 100),
            onPressed: (){
              myDialog.info(context, "What to do if my steering wheel will not turn?", "This is a sample answer for question 1.. trying to see if the format is correct sample answer only");

            },
            child: Row(
              children: <Widget> [
                Container(
                    width:235,
                    child: Text('Q1', style: TextStyle(fontSize:18)), alignment: Alignment.centerLeft
                ),
                Align(child: Icon(Icons.arrow_downward), alignment: Alignment.centerRight),
              ],
            ),

          ),
        ),

        ],

    ),
      ),
    ),

    );
  }
}

class AccelerationRoute extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ - Acceleration'),
        automaticallyImplyLeading: true,
        leading: IconButton(icon: Icon(Icons.arrow_back),
            onPressed:() => Navigator.pop(context, false)),
        // onPressed() => Navigator.pop(false),
        backgroundColor: Colors.grey,
        centerTitle: true,
      ),

    );
  }
}

class OnRoute extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ - Turning on Car'),
        automaticallyImplyLeading: true,
        leading: IconButton(icon: Icon(Icons.arrow_back),
            onPressed:() => Navigator.pop(context, false)),
        // onPressed() => Navigator.pop(false),
        backgroundColor: Colors.grey,
        centerTitle: true,
      ),

    );
  }
}
class BreakingRoute extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ - Breaking'),
        automaticallyImplyLeading: true,
        leading: IconButton(icon: Icon(Icons.arrow_back),
            onPressed:() => Navigator.pop(context, false)),
        // onPressed() => Navigator.pop(false),
        backgroundColor: Colors.grey,
        centerTitle: true,
      ),

    );
  }
}
class CleaningRoute extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ - Cleaning'),
        automaticallyImplyLeading: true,
        leading: IconButton(icon: Icon(Icons.arrow_back),
            onPressed:() => Navigator.pop(context, false)),
        // onPressed() => Navigator.pop(false),
        backgroundColor: Colors.grey,
        centerTitle: true,
      ),

    );
  }
}
