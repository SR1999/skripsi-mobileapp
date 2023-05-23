import 'package:flutter/material.dart';
import 'main.dart';

class MemberPage extends StatelessWidget{

MemberPage({required this.username});
final String username;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Welcome Member"),),
    );
  }
}