import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/network_utils/api.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:flutter_app/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_moment/simple_moment.dart';

class Post extends StatefulWidget {
  const Post({Key? key, required this.post}) : super(key: key);

  final dynamic post;

  @override
  PostState createState() => PostState();
}

class PostState extends State<Post> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late dynamic comments;
  late int stars;
  late int shares;

  @override
  void initState() {
    stars = widget.post['stars'];
    shares = widget.post['shares'];
    _loadPostComments();
    super.initState();
  }

  _loadPostComments() async {
    var response =
        await Network().getData('/post_comments/${widget.post['id']}');
    var jsonData = json.decode('[${response.body}]');
    setState(() {
      comments = jsonData[0]['data'];
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
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const Profile()),
                  // );
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
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: FadeInImage.assetNetwork(
                              placeholder: 'user.png',
                              image: widget.post['user']['avatar'],
                              width: 50,
                              height: 50,
                            ),
                          ),
                          Text(
                            Moment.now().from(
                                DateTime.parse(widget.post['created_at'])),
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ]),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.post['user']['name'],
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]),
                    const Padding(padding: EdgeInsets.only(top: 15)),
                    Row(
                      children: <Widget>[
                        Text(
                          widget.post['content'],
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        TextButton.icon(
                          icon: const Icon(
                            Icons.star_border_sharp,
                            color: Color(0xFF7C49E9),
                          ),
                          label: Text(
                            stars.toString(),
                            style: const TextStyle(
                              color: Color(0xFF7C49E9),
                              fontSize: 20,
                            ),
                          ),
                          onPressed: () {
                            star(widget.post['id']);
                          },
                        ),
                        TextButton.icon(
                          icon: const Icon(
                            Icons.share_outlined,
                            color: Color(0xFF7C49E9),
                          ),
                          label: Text(
                            shares.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              color: Color(0xFF7C49E9),
                            ),
                          ),
                          onPressed: () {
                            share(widget.post['id']);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
                color: const Color(0xFFF7F3FE),
                child: Column(children: <Widget>[
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[
                      Text(
                        'Commentaires',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ]))
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

  void star(id) async {
    var res = await Network().postData('/star/$id');
    if (res.statusCode == 200) {
      setState(() {
        stars = json.decode('[${res.body}]')[0]['data']['stars'];
      });
    }
  }

  void share(id) async {
    var res = await Network().postData('/share/$id');
    if (res.statusCode == 200) {
      setState(() {
        shares = json.decode('[${res.body}]')[0]['data']['shares'];
      });
    }
  }
}
