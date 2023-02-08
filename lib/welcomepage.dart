import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'loginpage.dart';

class Welcomepage extends StatefulWidget {
  const Welcomepage({super.key});

  @override
  State<Welcomepage> createState() => _WelcomepageState();
}

class _WelcomepageState extends State<Welcomepage> {
  Future prefsinit() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('id');
    var username = prefs.getString('username');
    var _token = prefs.getString('_token');
    print(_token);
    if (_token != null) {
      print("welcomepage");
    }
    Map details = {"id": id, "username": username, "_token": _token};
    return details;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder(
            future: prefsinit(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${snapshot.data["id"]}"),
                      Text(snapshot.data["username"]),
                      Text(
                        snapshot.data["_token"],
                        style: const TextStyle(fontSize: 9),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      ElevatedButton.icon(
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.remove('email');
                            prefs.remove('username');
                            prefs.remove('_token');
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext ctx) =>
                                        const Login()));
                          },
                          icon: const Icon(Icons.logout),
                          label: const Text("logout"))
                    ],
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}
