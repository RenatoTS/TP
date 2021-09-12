import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoggedIn = false;
  GoogleSignInAccount _userObj;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("DemoGoogleOauth"),
        backgroundColor: Colors.black38,
      ),
      body: Container(
        child: _isLoggedIn
            ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        height: 100.0,
                        child: Image.network(_userObj.photoUrl))
                    ),
                    SizedBox(height: 15.0,),
                    Text('Usuario: '+_userObj.displayName, style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),),
                    SizedBox(height: 15.0,),
                    Text('Correo: '+_userObj.email, style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),),
                    SizedBox(height: 15.0,),
                    ElevatedButton(
                     style: ElevatedButton.styleFrom(
                        primary: Colors.black38,
                        padding: EdgeInsets.symmetric(
                          horizontal: 30, 
                          vertical: 10
                        ),
                        textStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                        onPressed: () {
                          _googleSignIn.signOut().then((value) {
                            setState(() {
                              _isLoggedIn = false;
                            });
                          }).catchError((e) {});
                        },
                        child: Text("Salir", style: TextStyle(
                          fontSize: 20.0,
                          )
                        )
                    )],
                ),
            )
            : Center(
                child: ElevatedButton(
                  
                  child: Text("Login con Google", style: TextStyle(
                    fontSize: 20.0,
                  ),),
                  onPressed: () {
                    _googleSignIn.signIn().then((userData) {
                      setState(() {
                        _isLoggedIn = true;
                        _userObj = userData;
                      });
                    }).catchError((e) {
                      print(e);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                        primary: Colors.black38,
                        padding: EdgeInsets.symmetric(
                          horizontal: 30, 
                          vertical: 10
                        ),
                  )
                ),
              ),
      ),
    );
  }
}