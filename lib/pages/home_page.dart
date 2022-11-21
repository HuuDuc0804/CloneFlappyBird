import 'dart:async';

import 'package:flappy_bird/pages/barriers.dart';
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
bool gameOver = false;
double barrierXOne = 2;
double barrierXTwo = barrierXOne + 1.5;
double barrierXThree = barrierXTwo + 1.5;
int score = 0;
bool countScoreOne = false;
bool countScoreTwo = false;
bool countScoreThree = false;

class _HomePageState extends State<HomePage> {
  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYAxis;
    });
  }

  void gameStart() {
    if (gameOver) {
      birdYAxis = 0;
      time = 0;
      gameOver = false;
    }
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 60), ((timer) {
      //Barrier 1
      if (barrierXOne <= 0 && !countScoreOne) {
        score += 1;
        countScoreOne = true;
      }
      if (barrierXOne < -2) {
        barrierXOne += 4.5;
        countScoreOne = false;
      } else {
        barrierXOne -= 0.04;
      }
      //Barrier 2
      if (barrierXTwo <= 0 && !countScoreTwo) {
        score += 1;
        countScoreTwo = true;
      }
      if (barrierXTwo < -2) {
        barrierXTwo += 4.5;
        countScoreTwo = false;
      } else {
        barrierXTwo -= 0.04;
      }
      //Barrier 3
      if (barrierXThree <= 0 && !countScoreThree) {
        score += 1;
        countScoreThree = true;
      }
      if (barrierXThree < -2) {
        barrierXThree += 4.5;
        countScoreThree = false;
      } else {
        barrierXThree -= 0.04;
      }
      time += 0.05;
      height = -4.9 * time * time + 2.6 * time;
      setState(() {
        birdYAxis = initialHeight - height;
      });
      if (birdYAxis > 1) {
        timer.cancel();
        gameHasStarted = false;
        gameOver = true;
      }
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          if (gameHasStarted) {
            jump();
          } else {
            gameStart();
          }
        },
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  //Bird
                  AnimatedContainer(
                    alignment: Alignment(0, birdYAxis),
                    color: Colors.blue,
                    duration: const Duration(microseconds: 0),
                    child: const MyBird(),
                  ),
                  //back ground
                  AnimatedContainer(
                      alignment: Alignment(barrierXOne, 1.1),
                      duration: const Duration(milliseconds: 0),
                      child: const MyBarier(size: 250)),
                  AnimatedContainer(
                      alignment: Alignment(barrierXOne, -1.1),
                      duration: const Duration(milliseconds: 0),
                      child: const MyBarier(size: 250)),
                  AnimatedContainer(
                      alignment: Alignment(barrierXTwo, 1.1),
                      duration: const Duration(milliseconds: 0),
                      child: const MyBarier(size: 200)),
                  AnimatedContainer(
                      alignment: Alignment(barrierXTwo, -1.1),
                      duration: const Duration(milliseconds: 0),
                      child: const MyBarier(size: 300)),
                  AnimatedContainer(
                      alignment: Alignment(barrierXThree, 1.1),
                      duration: const Duration(milliseconds: 0),
                      child: const MyBarier(size: 220)),
                  AnimatedContainer(
                      alignment: Alignment(barrierXThree, -1.1),
                      duration: const Duration(milliseconds: 0),
                      child: const MyBarier(size: 280)),
                  // Game notification
                  Container(
                      alignment: const Alignment(0, -0.3),
                      child: gameOver
                          ? Text(
                              'G A M E  O V E R',
                              style: GoogleFonts.bungee(
                                color: Colors.red,
                                fontSize: 25,
                              ),
                            )
                          : !gameHasStarted
                              ? Text(
                                  'T A P  T O  P L A Y',
                                  style: GoogleFonts.bungee(
                                    color: Colors.white,
                                    fontSize: 25,
                                  ),
                                )
                              : Container()),
                ],
              ),
            ),
            Container(
              color: Colors.green,
              height: 15,
            ),
            Expanded(
                child: Container(
              color: Colors.brown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('SCORE',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          )),
                      const SizedBox(height: 20),
                      Text('$score',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                          )),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('BEST',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          )),
                      SizedBox(height: 20),
                      Text('0',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                          )),
                    ],
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
