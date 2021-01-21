import 'dart:convert';

import 'package:DroidCam/drawer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'connect.dart';
import 'drop.dart';
import 'package:http/http.dart' as http;

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  var userData;
  var _nameController = new TextEditingController();
  var _addressController = new TextEditingController();
  var _deviceController = new TextEditingController();
  void logOut() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('user');
    localStorage.remove('access_token');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LoginPage();
        },
      ),
    );
  }

  void delete() async {
    var response = await http.delete(
      Uri.encodeFull(
          //  "https://petility.000webhostapp.com/Login.php?PSEUDO=${pseudo}"),
          //laravel api

          "http://192.168.0.25:8000/api/auth/delete/${userData['id']}"),
      headers: {"Accept": "application/json"},
    );

    var status = response.body.contains('Fail');
    var data = json.decode(response.body);
    print(data['user']);
    print(data);
    if (status) {
      print('delete fail');
      var alert = new AlertDialog(
        title: new Text("Cant Delete Account"),
      );
      showDialog(context: context, child: alert);
    } else {
      print(data['user']);
      print('User deleted');
      var alert = new AlertDialog(
        title: new Text("Account Deleted"),
      );
      showDialog(context: context, child: alert);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return LoginPage();
          },
        ),
      );
    }
  }

  @override
  void initState() {
    _getUserInfo();

    super.initState();
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.reload();
    var userJson = localStorage.getString('user');
    var user = json.decode(userJson);

    setState(() {
      userData = user;

      print(userData);
    });
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: new IconThemeData(
          color: Color(0xFF18D191),
        ),
      ),
      drawer: DrawerProfile(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Stack(
              alignment: Alignment.center,
              children: <Widget>[
                new Container(
                  height: 60.0,
                  width: 60.0,
                  decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(50.0),
                      color: Color(0xFF18D191)),
                  child: new Icon(
                    Icons.local_see,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 80.0),
                  child: new Text(
                    "Hello Welcome & Enjoy",
                    style: new TextStyle(fontSize: 30.0),
                  ),
                )
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DropDown(),
                            ));
                      },
                      child: new Container(
                          alignment: Alignment.center,
                          height: 60.0,
                          decoration: new BoxDecoration(
                              color: Color(0xFF18D191),
                              borderRadius: new BorderRadius.circular(9.0)),
                          child: new Text("Connect To Wifi",
                              style: new TextStyle(
                                  fontSize: 20.0, color: Colors.white))),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
