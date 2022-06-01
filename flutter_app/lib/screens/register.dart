import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/network_utils/api.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/screens/login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<Register> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  late String username;
  late String firstname;
  late String lastname;
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: const Color(0xFFF7F3FE),
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Card(
                    elevation: 4.0,
                    color: const Color(0xFF7C49E9),
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 30, bottom: 10, left: 10, right: 10),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            TextFormField(
                              style: const TextStyle(color: Color(0xFF2A194D)),
                              cursorColor: Colors.white,
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                ),
                                hintText: "Username",
                                hintStyle: TextStyle(
                                    color: Color(0xFFC4C4C4),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                              validator: (uname) {
                                if (uname!.isEmpty) {
                                  return 'Please enter your username';
                                }
                                username = uname;
                                return null;
                              },
                            ),
                            const Padding(
                              padding: EdgeInsets.all(5),
                            ),
                            TextFormField(
                              style: const TextStyle(color: Color(0xFF2A194D)),
                              cursorColor: Colors.white,
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                ),
                                hintText: "First name",
                                hintStyle: TextStyle(
                                    color: Color(0xFFC4C4C4),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                              validator: (fname) {
                                if (fname!.isEmpty) {
                                  return 'Please enter your first name';
                                }
                                firstname = fname;
                                return null;
                              },
                            ),
                            const Padding(
                              padding: EdgeInsets.all(5),
                            ),
                            TextFormField(
                              style: const TextStyle(color: Color(0xFF2A194D)),
                              cursorColor: Colors.white,
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                ),
                                hintText: "Last name",
                                hintStyle: TextStyle(
                                    color: Color(0xFFC4C4C4),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                              validator: (lname) {
                                if (lname!.isEmpty) {
                                  return 'Please enter your last name';
                                }
                                lastname = lname;
                                return null;
                              },
                            ),
                            const Padding(
                              padding: EdgeInsets.all(5),
                            ),
                            TextFormField(
                              style: const TextStyle(color: Color(0xFF2A194D)),
                              cursorColor: Colors.white,
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                ),
                                hintText: "Email",
                                hintStyle: TextStyle(
                                    color: Color(0xFFC4C4C4),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                              validator: (emailValue) {
                                if (emailValue!.isEmpty) {
                                  return 'Please enter email';
                                }
                                email = emailValue;
                                return null;
                              },
                            ),
                            const Padding(
                              padding: EdgeInsets.all(5),
                            ),
                            TextFormField(
                              style: const TextStyle(color: Color(0xFF2A194D)),
                              cursorColor: Colors.white,
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                ),
                                hintText: "Password",
                                hintStyle: TextStyle(
                                    color: Color(0xFFC4C4C4),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                              validator: (passwordValue) {
                                if (passwordValue!.isEmpty) {
                                  return 'Please enter your password';
                                }
                                password = passwordValue;
                                return null;
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: const Color(0xFF2A194D),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _register();
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5, bottom: 5, left: 10, right: 10),
                                  child: Text(
                                    _isLoading
                                        ? 'Inscription...'
                                        : 'Créer mon compte',
                                    textDirection: TextDirection.ltr,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Color(0xFF2A194D),
                          width: 1,
                        ),
                        backgroundColor: const Color(0xFFF7F3FE),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()));
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(
                            top: 5, bottom: 5, left: 10, right: 10),
                        child: Text(
                          'J\'ai déjà un compte',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            color: Color(0xFF2A194D),
                          ),
                        ),
                      ),
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

  void _register() async {
    setState(() {
      _isLoading = true;
    });
    var data = {
      'username': username,
      'email': email,
      'password': password,
      'firstname': firstname,
      'lastname': lastname
    };

    var resRegister = await Network().authData(data, '/register');
    var bodyRegister = json.decode(resRegister.body);
    if (resRegister.statusCode == 200) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString(
          'token', json.encode(bodyRegister['access_token']));

      var resUser = await Network().getData('/me');
      var bodyUser = json.decode(resUser.body);
      localStorage.setString('user', json.encode(bodyUser['user']));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }
}
