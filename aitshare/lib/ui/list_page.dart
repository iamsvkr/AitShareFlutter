import 'package:aitshare/ui/description_screen.dart';
import 'package:aitshare/ui/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class ListPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ListPageState();
  }
}

class _ListPageState extends State<ListPage>{

  // Future _data;
  var id = null;

  Future getLists() async{
    QuerySnapshot qs = await Firestore.instance.collection("list").getDocuments();
    return qs.documents;
  }

  navigateToDescription(DocumentSnapshot doc){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> DescriptionPage(documentSnapshot : doc)));
  }

  checkNavigateToDescription(DocumentSnapshot doc) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString("userState")=="login"){
      navigateToDescription(doc);
    }else{
      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
    }
  }

  check() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.get("id");
    });
  }

  deleteListId(String id) async{
    await Firestore.instance.collection("list").document(id).delete();
  }

  @override
  void initState() {
    super.initState();
    // _data = getLists();
    check();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getLists(),
        builder: (_, snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(),
          );
        }else{
          var array = List(snapshot.data.length);
          for(int i=0; i<snapshot.data.length; i++){
            if(id==snapshot.data[i].data["id"]){
              array[i] = true;
            }else{
              array[i] = false;
            }
          }
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (_,index){
              return Container(
                margin: EdgeInsets.only(top:5.0, bottom: 5.0, left: 15.0),
                child: Stack(
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        checkNavigateToDescription(snapshot.data[index]);
                      },
                      child: Container(
                        height: 124.0,
                        width : 340.0,
                        margin: EdgeInsets.only(left: 50.0, right: 20.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0.0, 10.0),
                              blurRadius: 10.0
                            )
                          ]
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding : EdgeInsets.only(top: 20.0, ),
                              child: Text("Rs. "+snapshot.data[index].data['price'], style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                                ),
                              ),
                            ),Container(
                              padding : EdgeInsets.only(top: 10.0),
                              child: Text(snapshot.data[index].data['name'], style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 16.0),
                      alignment: FractionalOffset.centerLeft,
                      child: Image(
                        image: AssetImage("images/user.png"),
                        height: 92.0,
                        width: 92.0,
                      ),
                    ),
                    array[index]?
                    GestureDetector(
                      onTap: (){
                        deleteListId(snapshot.data[index].data['id']);
                      },
                      child : Container(
                        margin: EdgeInsets.only(top: 20.0, right: 20.0),
                        alignment: FractionalOffset.centerRight,
                        child: Icon(Icons.delete_forever, size: 80,),
                      )
                    ):Container()
                  ],
                ),
              );
            },
          );
        }
      }),
    );
  }
}