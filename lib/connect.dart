import 'dart:convert';

import 'package:DroidCam/createuser.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'welcome.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _emailController = new TextEditingController();

  var _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    _getLogin(
      String email,
      String password,
    ) async {
      var response = await http.post(
        Uri.encodeFull("http://192.168.0.25:8000/api/auth/login"),
        headers: {"Accept": "application/json"},
        body: {
          "email": _emailController.text,
          "password": _passwordController.text,
        },
      );

      var status = response.body.contains('error');
      var data = json.decode(response.body);
      // print(data);
      if (status) {
        print(
            'data: data["Error: Incorrect Username or Password. Please try again."]');
        var alert = new AlertDialog(
          title: new Text("Error"),
          content:
              new Text("Incorrect Username or Password. Please try again."),
        );
        showDialog(context: context, child: alert);
      } else {
        print(data['user']);
        print("Token: " + data['access_token']);
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString('token', data['access_token']);
        localStorage.setString('user', json.encode(data['user']));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return WelcomePage();
            },
          ),
        );
      }
    }

    return new Scaffold(
      appBar: new AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: new IconThemeData(color: Color(0xFF18D191))),
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
                    "DroidCam Pro",
                    style: new TextStyle(fontSize: 30.0),
                  ),
                )
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
              child: new TextField(
                controller: _emailController,
                decoration: new InputDecoration(labelText: 'Email'),
              ),
            ),
            new SizedBox(
              height: 15.0,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
              child: new TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: new InputDecoration(labelText: 'Password'),
              ),
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
                        _getLogin(
                            _emailController.text, _passwordController.text);
                      },
                      child: new Container(
                          alignment: Alignment.center,
                          height: 60.0,
                          decoration: new BoxDecoration(
                              color: Color(0xFF18D191),
                              borderRadius: new BorderRadius.circular(9.0)),
                          child: new Text("Login",
                              style: new TextStyle(
                                  fontSize: 20.0, color: Colors.white))),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                child: new Container(
                    alignment: Alignment.center,
                    height: 60.0,
                    decoration: new BoxDecoration(
                        color: Color(0xFF18D191),
                        borderRadius: new BorderRadius.circular(9.0)),
                    child: new Text("Forgot Password?",
                        style: new TextStyle(
                            fontSize: 20.0, color: Colors.white))),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Create(),
                            ));
                      },
                      child: new Text("Create A New Account ",
                          style: new TextStyle(
                              fontSize: 17.0,
                              color: Color(0xFF18D191),
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
