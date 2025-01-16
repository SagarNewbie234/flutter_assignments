import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const CountDownApp());
}

class CountDownApp extends StatelessWidget {
  const CountDownApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
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
  TextEditingController controller = TextEditingController();
  Timer? timer;
  int remainingSeconds = 0;

  String formattedString() {
    var minutes = (remainingSeconds ~/ 60).toString().padLeft(2, '0');
    var seconds = (remainingSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  void stopCountdown() {
    setState(() {
      if (timer != null) {
        timer!.cancel();
      }
    });
  }

  void resetCountdown() {
    setState(() {
      if (timer != null) {
        timer!.cancel();
      }
      remainingSeconds = 0;
    });
  }

  void startCountdown() {
    setState(() {
      remainingSeconds = int.tryParse(controller.text) ?? 0;
      controller.clear();
    });
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingSeconds > 0) {
          remainingSeconds--;
        } else {
          timer.cancel();
        }
      });
    });
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
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 4),
                  ),
                  margin: EdgeInsets.all(24),
                  width: 200,
                  height: 200,
                  child: Center(
                      child: Text(
                    formattedString(),
                    style: TextStyle(fontSize: 48),
                  )),
                ),
                Container(
                  width: 250,
                  padding: EdgeInsets.all(12.0),
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter Duration in Seconds",
                      helperText: "Duration",
                    ),
                    enabled: timer?.isActive ?? false ? false : true,
                    textAlign: TextAlign.center,
                    focusNode: FocusNode(canRequestFocus: false),
                  ),
                ),
                FilledButton(
                  onPressed: timer?.isActive ?? false ? null : startCountdown,
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  child: Text("Start Countdown"),
                ),
                SizedBox(height: 10),
                FilledButton(
                  onPressed: timer?.isActive ?? false ? stopCountdown : null,
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  child: Text("Stop Countdown"),
                ),
                SizedBox(height: 10),
                FilledButton(
                  onPressed: resetCountdown,
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  child: Text("Reset Countdown"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
