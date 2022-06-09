import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/login.dart';
import 'package:flutter_app/network_utils/api.dart';
import 'package:flutter_app/screens/post.dart';
import 'package:flutter_app/screens/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_moment/simple_moment.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  List<dynamic> feed = [];
  TextEditingController contentController = TextEditingController(text: '');

  @override
  void initState() {
    Moment.setLocaleGlobally(LocaleFr());
    _loadFeed();
    super.initState();
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 200,
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        controller: contentController,
                        style: const TextStyle(color: Color(0xFF2A194D)),
                        cursorColor: Colors.white,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          hintText: "Contenu",
                          hintStyle: TextStyle(
                              color: Color(0xFFC4C4C4),
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Entrez le contenu';
                          }
                          contentController.text = value;
                          return null;
                        },
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 10)),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: const Color(0xFF2A194D),
                                      primary: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                    child: const Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text('Annuler'),
                                    ),
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: const Color(0xFF7C49E9),
                                      primary: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                    ),
                                    onPressed: () => {
                                      _post(),
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const Home()),
                                      )
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text('Poster'),
                                    ),
                                  )
                                ]),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
        backgroundColor: const Color(0xFF7C49E9),
        child: const Icon(Icons.add),
      ),
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
                                    placeholder: 'user image',
                                    image: feed[index]['user']['avatar'] ??
                                        'https://www.waspcom.com/wp-content/uploads/2014/10/user-placeholder-circle-1-300x300.png',
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
                                            Post(post: feed[index])),
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

  void _post() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user_id = json.decode(localStorage.getString('user')!)['id'];
    var post = {
      'user_id': user_id,
      'content': contentController.text,
    };
    var res = await Network().postData('/posts', data: post);
    if (res.statusCode == 200) {
      setState(() {
        contentController.text = '';
      });
    }
  }
}
