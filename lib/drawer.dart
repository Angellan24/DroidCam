import 'dart:convert';

import 'package:DroidCam/connect.dart';
import 'package:DroidCam/welcome.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DrawerProfile extends StatefulWidget {
  @override
  _DrawerProfileState createState() => _DrawerProfileState();
}

class _DrawerProfileState extends State<DrawerProfile> {
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
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Text(
              userData != null ? '${userData['email']}' : '',
              style: TextStyle(color: Colors.black87, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          ListTile(
              leading: Icon(Icons.edit),
              title: Text(userData != null ? '${userData['name']}' : ''),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        scrollable: true,
                        title: Text("Update Name"),
                        content: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Form(
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  controller: _nameController,
                                  decoration: InputDecoration(
                                    labelText: userData != null
                                        ? '${userData['name']}'
                                        : '',
                                    icon: Icon(Icons.edit),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        actions: [
                          RaisedButton(
                              child: Text("Submit"),
                              onPressed: () async {
                                // your code

                                var response = await http.put(Uri.encodeFull(

                                        //laravel api

                                        "http://192.168.0.25:8000/api/auth/updatename/${userData['id']}"),
                                    headers: {
                                      "Accept": "application/json"
                                    },
                                    body: {
                                      "name": _nameController.text,
                                    });

                                var status = response.body.contains('Fail');
                                var data = json.decode(response.body);
                                print(data);
                                if (status) {
                                  print('Update Fail');
                                  var alert = new AlertDialog(
                                    title: new Text("Cant Update Account"),
                                  );
                                  showDialog(context: context, child: alert);
                                } else {
                                  SharedPreferences localStorage =
                                      await SharedPreferences.getInstance();
                                  localStorage.setString(
                                      'user', json.encode(data['user']));
                                  localStorage.reload();
                                  print('Updated Complete');
                                  var alert = new AlertDialog(
                                    title: new Text("Product Updated!"),
                                  );

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return WelcomePage();
                                      },
                                    ),
                                  );
                                  showDialog(context: context, child: alert);
                                }
                              })
                        ],
                      );
                    });
              }),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text(userData != null ? '${userData['address']}' : ''),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      scrollable: true,
                      title: Text("Update Address"),
                      content: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: _addressController,
                                decoration: InputDecoration(
                                  labelText: userData != null
                                      ? '${userData['address']}'
                                      : '',
                                  icon: Icon(Icons.edit),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      actions: [
                        RaisedButton(
                            child: Text("Submit"),
                            onPressed: () async {
                              // your code

                              var response = await http.put(Uri.encodeFull(

                                      //laravel api

                                      "http://192.168.0.25:8000/api/auth/updateaddress/${userData['id']}"),
                                  headers: {
                                    "Accept": "application/json"
                                  },
                                  body: {
                                    "address": _addressController.text,
                                  });

                              var status = response.body.contains('Fail');
                              var data = json.decode(response.body);
                              print(data);
                              if (status) {
                                print('Update Fail');
                                var alert = new AlertDialog(
                                  title: new Text("Cant Update Account"),
                                );
                                showDialog(context: context, child: alert);
                              } else {
                                SharedPreferences localStorage =
                                    await SharedPreferences.getInstance();
                                localStorage.setString(
                                    'user', json.encode(data['user']));
                                localStorage.reload();

                                print('Updated Complete');
                                var alert = new AlertDialog(
                                  title: new Text("Account Updated!"),
                                );

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return WelcomePage();
                                    },
                                  ),
                                );
                                showDialog(context: context, child: alert);
                              }
                            })
                      ],
                    );
                  });
            },
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text(userData != null ? '${userData['device']}' : ''),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      scrollable: true,
                      title: Text("Update Device"),
                      content: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: _deviceController,
                                decoration: InputDecoration(
                                  labelText: userData != null
                                      ? '${userData['device']}'
                                      : '',
                                  icon: Icon(Icons.edit),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      actions: [
                        RaisedButton(
                            child: Text("Submit"),
                            onPressed: () async {
                              // your code

                              var response = await http.put(Uri.encodeFull(

                                      //laravel api

                                      "http://192.168.0.25:8000/api/auth/updatedevice/${userData['id']}"),
                                  headers: {
                                    "Accept": "application/json"
                                  },
                                  body: {
                                    "device": _deviceController.text,
                                  });

                              var status = response.body.contains('Fail');
                              var data = json.decode(response.body);
                              print(data);
                              if (status) {
                                print('Update Fail');
                                var alert = new AlertDialog(
                                  title: new Text("Cant Update Account"),
                                );
                                showDialog(context: context, child: alert);
                              } else {
                                SharedPreferences localStorage =
                                    await SharedPreferences.getInstance();
                                localStorage.setString(
                                    'user', json.encode(data['user']));
                                localStorage.reload();
                                print('Updated Complete');
                                var alert = new AlertDialog(
                                  title: new Text("Account Updated!"),
                                );

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return WelcomePage();
                                    },
                                  ),
                                );
                                showDialog(context: context, child: alert);
                              }
                            })
                      ],
                    );
                  });
            },
          ),
          ListTile(
            leading: Icon(Icons.arrow_back_ios),
            title: Text("Sign out"),
            onTap: logOut,
          ),
          ListTile(
            leading: Icon(Icons.delete),
            title: Text("Delete Account"),
            onTap: delete,
          ),
        ],
      ),
    );
  }
}
