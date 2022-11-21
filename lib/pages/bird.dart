import 'package:flutter/cupertino.dart';

class MyBird extends StatelessWidget {
  const MyBird({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 80,
      child: Image.asset(
        'assets/images/flappy-bird.png',
      ),
    );
  }
}
