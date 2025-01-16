import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(AgeApp());
}

class AgeApp extends StatelessWidget {
  const AgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
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
  DateTime birthdate = DateTime.now();
  var displayAge = "";

  Future<void> selectDOB() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      currentDate: birthdate,
    );
    if (picked != null && picked != birthdate) {
      setState(() {
        birthdate = picked;
      });
    }
  }

  void calculateAge() {
    DateTime currdate = DateTime.now();
    List<int> months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    if (birthdate.day > currdate.day) {
      currdate.copyWith(day: currdate.day + months[birthdate.month - 1]);
      currdate.copyWith(month: currdate.month - 1);
    }
    if (birthdate.month > currdate.month) {
      currdate.copyWith(year: currdate.year - 1);
      currdate.copyWith(month: currdate.month + 12);
    }

    DateTime age = DateTime(currdate.year - birthdate.year,
        currdate.month - birthdate.month, currdate.day - birthdate.day);

    setState(() {
      displayAge =
          "You are \n ${age.year} Years ${age.month} Months ${age.day} Days old!";
    });
  }

  Widget buildActionButtons(String buttonText, void Function()? onPressed) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Text(buttonText),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Age Calculator",
          style: GoogleFonts.fredoka(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "${birthdate.toLocal()}".split(" ")[0],
                style: GoogleFonts.fredoka(fontSize: 30),
              ),
            ),
            buildActionButtons("Select Date of Birth", selectDOB),
            SizedBox(height: 10),
            buildActionButtons("Calculate Age", calculateAge),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Text(
                displayAge,
                style: GoogleFonts.fredoka(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
