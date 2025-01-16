import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const CurrencyConverterApp());
}

class CurrencyConverterApp extends StatelessWidget {
  const CurrencyConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Assignment 07",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, Map<String, double Function(double)>> conversionRates = {
    "Rupee": {
      "Rupee": (temp) => temp,
      "Dollar": (temp) => temp * 0.012,
      "Euro": (temp) => temp * 0.011,
      "Yen": (temp) => temp * 1.82,
    },
    "Dollar": {
      "Rupee": (temp) => temp * 86.57,
      "Dollar": (temp) => temp,
      "Euro": (temp) => temp * 0.98,
      "Yen": (temp) => temp * 157.91,
    },
    "Euro": {
      "Rupee": (temp) => temp * 88.76,
      "Dollar": (temp) => temp * 1.03,
      "Euro": (temp) => temp,
      "Yen": (temp) => temp * 161.89,
    },
    "Yen": {
      "Rupee": (temp) => temp * 0.55,
      "Dollar": (temp) => temp * 0.0063,
      "Euro": (temp) => temp * 0.0062,
      "Yen": (temp) => temp,
    }
  };

  Map<String, String> symbols = {
    "Rupee": "₹",
    "Dollar": "\$",
    "Euro": "€",
    "Yen": "¥",
  };

  TextEditingController value = TextEditingController();
  TextEditingController inputUnit = TextEditingController();
  TextEditingController outputUnit = TextEditingController();
  String displayText = "0.0";

  void convert() {
    var inputValue = double.tryParse(value.text) ?? 0.0;
    setState(() {
      if (conversionRates.containsKey(inputUnit.text) &&
          conversionRates[inputUnit.text]!.containsKey(outputUnit.text)) {
        var result =
            conversionRates[inputUnit.text]![outputUnit.text]!(inputValue);
        displayText =
            "${symbols[inputUnit.text]} ${inputValue.toStringAsFixed(2)} = ${symbols[outputUnit.text]} ${result.toStringAsFixed(2)}";
      } else {
        displayText = "Invalid Input";
      }
    });
  }

  Widget buildDropDownButton(String helperText, TextEditingController tec) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: DropdownMenu(
        dropdownMenuEntries: ["Rupee", "Dollar", "Euro", "Yen"].map((element) {
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
        title: Text("Assignment - 07", style: GoogleFonts.fredoka()),
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
                  controller: value,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Currency",
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
                child: Text("Convert Currency"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
