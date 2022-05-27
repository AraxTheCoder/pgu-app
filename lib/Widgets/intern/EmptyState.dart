import 'package:flutter/material.dart';
import 'package:pgu/Values/Design/PGUColors.dart';

Widget EmptyState(String description){
  return Padding(
    padding: const EdgeInsets.only(
        bottom: 100,
        left: 35,
        right: 35
    ),
    child: Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: Image.asset('assets/dog_small_nb_cropped.png'),
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
    ),
  );
}