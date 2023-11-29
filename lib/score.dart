import 'package:flutter/material.dart';

class score extends StatefulWidget {
  const score({
    super.key,
    required this.userScore,
    required this.userName,
  });
  final int userScore;
  final String userName;

  @override
  _scoreState createState() => _scoreState();
}

class _scoreState extends State<score> {
  List<ScoreItem> scoreItems = [];

  @override
  void initState() {
    super.initState();

    // Initialize scoreItems with data from the previous page
    scoreItems = [
      ScoreItem(
        name: widget.userName,
        score: widget.userScore,
      ),
      // Add more ScoreItem objects as needed
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Score Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _deleteSelectedItems();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: scoreItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title:
                Text('${scoreItems[index].name} - ${scoreItems[index].score}'),
            leading: Checkbox(
              value: scoreItems[index].isSelected,
              onChanged: (value) {
                setState(() {
                  scoreItems[index].isSelected = value ?? false;
                });
              },
            ),
          );
        },
      ),
    );
  }

  void _deleteSelectedItems() {
    setState(() {
      scoreItems.removeWhere((item) => item.isSelected);
    });
  }
}

class ScoreItem {
  final String name;
  final int score;
  bool isSelected;

  ScoreItem({
    required this.name,
    required this.score,
    this.isSelected = false,
  });
}
