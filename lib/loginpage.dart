import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test22/db/students_database.dart';
import 'package:test22/homepage.dart';
import 'package:test22/students.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test22/welcomepage.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}

check() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var id = prefs.getString('id');
  var username = prefs.getString('username');
  var _token = prefs.getString('_token');
  print(_token);
  if (_token != null) {
    print("yooo");
    runApp(const MaterialApp(home: Welcomepage()));
  }
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    check();
    super.initState();
  }

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String stats = "";
  String email = "";
  String password = "";

  final Uri _url = Uri.parse("https://mytrapi.ggs-co.com/API/Accounts/Login");
  Students students = Students();
  @override
  Widget build(BuildContext context) {
    void pagepush() {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext ctx) => Welcomepage()));
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("login page"),
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomePage(
                            title: 'Home page',
                          )),
                );
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        body: Center(
          child: Form(
            key: formkey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 320,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: "user name",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(color: Colors.grey, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.green, width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter username";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (vlaue) {
                        email = vlaue!;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: 320,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: "password",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(color: Colors.grey, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.green, width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter password";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (vlaue) {
                        password = vlaue!;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    stats,
                    style: const TextStyle(color: Colors.red, fontSize: 15),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: 50,
                    width: 250,
                    child: ElevatedButton.icon(
                        onPressed: () async {
                          setState(() {
                            stats = "";
                          });
                          var formndata = formkey.currentState;
                          if (formndata!.validate()) {
                            formndata.save();
                            Map data = {"email": email, "password": password};
                            var json = jsonEncode(data);

                            var response = await http.post(_url,
                                body: json,
                                headers: {'content-type': 'application/json'});

                            if (response.statusCode == 200) {
                              var responsebudy = jsonDecode(response.body);
                              print(responsebudy);
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setString(
                                  'id', "${responsebudy["id"]}");
                              await prefs.setString(
                                  'username', responsebudy["fullName"]);
                              await prefs.setString(
                                  '_token', responsebudy["token"]);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext ctx) =>
                                          Welcomepage()));
                            } else if (response.statusCode == 401) {
                              print("wrong name or password");
                              stats = "Wrong email or password";
                            } else {
                              print("something wrong happend");
                            }
                          }

                          setState(() {});
                        },
                        icon: const Icon(Icons.login),
                        label: const Text("Login")),
                  ),
                ]),
          ),
        ));
  }
}


    // HttpClient httpclient = HttpClient();
    //                         HttpClientRequest httprequest =
    //                             await httpclient.postUrl(Uri.parse(
    //                                 "https://mytrapi.ggs-co.com/API/Accounts/Login"));
    //                         httprequest.headers
    //                             .set('content-type', 'application/json');
    //                         httprequest.add(utf8.encode(json.encode(data)));
    //                         HttpClientResponse response =
    //                             await httprequest.close();
    //                         String reply =
    //                             await response.transform(utf8.decoder).join();
    //                         httpclient.close();