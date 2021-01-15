import 'package:flutter/material.dart';

class faq extends StatefulWidget{
  @override
  _faqState createState() => _faqState();
}

class _faqState extends State<faq>{
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
        backgroundColor: Colors.grey,
        centerTitle: true,
      ),
    );
  }
}