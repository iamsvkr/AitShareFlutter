import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UploadBooks extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _UploadBooksState();
  }
}

class _UploadBooksState extends State<UploadBooks>{

  String pass = "shiv";
  BuildContext mCtx;

  final _id = TextEditingController();
  final _name = TextEditingController();
  final _description = TextEditingController();
  final _price = TextEditingController();
  final _number = TextEditingController();

  @override
  void initState() {
    super.initState();
    mCtx = this.context;
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset("images/share.png"),
      ),
    );

    final fId = TextFormField(
      controller: _id,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'college Id',
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final fName = TextFormField(
      controller: _name,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Name',
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final fDescription = TextFormField(
      controller: _description,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Description',
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    
    final fPrice = TextFormField(
      controller: _price,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Price',
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final fNumber = TextFormField(
      controller: _number,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Mobile Number',
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final submit = Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          _performSubmit();
        },
        padding: EdgeInsets.all(12),
        color: Color(0xFF333466),
        child: Text('Submit', style: TextStyle(color: Colors.white)),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            fId,
            SizedBox(height: 8.0),
            fName,
            SizedBox(height: 8.0),
            fDescription,
            SizedBox(height: 8.0),
            fPrice,
            SizedBox(height: 8.0),
            fNumber,
            SizedBox(height: 24.0),
            submit,
          ],
        ),
      ),
    );
  }

  void _performSubmit(){
    String id = _id.text;
    String name = _name.text;
    String description = _description.text;
    String price = _price.text;
    String number = _number.text;

    Firestore.instance.collection("list").document(id).setData({
      "id" : id,
      "name" : name,
      "description" : description,
      "price" : price,
      "number" : number
    },merge: true).whenComplete((){
      print("data added");
      Navigator.pop(mCtx);
    }).catchError((e){
      print("Error ****************************"+e);
    });
  }
}