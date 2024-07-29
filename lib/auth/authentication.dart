import 'package:flutter/material.dart';
import './login.dart';
import './signup.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  var isLogin = true;
  void toggle() => setState(() {
    isLogin = !isLogin;

  });
  
  @override
  Widget build(BuildContext context) {
    return  isLogin ?  Login(onClicked: toggle,) : Register(onClickedSignup: toggle,);
  }
}