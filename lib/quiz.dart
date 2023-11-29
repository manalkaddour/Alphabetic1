import 'package:alphabetic/image_assets.dart';
import 'package:alphabetic/score.dart';
import 'package:flutter/material.dart';

class questionsMap {
  static const Map<String, Map<String, bool>> questions = {
    ImageAssets.a: {'apple': true, 'alpaca': false},
    ImageAssets.b: {'bee': true, 'banana': false},
    // Add more questions here
  };
}

class quiz extends StatefulWidget {
  final String userName;

  const quiz({Key? key, required this.userName}) : super(key: key);

  @override
  _quizState createState() => _quizState();
}

class _quizState extends State<quiz> {
  int currentQuestionIndex = 0;
  int userScore = 0;
  bool correctAnswer = false;
  bool? firstSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz for ${widget.userName}"),
      ),
      body: _buildQuizBody(),
    );
  }

  Widget _buildQuizBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildQuestion(),
          _buildAnswers(),
          ElevatedButton(
            onPressed: () {
              if (firstSelected != null) {
                _nextQuestion();
              } else {
                // Show a message to select an answer
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please select an answer.'),
                  ),
                );
              }
            },
            child: const Text("Next Question"),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestion() {
    String imageAsset =
        questionsMap.questions.keys.elementAt(currentQuestionIndex);
    return Column(
      children: [
        Image.asset(imageAsset),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildAnswers() {
    Map<String, bool> currentQuestion =
        questionsMap.questions.values.elementAt(currentQuestionIndex);

    return Column(
      children: [
        RadioListTile<bool>(
          title: Text(currentQuestion.keys.elementAt(0)),
          value: true,
          groupValue: firstSelected ?? false ? true : false,
          onChanged: (bool? value) {
            correctAnswer = currentQuestion.values.elementAt(0);
            setState(() {
              firstSelected = true;
            });
          },
        ),
        RadioListTile<bool>(
          title: Text(currentQuestion.keys.elementAt(1)),
          value: false,
          groupValue: firstSelected == false ? false : true,
          onChanged: (bool? value) {
            correctAnswer = currentQuestion.values.elementAt(1);
            setState(() {
              firstSelected = false;
            });
          },
        ),
      ],
    );
  }

  void _nextQuestion() {
    setState(() {
      firstSelected = null;
      if (correctAnswer) userScore++;
      correctAnswer = false;
      if (currentQuestionIndex == (questionsMap.questions.length - 1)) {
        // Show the user's score after answering all questions
        _showScoreDialog();
      } else {
        currentQuestionIndex++;
      }
    });
  }

  void _showScoreDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Quiz Completed"),
          content: Text(
              "${widget.userName} Your score: $userScore out of ${questionsMap.questions.length}"),
          actions: [
            TextButton(
              onPressed: () {
                // Navigate to the score page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => score(
                      userName: widget.userName,
                      userScore: userScore,
                    ),
                  ),
                );
              },
              child: const Text("Show Score"),
            ),
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
