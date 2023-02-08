import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:test22/api/api.dart';

class Photopicker extends StatefulWidget {
  const Photopicker({super.key});

  @override
  State<Photopicker> createState() => _PhotopickerState();
}

class _PhotopickerState extends State<Photopicker> {
  GlobalKey<FormState> formkey2 = GlobalKey<FormState>();
  File? selectedimage;
  Uri lunchurl = Uri.parse("");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Picker and API Example'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Select Photo'),
              onPressed: () async {
                final image =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                selectedimage = File(image!.path);

                setState(() {});
              },
            ),
            const SizedBox(height: 20),
            selectedimage != null
                ? Image.file(
                    selectedimage!,
                    height: 300,
                  )
                : Container(),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Send to API'),
              onPressed: () async {
                if (selectedimage != null) {
                  API api = API();
                  api.send64bytes(selectedimage!).then((response) {
                    if (response.statusCode == 200) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Response'),
                            content: Text(response.body),
                            actions: [
                              ElevatedButton(
                                child: const Text('OK'),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content: Text(
                                'Failed to upload image: ${response.statusCode}'),
                            actions: [
                              ElevatedButton(
                                child: const Text('OK'),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  });
                } else {
                  //return pop up dialog saying pealase select image first

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text('Please select image first'),
                        actions: [
                          ElevatedButton(
                            child: const Text('OK'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
            const SizedBox(height: 20),
            Form(
              key: formkey2,
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: "url",
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
                keyboardType: TextInputType.url,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter the URL";
                  } else {
                    return null;
                  }
                },
                onSaved: (vlaue) {
                  lunchurl = Uri.parse(vlaue!);
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Launch URL'),
              onPressed: () async {
                var formndata2 = formkey2.currentState;
                if (formndata2!.validate()) {
                  formndata2.save();
                  if (await canLaunchUrl(lunchurl)) {
                    launchUrl(lunchurl, mode: LaunchMode.externalApplication);
                  } else {
                    print('Error launching $lunchurl');
                    showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text('Please enter a vaild URL'),
                        actions: [
                          ElevatedButton(
                            child: const Text('OK'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      );
                    },
                  );
                    
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
