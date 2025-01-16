import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  TextEditingController tec = TextEditingController();
  TextEditingController inputUnit = TextEditingController();
  TextEditingController outputUnit = TextEditingController();
  String displayText = "0.0";

  void convert() {
    setState(() {
      double inputValue = double.parse(tec.text);

      Map<String, Map<String, Function(double)>> conversionMap = {
        "Celsius": {
          "Celsius": (temp) => temp,
          "Fahrenheit": (temp) => (temp * 1.8) + 32,
          "Kelvin": (temp) => temp + 273.15,
        },
        "Fahrenheit": {
          "Celsius": (temp) => (temp - 32) * (5 / 9),
          "Fahrenheit": (temp) => temp,
          "Kelvin": (temp) => ((temp - 32) * (5 / 9)) + 273.15,
        },
        "Kelvin": {
          "Celsius": (temp) => temp - 273.15,
          "Fahrenheit": (temp) => ((temp - 273.15) * 1.8) + 32,
          "Kelvin": (temp) => temp,
        },
      };

      if (conversionMap.containsKey(inputUnit.text) &&
          conversionMap[inputUnit.text]!.containsKey(outputUnit.text)) {
        double result =
            conversionMap[inputUnit.text]![outputUnit.text]!(inputValue);
        displayText =
            "${inputValue.toStringAsFixed(2)} ${inputUnit.text[0]} = ${result.toStringAsFixed(2)} ${outputUnit.text[0]}";
      } else {
        displayText = "Invalid Input";
      }
    });

    tec.clear();
    inputUnit.clear();
    outputUnit.clear();
  }

  Widget buildDropDownButton(String helperText, TextEditingController tec) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: DropdownMenu(
        dropdownMenuEntries: ["Celsius", "Fahrenheit", "Kelvin"].map((element) {
          return DropdownMenuEntry(value: element, label: element);
        }).toList(),
        width: double.maxFinite,
        helperText: helperText,
        controller: tec,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Assignment - 01", style: GoogleFonts.fredoka()),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                (displayText == "0.0") ? "" : "Conversion Result",
                style: GoogleFonts.fredoka(fontSize: 24),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  displayText,
                  style: GoogleFonts.fredoka(fontSize: 35),
                  textAlign: TextAlign.end,
                ),
              ),
              Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: TextField(
                  controller: tec,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Temperature",
                  ),
                  focusNode: FocusNode(canRequestFocus: false),
                ),
              ),
              buildDropDownButton("Input Unit", inputUnit),
              buildDropDownButton("Output Unit", outputUnit),
              SizedBox(height: 20),
              FilledButton(
                onPressed: convert,
                style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                child: Text("Convert Temperature"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
