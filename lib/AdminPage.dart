import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

class AdminPage extends StatelessWidget {
  AdminPage({required this.username});

  String username;



  void sendUserInfoToServer(String username) async {
    final url = Uri.parse('http://10.0.2.2/presensi/api/index.php?name=$username');
    final response = await http.get(url);

    if (await canLaunch(url.toString())) {
      await launch(url.toString());
    } else {
      throw 'Could not launch $url';
    }

    if (response.statusCode == 200) {
      print('User information sent successfully');
    } else {
      print('Failed to send user information');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome Admin")),
      body: Column(
        children: <Widget>[
          Text('Halo $username', style: TextStyle(fontSize: 20.0)),
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/MyHomePage');
            },
            child: Text("Logout"),
          ),
          Text(
            'Masuk Website Presensi',
            style: TextStyle(fontSize: 16),
          ),
          TextButton(
            onPressed: () {
              sendUserInfoToServer(username);
            },
            child: Text("Buka Website"),
          ),
        ],
      ),
    );
  }
}

// Future<void> sendUserInfoToServer(username) async {
//   final url = Uri.parse('https://10.0.2.2/api/index.php');
//
//   // Create an HttpClient with a security context that trusts the self-signed certificate
//   final httpClient = HttpClient()
//     ..badCertificateCallback =
//         (X509Certificate cert, String host, int port) => true;
//
//   // Create an IOClient using the configured HttpClient
//   final httpIOClient = http.IOClient(httpClient);
//
//   // Use the httpIOClient for making the HTTP request
//   final response = await httpIOClient.post(url, body: {
//     'name': username
//   });
//
//   if (await canLaunch(url.toString())) {
//     await launch(url.toString());
//   } else {
//     throw 'Could not launch $url';
//   }
//
//   if (response.statusCode == 200) {
//     print('User information sent successfully');
//   } else {
//     print('Failed to send user information');
//   }
// }
