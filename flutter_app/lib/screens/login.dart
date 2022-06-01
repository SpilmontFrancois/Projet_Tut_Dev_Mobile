import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/network_utils/api.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/screens/register.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  late String email;
  late String password;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        color: const Color(0xFFF7F3FE),
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Image.asset(
                  'assets/people.png',
                  fit: BoxFit.cover,
                ),
                Card(
                  elevation: 4.0,
                  color: const Color(0xFF7C49E9),
                  shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextFormField(
                            style: const TextStyle(color: Color(0xFF2A194D)),
                            cursorColor: Colors.white,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              hintText: "Adresse email",
                              hintStyle: TextStyle(
                                  color: Color(0xFFC4C4C4),
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal),
                            ),
                            validator: (emailValue) {
                              if (emailValue!.isEmpty) {
                                return 'Entrez votre email';
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
                              hintText: "Mot de passe",
                              hintStyle: TextStyle(
                                  color: Color(0xFFC4C4C4),
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal),
                            ),
                            validator: (passwordValue) {
                              if (passwordValue!.isEmpty) {
                                return 'Entrez votre mot de passe';
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
                                  _login();
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, bottom: 5, left: 10, right: 10),
                                child: Text(
                                  _isLoading ? 'Connexion...' : 'Me connecter',
                                  textDirection: TextDirection.ltr,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: Colors.white,
                                  width: 1,
                                ),
                                backgroundColor: const Color(0xFF7C49E9),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Register()));
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(
                                    top: 5, bottom: 5, left: 10, right: 10),
                                child: Text(
                                  'Créer un compte',
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
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
              ],
            )
          ],
        ),
      ),
    );
  }

  void _login() async {
    setState(() {
      _isLoading = true;
    });
    var data = {'email': email, 'password': password};

    var resLogin = await Network().authData(data, '/login');
    var bodyLogin = json.decode(resLogin.body);
    if (resLogin.statusCode == 200) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(bodyLogin['access_token']));

      var resUser = await Network().getData('/me');
      var bodyUser = json.decode(resUser.body);
      localStorage.setString('user', json.encode(bodyUser['user']));

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    } else {
      _showMsg("Login failed");
    }

    setState(() {
      _isLoading = false;
    });
  }
}
