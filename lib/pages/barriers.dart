import 'package:flutter/material.dart';

class MyBarier extends StatelessWidget {
  final double size;
  const MyBarier({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: size,
      // ignore: prefer_const_constructors
      decoration: BoxDecoration(
        color: Colors.green,
        border: Border.all(color: Colors.black54),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
