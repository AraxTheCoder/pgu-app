import 'package:flutter/cupertino.dart';
import 'package:pgu/Values/Design/PGUColors.dart';
import 'package:pgu/Extensions/StringExtensions.dart';

class ColorChooser{

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static Color pickColor(String fach){
    fach = fach.withoutNumbers();

    if(fach.length >= 2){
      switch(fach.substring(0, 2).toUpperCase()){
        case "BI":
          return Color.fromARGB(255, 8, 236, 19).withOpacity(0.35);
        case "SW":
          return Color.fromARGB(255, 255, 230, 0).withOpacity(0.35);
        case "PH":
          return Color.fromARGB(255, 21, 181, 220).withOpacity(0.35);
        case "PH":
          return Color.fromARGB(255, 21, 181, 220).withOpacity(0.35);
        case "DL":
          return Color.fromARGB(255, 29, 167, 52).withOpacity(0.35);
        case "ML":
          return Color.fromARGB(255, 5, 86, 104).withOpacity(0.35);
      }
    }

    return PGUColors.background.withOpacity(0.075);
  }
}