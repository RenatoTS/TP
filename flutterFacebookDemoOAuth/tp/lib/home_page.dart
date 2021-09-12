import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoggedIn = false;
  Map _userObj = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("FbOauthDemo"),
      ),
      body: Container(
        child: _isLoggedIn
            ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: Container(
                        height: 180.0,
                        child: Image.network(_userObj["picture"]["data"]["url"])),
                    ),
                    SizedBox(height: 15.0,),
                    Text('Usuario: '+_userObj["name"], style: TextStyle( fontSize: 25.0, fontWeight: FontWeight.bold)),
                    SizedBox(height: 15.0,),
                    Text('Correo: '+_userObj["email"], style: TextStyle( fontSize: 25.0, fontWeight: FontWeight.bold)),
                    SizedBox(height: 15.0,),
                    ElevatedButton(
                        onPressed: () {
                          FacebookAuth.instance.logOut().then((value) {
                            setState(() {
                              _isLoggedIn = false;
                              _userObj = {};
                            });
                          });
                        },
                        child: Text("Salir", style: TextStyle(fontSize:  20.0),))
                  ],
                ),
            )
            : Center(
                child: ElevatedButton(
                  child: Text("Login con Facebook", style: TextStyle(fontSize:  20.0)),
                  onPressed: () async {
                    FacebookAuth.instance.login(
                        permissions: ["public_profile", "email"]).then((value) {
                      FacebookAuth.instance.getUserData().then((userData) {
                        setState(() {
                          _isLoggedIn = true;
                          _userObj = userData;
                        });
                      });
                    });
                  },
                ),
              ),
      ),
    );
  }
}