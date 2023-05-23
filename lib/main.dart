import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:device_info/device_info.dart';
import 'register.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'dart:core';

String deviceID='';
String msg='';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build (BuildContext context){
    return new MaterialApp(
      title: 'Sistem Presensi',
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


Future<void> _login() async{
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
    deviceID = androidInfo.androidId;
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
    deviceID = iosInfo.identifierForVendor;
  }

  final response = await http.post(Uri.parse("http://10.0.2.2/api/login.php"), body: {
    "username": user.text,
    "password": pass.text,
    "device_id": deviceID,
  });

  var datauser = json.decode(response.body);
  setState(() {
    if (datauser.length == 0) {
      msg = 'login gagal';
    } else {
      if (datauser[0]['role'] == '1') {
        print('admin');
      } else if (datauser[0]['role'] == '2') {
        print('member');
      }
    }
  });
  print(datauser);
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
                onPressed:() async{
                  await _login();
                }
              ),
              Text(msg,style: TextStyle(fontSize: 20.0,color: Colors.red),),
              Text("Belum Punya Akun?",style: TextStyle(fontSize: 12.0),),
              TextButton(
                  child: Text("Tekan Disini"),
                  onPressed:(){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SecondPage()),);
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}