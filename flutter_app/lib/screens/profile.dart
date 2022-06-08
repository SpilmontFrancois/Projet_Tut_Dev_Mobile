import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/network_utils/api.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:flutter_app/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late dynamic user = {};
  TextEditingController usernameController = TextEditingController(text: '');
  TextEditingController lastnameController = TextEditingController(text: '');
  TextEditingController firstnameController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController bioController = TextEditingController(text: '');
  TextEditingController avatarController = TextEditingController(text: '');

  @override
  void initState() {
    _loadUser();
    super.initState();
  }

  _loadUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      user = jsonDecode(localStorage.getString('user')!);
      usernameController.text = user['username'] ?? '';
      lastnameController.text = user['lastname'] ?? '';
      firstnameController.text = user['firstname'] ?? '';
      emailController.text = user['email'] ?? '';
      bioController.text = user['bio'] ?? '';
      avatarController.text = user['avatar'] ?? '';
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
                      controller: usernameController,
                      style: const TextStyle(color: Color(0xFF2A194D)),
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.text,
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
                        usernameController.text = value;
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
                      controller: lastnameController,
                      style: const TextStyle(color: Color(0xFF2A194D)),
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.text,
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
                        lastnameController.text = value;
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
                      controller: firstnameController,
                      style: const TextStyle(color: Color(0xFF2A194D)),
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.text,
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
                        firstnameController.text = value;
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
                      controller: emailController,
                      style: const TextStyle(color: Color(0xFF2A194D)),
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.text,
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
                        emailController.text = value;
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
                      controller: bioController,
                      style: const TextStyle(color: Color(0xFF2A194D)),
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.text,
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
                        bioController.text = value;
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
                      controller: avatarController,
                      style: const TextStyle(color: Color(0xFF2A194D)),
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.text,
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
                        avatarController.text = value;
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
    var usr = {
      'username': usernameController.text,
      'lastname': lastnameController.text,
      'firstname': firstnameController.text,
      'email': emailController.text,
      'bio': bioController.text,
      'avatar': avatarController.text,
    };
    var res = await Network().updateData('/users/${user['id']}', data: usr);
    if (res.statusCode == 201) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString(
          'user', json.encode(json.decode(res.body)['data']));
    }
  }
}
