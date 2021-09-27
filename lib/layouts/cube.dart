import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Cube extends StatelessWidget {
  late Color color;
  Cube({required this.color});
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage("assets/images/btn1.png"),
        ),
        color: color,
        border: Border.all(
          width: 2,
          color: Colors.grey.shade700,
        ),
      ),
    );
  }
}
