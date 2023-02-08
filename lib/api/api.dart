import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class API {
  Future send64bytes(File image) async {
    try {
      List<int> imageBytes = await image.readAsBytes();
      final base64Image = base64Encode(imageBytes);
      var url = Uri.parse("http://mytrapi.ggs-co.com/api/UploadImage");
      final data = {'image': base64Image};
      final response = await http.post(url, body: json.encode(data));

      print(response.statusCode);

      return response;
    } catch (e) {
      print(e);
    }
  }
}
