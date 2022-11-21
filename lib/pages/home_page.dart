import 'dart:async';

import 'package:flappy_bird/pages/bird.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

double birdYAxis = 0;
double time = 0;
double height = 0;
double initialHeight = 0;
bool gameHasStarted = false;

class _HomePageState extends State<HomePage> {
  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYAxis;
    });
  }

  void gameStart() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 60), ((timer) {
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYAxis = initialHeight - height;
      });
      if (birdYAxis > 1) {
        timer.cancel();
        gameHasStarted = false;
      }
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    if (gameHasStarted) {
                      jump();
                    } else {
                      gameStart();
                    }
                  },
                  child: AnimatedContainer(
                    alignment: Alignment(0, birdYAxis),
                    color: Colors.blue,
                    duration: const Duration(microseconds: 0),
                    child: const MyBird(),
                  ),
                ),
                Container(
                  alignment: const Alignment(0, -0.3),
                  child: gameHasStarted
                      ? const Text('')
                      : Text(
                          'T A P  T O  P L A Y',
                          style: GoogleFonts.bungee(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                )
              ],
            ),
          ),
          Expanded(
              child: Container(
            color: Colors.green,
          ))
        ],
      ),
    );
  }
}
