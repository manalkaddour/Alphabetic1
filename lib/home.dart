import 'package:alphabetic/image_assets.dart';
import 'package:alphabetic/learn.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key});

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
          Expanded(child: Center(
            child: Container(child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => learn()),
              );
            },
            child: const Text("Let's go"),
          ),),
          ))
          
        ],
      ),
    );
  }
}
