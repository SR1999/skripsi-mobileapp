import 'package:flutter/material.dart';
import 'main.dart';


class AdminPage extends StatelessWidget{

AdminPage({required this.username});
final String username;

final Map<String, WidgetBuilder> routes = {
  '/MyHomePage': (BuildContext context) => MyHomePage(),
};
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Welcome Admin"),),
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