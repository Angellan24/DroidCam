import 'package:DroidCam/connect.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

class Create extends StatefulWidget {
  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  var _nameController = new TextEditingController();
  var _passwordController = new TextEditingController();
  var _addressController = new TextEditingController();
  var _deviceController = new TextEditingController();
  var _emailController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Successfully Register"),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: new IconThemeData(color: Color(0xFF18D191))),
      body: getBody(),
    );
  }

  Widget getBody() {
    return Form(
        key: _formKey,
        child: ListView(padding: EdgeInsets.all(30), children: <Widget>[
          SizedBox(
            height: 30,
          ),
          TextFormField(
            validator: (String value) {
              if (value.isEmpty) {
                return 'email must be filled';
              }
            },
            controller: _emailController,
            decoration: InputDecoration(
              hintText: "Email",
              errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15.0),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          TextFormField(
            validator: (String value) {
              if (value.isEmpty) {
                return 'email must be filled';
              }
            },
            obscureText: true,
            controller: _passwordController,
            decoration: InputDecoration(
              hintText: "Password",
              errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15.0),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          TextFormField(
            validator: (String value) {
              if (value.isEmpty) {
                return ' name must be filled';
              }
            },
            controller: _nameController,
            decoration: InputDecoration(
              errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15.0),
              hintText: "Name",
            ),
          ),
          SizedBox(
            height: 30,
          ),
          TextFormField(
            validator: (String value) {
              if (value.isEmpty) {
                return 'address name must be filled';
              }
            },
            controller: _addressController,
            decoration: InputDecoration(
              errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15.0),
              hintText: "Address",
            ),
          ),
          SizedBox(
            height: 30,
          ),
          TextFormField(
            validator: (String value) {
              if (value.isEmpty) {
                return 'device name must be filled';
              }
            },
            controller: _deviceController,
            decoration: InputDecoration(
              hintText: "Device",
              errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15.0),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            decoration: new BoxDecoration(
                color: Color(0xFF18D191),
                borderRadius: new BorderRadius.circular(9.0)),
            child: FlatButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _addUser();
                  }
                },
                child: Text(
                  "Done",
                )),
          )
        ]));
  }

  _addUser() async {
    var response = await http.post(Uri.encodeFull(

        //laravel api

        "http://192.168.0.25:8000/api/auth/register"), headers: {
      "Accept": "application/json"
    }, body: {
      "name": _nameController.text,
      "email": _emailController.text,
      "password": _passwordController.text,
      "address": _addressController.text,
      "device": _deviceController.text,
    });
    var data = json.decode(response.body);
    print(data);
    var alert = new AlertDialog(
      title: new Text("Successfully Created Account"),
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
