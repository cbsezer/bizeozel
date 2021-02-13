import 'package:drawing_animation/drawing_animation.dart';
import 'package:flutter/material.dart';

Widget loader() {
  var run = true;
  return Container(
    alignment: Alignment.center,
    height: 110,
    width: 110,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(55),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.grey.withOpacity(0.7),
            offset: Offset(0, 0),
          )
        ]),
    child: AnimatedDrawing.svg(
      'assets/images/loginimg.svg',
      height: 80,
      run: run,
      duration: Duration(seconds: 3),
    ),
  );
}
