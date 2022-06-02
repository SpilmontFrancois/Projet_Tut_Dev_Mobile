import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/login.dart';
import 'package:flutter_app/network_utils/api.dart';
import 'package:flutter_app/screens/post.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_moment/simple_moment.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  String username = '';
  List<dynamic> feed = [];

  @override
  void initState() {
    Moment.setLocaleGlobally(LocaleFr());
    _loadUserData();
    _loadFeed();
    super.initState();
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      setState(() {
        username = user['username'];
      });
    }
  }

  _loadFeed() async {
    var response = await Network().getData('/posts');
    var jsonData = json.decode('[${response.body}]');
    setState(() {
      feed = jsonData[0]['data'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: feed.length,
                itemBuilder: (context, index) {
                  return Card(
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
                                    image: feed[index]['user']['avatar'],
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                                Text(
                                  Moment.now().from(DateTime.parse(
                                      feed[index]['created_at'])),
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
                                  feed[index]['user']['name'],
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
                                feed[index]['content'],
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
                                  feed[index]['stars'].toString(),
                                  style: const TextStyle(
                                    color: Color(0xFF7C49E9),
                                    fontSize: 20,
                                  ),
                                ),
                                onPressed: () {
                                  star(feed[index]['id']);
                                },
                              ),
                              TextButton.icon(
                                icon: const Icon(
                                  Icons.share_outlined,
                                  color: Color(0xFF7C49E9),
                                ),
                                label: Text(
                                  feed[index]['shares'].toString(),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF7C49E9),
                                  ),
                                ),
                                onPressed: () {
                                  share(feed[index]['id']);
                                },
                              ),
                              TextButton.icon(
                                icon: const Icon(
                                  Icons.chat_bubble_outline_rounded,
                                  color: Color(0xFF7C49E9),
                                ),
                                label: Text(
                                  feed[index]['comments'].toString(),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF7C49E9),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Post(id: feed[index]['id'])),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
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

  void star(id) async {
    var res = await Network().postData('/star/$id');
    if (res.statusCode == 200) {
      _loadFeed();
    }
  }

  void share(id) async {
    var res = await Network().postData('/share/$id');
    if (res.statusCode == 200) {
      _loadFeed();
    }
  }
}
