import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
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
  TextEditingController tec1 = TextEditingController();
  TextEditingController tec2 = TextEditingController();

  var displayText = "";
  var remarksText = "";

  void calculateBMI() {
    double height = double.parse(tec1.text) * 0.01;
    double weight = double.parse(tec2.text);
    double bmi = weight / (height * height);
    setState(() {
      displayText = "BMI ${bmi.toStringAsFixed(2)}";
      if (bmi < 18.5) {
        remarksText = "Remarks : Under Weight";
      } else if (bmi < 25) {
        remarksText = "Remarks : Normal Weight";
      } else if (bmi < 30) {
        remarksText = "Remarks : Over Weight";
      } else {
        remarksText = "Remarks : Obese";
      }
    });
  }

  Widget buildInputTextField(TextEditingController tec, String hintText) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(8.0),
      child: TextField(
        controller: tec,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: hintText,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              buildInputTextField(tec1, "Enter your Height (in centimeters)"),
              buildInputTextField(tec2, "Enter your Weight (in kilograms)"),
              FilledButton(
                onPressed: calculateBMI,
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
                child: Text("Calculate BMI"),
              ),
              SizedBox(height: 50),
              Text(
                displayText,
                style: TextStyle(fontSize: 20),
              ),
              Text(remarksText),
            ],
          ),
        ),
      ),
    );
  }
}
