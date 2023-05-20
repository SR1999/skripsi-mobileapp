import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build (BuildContext context){
    return new MaterialApp(
      title: '',
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget{
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{

TextEditingController user = new TextEditingController();
TextEditingController pass = new TextEditingController();

Future<String> _login() async{
  final response = await http.post(Uri.parse("http://10.0.2.2/api/login.php"), body: {
    "username": user.text,
    "password": pass.text,
  });
  print(response.body);
  return response.body;
}

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Login Sistem Presensi"),),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text("Username",style: TextStyle(fontSize: 18.0),),
              TextField(
                controller: user,
                decoration: InputDecoration(
                  hintText: 'username'
                ),
              ),
              Text("Password",style: TextStyle(fontSize: 18.0),),
              TextField(
                controller: pass,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: 'password'
                ),
              ),

              TextButton(
                child: Text("Login"),
                onPressed:(){
                _login();
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}