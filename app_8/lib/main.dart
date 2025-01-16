import 'package:flutter/material.dart';

void main() {
  runApp(const TipApp());
}

class TipApp extends StatelessWidget {
  const TipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assignment 08',
      theme: ThemeData(useMaterial3: true),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();
  String displayText = "";
  double originalBill = 0.0;
  double tipPercentage = 0.0;
  double tipAmount = 0.0;

  void updateTipPercentage(double value) {
    setState(() {
      tipPercentage = value;
    });
  }

  void calculateTip() {
    setState(() {
      originalBill = double.parse(controller.text);
      tipAmount = (originalBill * tipPercentage);
      displayText = "₹ ${tipAmount.toStringAsFixed(2)}";
    });
    controller.clear();
  }

  Widget outlinedButton(double tip, String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OutlinedButton(
        onPressed: () => updateTipPercentage(tip),
        style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(25),
                  width: double.maxFinite,
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: "Enter your Bill Amount",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("How much would you like to tip ?"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    outlinedButton(0.01, "1%"),
                    outlinedButton(0.02, "2%"),
                    outlinedButton(0.03, "3%"),
                    outlinedButton(0.05, "5%"),
                  ],
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: calculateTip,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  child: Text("Calculate Tip"),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => setState(() {
                    displayText = "";
                  }),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  child: Text("Reset"),
                ),
                SizedBox(height: 30),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 4, color: Colors.transparent),
                    color: displayText == ""
                        ? Colors.transparent
                        : Colors.deepPurple.shade100,
                  ),
                  width: 150,
                  height: 150,
                  child: Center(
                    child: Text(
                      displayText,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple.shade500),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
