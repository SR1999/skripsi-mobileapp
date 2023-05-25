import 'package:flutter/material.dart';
import 'main.dart';


class MemberPage extends StatelessWidget{

  MemberPage({required this.username});
  final String username;

  final Map<String, WidgetBuilder> routes = {
    '/MyHomePage': (BuildContext context) => MyHomePage(),
  };
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Welcome Member"),),
      body: Column(
        children: <Widget>[
          Text('halo $username',style: TextStyle(fontSize: 20.0),),

          TextButton(onPressed: (){
            Navigator.pushReplacementNamed(context, '/MyHomePage');
          }, child: Text("Logout"))
        ],
      ),
    );
  }
}