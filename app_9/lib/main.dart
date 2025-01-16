import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assignment 09',
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController controller = TextEditingController();
  TextEditingController menuController = TextEditingController();
  String displayText = "";
  Map<String, double Function(double)> conversionMap = {
    "Area": (temp) => pi * temp * temp,
    "Circumference": (temp) => 2 * pi * temp,
  };

  void calculate() {
    var radius = double.tryParse(controller.text) ?? 0;
    if (conversionMap.containsKey(menuController.text)) {
      var calculated = conversionMap[menuController.text]!(radius);
      setState(() {
        if (menuController.text == "Area") {
          displayText = "Area : ${calculated.toStringAsFixed(2)} m2";
        } else {
          displayText = "Circumference : ${calculated.toStringAsFixed(2)} m";
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              padding: EdgeInsets.all(12),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter radius (in m)",
                ),
                focusNode: FocusNode(canRequestFocus: false),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: DropdownMenu(
                dropdownMenuEntries: ["Area", "Circumference"].map((element) {
                  return DropdownMenuEntry(value: element, label: element);
                }).toList(),
                width: double.maxFinite,
                hintText: "Select what to calculate",
                controller: menuController,
              ),
            ),
            SizedBox(height: 20),
            FilledButton(
              onPressed: calculate,
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Text("Calculate"),
            ),
            SizedBox(height: 20),
            Text(
              displayText,
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
