import 'package:flutter/material.dart';
import 'login_page.dart';
import 'auth.dart';
import 'home_page.dart';

class RootPage extends StatefulWidget{
  RootPage({this.auth});
  final BaseAuth auth;
  @override
  State createState() {
    return new _RootPageState();
  }
}

enum AuthStatus{
  signedIn,
  notSigned
}

class _RootPageState extends State<RootPage>{

  AuthStatus authStatus = AuthStatus.notSigned;

  @override
  void initState() {
    super.initState();
    widget.auth.currentUser().then((userId){
      setState(() {
        authStatus = userId == null? AuthStatus.notSigned: AuthStatus.signedIn;
      });
    });
  }

  void _signedIn(){
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut(){
    setState(() {
      authStatus = AuthStatus.notSigned;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (authStatus == AuthStatus.notSigned){
      return new LoginPage(auth: widget.auth, onSignedIn: _signedIn);
    }
    else if(authStatus == AuthStatus.signedIn){
      return new HomePage(auth: widget.auth, onSignedOut: _signedOut);
    }
  }
}