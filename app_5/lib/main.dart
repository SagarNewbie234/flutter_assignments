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
  List<Voter> notEligibleToVote = [];
  List<Voter> eligibleToVote = [];
  TextEditingController nameTec = TextEditingController();
  TextEditingController ageTec = TextEditingController();

  void addNamesToList() {
    final name = nameTec.text;
    final age = int.parse(ageTec.text);
    setState(() {
      if (age >= 18) {
        eligibleToVote.add(Voter(name: name, age: age));
      } else {
        notEligibleToVote.add(Voter(name: name, age: age));
      }
    });
    nameTec.clear();
    ageTec.clear();
  }

  Widget buildTextField(String fieldName, TextEditingController controller) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      width: double.maxFinite,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          hintText: "Enter your $fieldName",
          helperText: fieldName,
        ),
      ),
    );
  }

  Widget buildListTile(Voter voter) {
    return ListTile(
      title: Text(voter.name),
      trailing: Text(
        "Age : ${voter.age}",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
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
              buildTextField("Name", nameTec),
              buildTextField("Age", ageTec),
              FilledButton(
                onPressed: addNamesToList,
                child: Text("Add to List"),
              ),
              SizedBox(height: 50),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Text(
                            "Eligible to Vote",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          ...eligibleToVote.map(
                            (element) => buildListTile(element),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Text(
                            "Not eligible to Vote",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          ...notEligibleToVote.map(
                            (element) => buildListTile(element),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Voter {
  final String name;
  final int age;
  Voter({required this.name, required this.age});
}
