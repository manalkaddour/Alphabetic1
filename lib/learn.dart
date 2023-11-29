import 'package:alphabetic/data.dart';
import 'package:flutter/material.dart';

import 'package:audioplayers/audioplayers.dart';

class learn extends StatefulWidget {
  
  @override
  _learnState createState() => _learnState();
}

class _learnState extends State<learn> {
  int currentIndex = 0;
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _playAudio(AssetMap.imageToAudioMap.keys.elementAt(currentIndex));
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

void _playAudio(String imagePath) {
  String? audioPath = AssetMap.imageToAudioMap[imagePath];

  if (audioPath != null) {
    final player = AudioPlayer();
    player.play(AssetSource(audioPath));
  } else {
    // Handle the case where there is no audio path for the given image
    print('Audio path not found for image: $imagePath');
  }
}

  void _changeImage(int newIndex) {
    if (newIndex >= 0 && newIndex < AssetMap.imageToAudioMap.length) {
      setState(() {
        currentIndex = newIndex;
      });
      _playAudio(AssetMap.imageToAudioMap.keys.elementAt(currentIndex));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Screen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              AssetMap.imageToAudioMap.keys.elementAt(currentIndex),
              height: 200,
              width: 200,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_left),
                onPressed: () => _changeImage(currentIndex - 1),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_right),
                onPressed: () => _changeImage(currentIndex + 1),
              ),
            ],
          ),
        ],
      ),
    );
  }
}