import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:device_info/device_info.dart';
import 'register.dart';

String deviceID='';

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


Future<String> _login() async{
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
    deviceID = androidInfo.androidId;
    // Store the device model in your variable or use it as needed
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
    deviceID = iosInfo.identifierForVendor;
    // Store the device model in your variable or use it as needed
  }
  final response = await http.post(Uri.parse("http://10.0.2.2/api/login.php"), body: {
    "username": user.text,
    "password": pass.text,
    "device_id": deviceID

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