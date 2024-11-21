import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeVM extends GetxController {
  TextEditingController inputCtrl = TextEditingController();
  String jsonInput = '';
  Map<String, dynamic> responseData = {};
  List<String> selectedOptions = [];

  void updateJsonInput(String input) {
    jsonInput = input;
    update();
  }

  void updateSelectedOptions(String option) {
    if (selectedOptions.contains(option)) {
      selectedOptions.remove(option);
    } else {
      selectedOptions.add(option);
    }
    update();
  }

  bool validateJson(String input) {
    try {
      json.decode(input);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> submitJson() async {
    if (validateJson(inputCtrl.text) == false) {
      Get.snackbar('Error', 'Invalid JSON');
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://86.38.204.199:8086/bfhl'),
        headers: {'Content-Type': 'application/json'},
        body: inputCtrl.text,
      );

      if (response.statusCode == 200) {
        responseData = json.decode(response.body);

        update();
      } else {
        Get.snackbar('Error', 'Failed to get response from the server');
      }
    } catch (e) {
      Get.snackbar('Error', 'Server error ${e.toString()}');
    }
  }
}
