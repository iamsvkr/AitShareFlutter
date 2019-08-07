import 'dart:async';
import 'package:aitshare/ui/home_screen.dart';
import 'package:aitshare/ui/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static String tag = 'login-page';
  @override
  LoginScreenState createState() => new LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {

  BuildContext mCtx;
  final _id = TextEditingController();
  final _password = TextEditingController();

  login(){
    String id = _id.text;
    String password = _password.text;

    Firestore.instance.collection("login").document(id).get().then((snapshot){
      if(snapshot.exists){
        var fId = snapshot.data['id'];
        var fPassword = snapshot.data['password'];

        if(fId==id && fPassword==password){
          print("login complete");
          return "success";
        }else{
          return "fail";
        }
      }
    }).then((value) async {
      if(value=="success"){
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("userState", "login");
        await prefs.setString("id", id);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
      }else{
        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
      }
    });
  }

  signup(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
  }

  @override
  void initState() {
    super.initState();
    mCtx = context;
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

    final id = TextFormField(
      controller: _id,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Id',
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      controller: _password,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          login();
        },
        padding: EdgeInsets.all(12),
        color: Color(0xFF333466),
        child: Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    );

    final signupButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          signup();
        },
        padding: EdgeInsets.all(12),
        color: Color(0xFF333466),
        child: Text('Sign Up', style: TextStyle(color: Colors.white)),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
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
            id,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
            SizedBox(height: 0.0),
            signupButton,
            forgotLabel
          ],
        ),
      ),
    );
  }
}

// class LoginScreen extends StatefulWidget{
//   @override
//   State<StatefulWidget> createState() {
//     return LoginScreenState();
//   }
// }

// class LoginScreenState extends State<LoginScreen>{
  
//   BuildContext mCtx;
//   final _id = TextEditingController();
//   final _password = TextEditingController();

//   login(){
//     String id = _id.text;
//     String password = _password.text;

//     Firestore.instance.collection("login").document(id).get().then((snapshot){
//       if(snapshot.exists){
//         var fId = snapshot.data['id'];
//         var fPassword = snapshot.data['password'];

//         if(fId==id && fPassword==password){
//           print("login complete");
//           return "success";
//         }else{
//           return "fail";
//         }
//       }
//     }).then((value) async {
//       if(value=="success"){
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         await prefs.setString("userState", "login");
//         Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
//       }else{
//         Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
//       }
//     });
//   }

//   signup(){
//     Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
//   }

//   @override
//   void initState() {
//     super.initState();
//     mCtx = context;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: Container(
//         child: Center(
//           child: Column(
//             children: <Widget>[
        
//               TextFormField(
//                 controller: _id,
//                 decoration: InputDecoration(
//                   labelText: 'Enter your id',
//                 ),
//               ),
//               TextFormField(
//                 controller: _password,
//                 decoration: InputDecoration(
//                   labelText: 'Enter your password'
//                 ),
//               ),
//               Container(
//                 child: RaisedButton(
//                   onPressed: (){
//                     login();
//                   },
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
//                   color: Colors.blueGrey,
//                   child: Container(
//                     padding: EdgeInsets.only(left: 30.0, right: 30.0),
//                     child: Text("Login", style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500
//                       ),
//                     )
//                   ),
//                 ),
//               ),

//               Container(
//                 child: RaisedButton(
//                   onPressed: (){
//                     signup();
//                   },
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
//                   color: Colors.blueGrey,
//                   child: Container(
//                     padding: EdgeInsets.only(left: 20.0, right: 20.0),
//                     child: Text("Sign Up", style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500
//                       ),
//                     )
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

// }