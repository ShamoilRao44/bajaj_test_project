// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bajaj_test_project/home/home_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeVM>(builder: (c) {
      return Scaffold(
        appBar: AppBar(
          title: Text('0827CI211176'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // JSON Input Field
              TextField(
                controller: c.inputCtrl,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Enter JSON',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              // File Picker Button

              // Submit Button
              ElevatedButton(
                onPressed: () {
                  c.submitJson();
                },
                child: Text('Submit'),
              ),
              SizedBox(height: 16),
              // Dropdown Multi-Select
              if (c.responseData.isNotEmpty)
                Column(
                  children: [
                    Text('Select Response Data to Display:'),
                    DropdownButtonFormField<String>(
                      items: [
                        DropdownMenuItem(
                          value: 'Alphabets',
                          child: Text('Alphabets'),
                        ),
                        DropdownMenuItem(
                          value: 'Numbers',
                          child: Text('Numbers'),
                        ),
                        DropdownMenuItem(
                          value: 'Highest Lowercase Alphabet',
                          child: Text('Highest Lowercase Alphabet'),
                        ),
                      ],
                      value: c.selectedOptions.isNotEmpty
                          ? c.selectedOptions.first
                          : null, // Ensure the value is valid and matches an item.
                      onChanged: (value) {
                        if (value != null) {
                          c.updateSelectedOptions(value);
                        }
                      },
                      isExpanded: true,
                      hint: Text('Select Options'),
                    ),
                    SizedBox(height: 16),
                    // Render Response Based on Selection
                    if (c.selectedOptions.contains('Alphabets')) Text('Alphabets: ${c.responseData['alphabets']}'),
                    if (c.selectedOptions.contains('Numbers')) Text('Numbers: ${c.responseData['numbers']}'),
                    if (c.selectedOptions.contains('Highest Lowercase Alphabet'))
                      Text('Highest Lowercase Alphabet: ${c.responseData['highest_lowercase_alphabet']}'),
                  ],
                )
            ],
          ),
        ),
      );
    });
  }
}
