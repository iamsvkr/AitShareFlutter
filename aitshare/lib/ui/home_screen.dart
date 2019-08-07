import 'dart:async';
import 'package:aitshare/ui/list_page.dart';
import 'package:aitshare/ui/login_screen.dart';
import 'package:aitshare/ui/signup_screen.dart';
import 'package:aitshare/ui/upload_books.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen>{

  logOut() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("userState", "logOut");
    await prefs.setString("id", null);
    Navigator.pop(context);
  }

  sell() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.get("userState")=="login"){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UploadBooks()),
      );
    }else{
      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF333466),
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.amber,
      ),

      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text(""),
              decoration: BoxDecoration(
                color: Colors.amber,
              ),
            ),
            ListTile(
              leading: Icon(Icons.add_shopping_cart),
              title: Text('Sell'),
              onTap: () {
                sell();
              },
            ),
            ListTile(
              leading: Icon(Icons.lock_open),
              title: Text('LogOut'),
              onTap: () {
                logOut();
              },
            ),
          ],
        ),
      ),

      body: ListPage(),
    );
  }

}
