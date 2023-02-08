import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test22/db/students_database.dart';

import 'package:tap_to_expand/tap_to_expand.dart';

Students students = Students();

class Student extends StatefulWidget {
  const Student({Key? key}) : super(key: key);

  @override
  State<Student> createState() => _StudentState();
}

class _StudentState extends State<Student> {
  int age = 0;
  String name = "";
  String adress = "";
  String deparment = "";
  String email = "";
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Future readdata() async {
    var response = await students.readData("SELECT * FROM students");
    return response;
  }

  Future insertdata(int age, String name, String adress, String deparment,
      String email) async {
    await students.insertData(
        """INSERT INTO "students"(name,age,adress,department,email) VALUES("$name",$age,"$adress","$deparment","$email")""");
  }

  @override
  Widget build(BuildContext context) {
    Dialog addstudentDialog = Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0)), //this right here
        child: SingleChildScrollView(
          child: SizedBox(
              height: 800.0,
              width: 400.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 50,
                          child: Text(
                            "Add New Student",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: "Student name",
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide:
                                    BorderSide(color: Colors.green, width: 2),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "please add value";
                              } else {
                                return null;
                              }
                            },
                            onSaved: (vlaue) {
                              name = vlaue!;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 200,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: "Student age",
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide:
                                    BorderSide(color: Colors.green, width: 2),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "please add value";
                              } else {
                                return null;
                              }
                            },
                            onSaved: (vlaue) {
                              age = int.parse(vlaue!);
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 200,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: "Student deparment",
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide:
                                    BorderSide(color: Colors.green, width: 2),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "please add value";
                              } else {
                                return null;
                              }
                            },
                            onSaved: (vlaue) {
                              deparment = vlaue!;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 200,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: "Student email",
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide:
                                    BorderSide(color: Colors.green, width: 2),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "please add value";
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
                          height: 10,
                        ),
                        SizedBox(
                          width: 200,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: "Student adress",
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide:
                                    BorderSide(color: Colors.green, width: 2),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "please add value";
                              } else {
                                return null;
                              }
                            },
                            onSaved: (vlaue) {
                              adress = vlaue!;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 200,
                          height: 50,
                          child: ElevatedButton.icon(
                              onPressed: () {
                                var formndata = formkey.currentState;
                                if (formndata!.validate()) {
                                  formndata.save();
                                  insertdata(age, name, adress, deparment, email);
                                  setState(() {});
                                  Navigator.pop(context);
                                }
                              },
                              icon: const Icon(Icons.add),
                              label: const Text("Add")),
                        )
                      ],
                    ),
                  ),
                ],
              )),
        ));

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Add student'),
        onPressed: () async {
          showDialog(
              context: context,
              builder: (BuildContext context) => addstudentDialog);
        },
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: Studentsearch());
              },
              icon: const Icon(Icons.search))
        ],
        title: const Text("students page"),
      ),
      body: FutureBuilder(
        future: readdata(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          side:
                              const BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                        child: TapToExpand(
                            onTapPadding: 10,
                            closedHeight: 70,
                            scrollable: true,
                            borderRadius: 10,
                            openedHeight: 200,
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "id:  ${snapshot.data[index]["id"]}",
                                  style: const TextStyle(
                                      fontSize: 25, fontFamily: "italic"),
                                ),
                                Text(
                                  "age:  ${snapshot.data[index]["age"]}",
                                  style: const TextStyle(
                                      fontSize: 20, fontFamily: "italic"),
                                ),
                                Text(
                                  "email:  ${snapshot.data[index]["email"]}",
                                  style: const TextStyle(
                                      fontSize: 20, fontFamily: "italic"),
                                ),
                                Text(
                                  "adress:  ${snapshot.data[index]["adress"]}",
                                  style: const TextStyle(
                                      fontSize: 20, fontFamily: "italic"),
                                ),
                              ],
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${snapshot.data[index]["name"]}",
                                  style: const TextStyle(
                                      fontSize: 20, fontFamily: "italic"),
                                ),
                                const SizedBox(
                                  width: 50,
                                ),
                                Text(
                                  "${snapshot.data[index]["department"]}",
                                  style: const TextStyle(
                                      fontSize: 14, fontFamily: "italic"),
                                ),
                              ],
                            ))),
                    const Divider(
                      height: 10,
                    )
                  ],
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class Studentsearch extends SearchDelegate {
  Future searchdata(name) async {
    name ?? "";
    var response = await students.readData("""
  SELECT * FROM students
WHERE "name" LIKE '$name%'

""");
    return response;
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(onPressed: () {}, icon: const Icon(Icons.search))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: searchdata(query),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: TapToExpand(
                          onTapPadding: 10,
                          closedHeight: 70,
                          scrollable: true,
                          borderRadius: 10,
                          openedHeight: 200,
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "id:  ${snapshot.data[index]["id"]}",
                                style: const TextStyle(
                                    fontSize: 25, fontFamily: "italic"),
                              ),
                              Text(
                                "age:  ${snapshot.data[index]["age"]}",
                                style: const TextStyle(
                                    fontSize: 20, fontFamily: "italic"),
                              ),
                              Text(
                                "email:  ${snapshot.data[index]["email"]}",
                                style: const TextStyle(
                                    fontSize: 20, fontFamily: "italic"),
                              ),
                              Text(
                                "adress:  ${snapshot.data[index]["adress"]}",
                                style: const TextStyle(
                                    fontSize: 20, fontFamily: "italic"),
                              ),
                            ],
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${snapshot.data[index]["name"]}",
                                style: const TextStyle(
                                    fontSize: 20, fontFamily: "italic"),
                              ),
                              const SizedBox(
                                width: 50,
                              ),
                              Text(
                                "${snapshot.data[index]["department"]}",
                                style: const TextStyle(
                                    fontSize: 14, fontFamily: "italic"),
                              ),
                            ],
                          ))),
                  const Divider(
                    height: 10,
                  )
                ],
              );
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
