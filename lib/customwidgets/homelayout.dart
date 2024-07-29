import 'package:flutter/material.dart';

Padding row (IconButton icon, Text text){
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
      children: [
        Expanded(flex:1,child: icon),
        Expanded(flex:5, child: text)
      ],),
    
    );
}    