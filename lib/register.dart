import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:device_info/device_info.dart';

String deviceID = '';

class SecondPage extends StatelessWidget {
  TextEditingController newuser = new TextEditingController();
  TextEditingController newpass = new TextEditingController();

  Future<String> _register() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      deviceID = androidInfo.androidId;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
      deviceID = iosInfo.identifierForVendor;
    }

    final response = await http.post(Uri.parse("http://10.0.2.2/api/register.php"), body: {

      "username": newuser.text,
      "password": newpass.text,
      "device_id": deviceID
    });
    print(response.body);
    return response.body;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Registrasi Sistem Presensi"),),
          body: Container(
            child: Center(
              child: Column(
                children: <Widget>[
                Text("Enter new Username",style: TextStyle(fontSize: 18.0),),
                TextField(
                  controller: newuser,
                  decoration: InputDecoration(
                  hintText: 'username'
                ),
              ),
                  Text("Enter new Password",style: TextStyle(fontSize: 18.0),),
                  TextField(
                    controller: newpass,
                    decoration: InputDecoration(
                        hintText: 'password'
                    ),
                  ),
                  TextButton(
                      child: Text("Register"),
                      onPressed:(){
                        _register();
                      }
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
