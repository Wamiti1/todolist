import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist/auth/authentication.dart';
import 'package:todolist/screens/home.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool hasid = prefs.containsKey('email'); 
  runApp(
    MyWidget(hasid: hasid)
  );
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key, required this.hasid});
  final bool hasid;

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
    title: 'To Do List App',
    debugShowCheckedModeBanner: false,    
    theme: FlexThemeData.light(scheme: FlexScheme.hippieBlue,),
    darkTheme: FlexThemeData.dark(scheme: FlexScheme.hippieBlue, darkIsTrueBlack: true),
    home : hasid ? const Home() : const Authentication(),
      );
  }
}

