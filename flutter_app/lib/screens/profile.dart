import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/network_utils/api.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:flutter_app/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_moment/simple_moment.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late dynamic user = {};

  @override
  void initState() {
    _loadUser();
    super.initState();
  }

  _loadUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      user = jsonDecode(localStorage.getString('user')!);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        actions: <Widget>[
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: IconButton(
                icon: const Icon(Icons.home),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: IconButton(
                icon: const Icon(Icons.person),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Profile()),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  logout();
                },
              ),
            ),
          ),
        ],
        backgroundColor: const Color(0xFF7C49E9),
      ),
      body: Container(
        color: const Color(0xFFF7F3FE),
        child: Column(
          children: <Widget>[
            Card(
              elevation: 4.0,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const <Widget>[
                        Text(
                          'Profil',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    // throws error but doesn't works without
                    Text(user['username'],
                        style: const TextStyle(
                          color: Colors.transparent,
                        )),
                    Row(
                      children: const <Widget>[
                        Text('Nom d\'utilisateur',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                    TextFormField(
                      style: const TextStyle(color: Color(0xFF2A194D)),
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.text,
                      initialValue: user['username'] ?? '',
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        hintText: "Nom d'utilisateur",
                        hintStyle: TextStyle(
                            color: Color(0xFFC4C4C4),
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Entrez votre nom d\'utilisateur';
                        }
                        user['username'] = value;
                        return null;
                      },
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 10)),
                    Row(
                      children: const <Widget>[
                        Text('Nom',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                    TextFormField(
                      style: const TextStyle(color: Color(0xFF2A194D)),
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.text,
                      initialValue: user['lastname'] ?? '',
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        hintText: "Nom",
                        hintStyle: TextStyle(
                            color: Color(0xFFC4C4C4),
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Entrez votre nom';
                        }
                        user['lastname'] = value;
                        return null;
                      },
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 10)),
                    Row(
                      children: const <Widget>[
                        Text('Prénom',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                    TextFormField(
                      style: const TextStyle(color: Color(0xFF2A194D)),
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.text,
                      initialValue: user['firstname'] ?? '',
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        hintText: "Prénom",
                        hintStyle: TextStyle(
                            color: Color(0xFFC4C4C4),
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Entrez votre prénom';
                        }
                        user['firstname'] = value;
                        return null;
                      },
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 10)),
                    Row(
                      children: const <Widget>[
                        Text('Email',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                    TextFormField(
                      style: const TextStyle(color: Color(0xFF2A194D)),
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.text,
                      initialValue: user['email'] ?? '',
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        hintText: "Email",
                        hintStyle: TextStyle(
                            color: Color(0xFFC4C4C4),
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Entrez votre email';
                        }
                        user['email'] = value;
                        return null;
                      },
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 10)),
                    Row(
                      children: const <Widget>[
                        Text('Biographie',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                    TextFormField(
                      style: const TextStyle(color: Color(0xFF2A194D)),
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.text,
                      initialValue: user['bio'] ?? '',
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        hintText: "Biographie",
                        hintStyle: TextStyle(
                            color: Color(0xFFC4C4C4),
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Entrez votre biographie';
                        }
                        user['bio'] = value;
                        return null;
                      },
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 10)),
                    Row(
                      children: const <Widget>[
                        Text('Avatar',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                    TextFormField(
                      style: const TextStyle(color: Color(0xFF2A194D)),
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.text,
                      initialValue: user['avatar'] ?? '',
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        hintText: "Avatar",
                        hintStyle: TextStyle(
                            color: Color(0xFFC4C4C4),
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Entrez votre avatar';
                        }
                        user['avatar'] = value;
                        return null;
                      },
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 10)),
                    TextButton(
                      onPressed: () => {_updateUser()},
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFF2A194D),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, left: 10, right: 10),
                        child: Text(
                          'Modifier',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void logout() async {
    var res = await Network().postData('/logout');
    if (res.statusCode == 200) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('token');
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    }
  }

  void _updateUser() async {
    var res = await Network().updateData('/users/${user['id']}', data: user);
    if (res.statusCode == 201) {
      print(json.encode(json.decode(res.body)['data']));
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      print(localStorage.getString('user'));
      // localStorage.setString(
      //     'user', json.encode(json.decode(res.body)['data']));
    }
  }
}
