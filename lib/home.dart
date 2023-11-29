import 'package:flutter/material.dart';
import 'package:alphabetic/image_assets.dart';
import 'package:alphabetic/learn.dart';
import 'package:alphabetic/quiz.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String selectedOption = 'Learn';
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(ImageAssets.alpha),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: nameController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your name',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropdownButton<String>(
                    value: selectedOption,
                    items: const [
                      DropdownMenuItem(
                        value: 'Learn',
                        child: Text('Learn'),
                      ),
                      DropdownMenuItem(
                        value: 'Quiz',
                        child: Text('Quiz'),
                      ),
                    ],
                    onChanged: (String? value) {
                      setState(() {
                        selectedOption = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      String userName = nameController.text;
                      if (userName.isNotEmpty) {
                        if (selectedOption == 'Learn') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => learn(),
                            ),
                          );
                        } else if (selectedOption == 'Quiz') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => quiz(userName: userName),
                            ),
                          );
                        }
                      } else {
                        // Show an error message or handle the case when the name is not entered.
                        // For example, you can show a SnackBar.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Please enter your name before proceeding.'),
                          ),
                        );
                      }
                    },
                    child: const Text("Let's go"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
