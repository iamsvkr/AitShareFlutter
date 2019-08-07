import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class DescriptionPage extends StatefulWidget{

  final DocumentSnapshot documentSnapshot;

  DescriptionPage({this.documentSnapshot});

  @override
  State<StatefulWidget> createState() {
    return _DescriptionPageState();
  }
}

class _DescriptionPageState extends State<DescriptionPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF333466),
      appBar: AppBar(
        title: Text("Details"),
        backgroundColor: Colors.amber,
      ),
      body: Container(
        height: 630,
        width: 360,
        margin: EdgeInsets.symmetric(vertical: 30.0, horizontal: 35.0),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(30.0)
        ),
        child: Center(
          child: ListView(
            children: <Widget>[
              Container(
                alignment: FractionalOffset.topLeft,
                margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                child: Text(widget.documentSnapshot.data['name'], style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white
                ),),
              ),
              Container(
                alignment: FractionalOffset.topLeft,
                margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                child: Text(widget.documentSnapshot.data['number'], style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white
                ),),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 50.0),
                child: Text("DESCRIPTION", style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.white
                ),),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                child: Text(widget.documentSnapshot.data['description'], style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.white
                ),),
              ),
            ],
          ),
        ),
      )
    );
    // return Container(
    //   child: Card(
    //     child: ListTile(
    //       title: Text(widget.documentSnapshot.data['description']),
    //     ),
    //   ),
    // );
  }

}