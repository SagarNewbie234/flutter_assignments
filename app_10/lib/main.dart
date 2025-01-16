import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assignment 10',
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class QnA {
  final String question;
  final String answer;
  QnA(this.question, this.answer);
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController qController = TextEditingController();
  TextEditingController aController = TextEditingController();
  List<QnA> flashcards = [];

  void addFlashCard() {
    if (qController.text != "" && aController.text != "") {
      var question = qController.text;
      var answer = aController.text;
      setState(() {
        flashcards.add(QnA(question, answer));
      });
      aController.clear();
      qController.clear();
    }
  }

  Widget buildTextField(TextEditingController controller, String hintText) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(12),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: hintText,
        ),
        focusNode: FocusNode(canRequestFocus: false),
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
              buildTextField(qController, "Enter Question"),
              buildTextField(aController, "Enter Answer"),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CarouselView(
                    itemExtent: double.maxFinite,
                    itemSnapping: true,
                    children: [
                      ...flashcards.map((card) {
                        return Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.deepPurple.shade50,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            height: double.maxFinite,
                            width: double.maxFinite,
                            padding: EdgeInsets.all(8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Question",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  card.question,
                                  textAlign: TextAlign.center,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Answer",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  card.answer,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              FilledButton(
                onPressed: addFlashCard,
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Text("Add"),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
