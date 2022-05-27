import 'package:flutter/material.dart';
import 'package:pgu/Values/Design/PGUColors.dart';

Widget EmptyState(String description, String image){
  return Stack(
    alignment: Alignment.center,
    children: [
      Align(
        alignment: Alignment.center,
        child: Image.asset(image),
      ),
      Align(
        alignment: Alignment.center,
        child: Stack(
          children: [
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Mont',
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 5
                  ..color = PGUColors.background,
              ),
            ),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: PGUColors.text,
                fontSize: 30,
                fontFamily: 'Mont',
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(10.0, 10.0),
                    blurRadius: 3.0,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  Shadow(
                    offset: Offset(10.0, 10.0),
                    blurRadius: 8.0,
                    color: Color.fromARGB(125, 0, 0, 0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}