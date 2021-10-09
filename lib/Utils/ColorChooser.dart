import 'package:flutter/cupertino.dart';
import 'package:pgu/Values/Design/PGUColors.dart';
import 'package:pgu/Extensions/StringExtensions.dart';

class ColorChooser{

  static Color pickColor(String fach){
    fach = fach.substringToNumber().toUpperCase();

    switch(fach){
      case "BI":
        return Color.fromARGB(255, 8, 236, 19).withOpacity(0.35);
      case "SW":
        return Color.fromARGB(255, 255, 230, 0).withOpacity(0.35);
      case "PH":
        return Color.fromARGB(255, 21, 181, 220).withOpacity(0.35);
      case "D":
        return Color.fromARGB(255, 29, 167, 52).withOpacity(0.35);
      case "M":
        return Color.fromARGB(255, 5, 86, 104).withOpacity(0.35);
      case "CH":
        return Color.fromARGB(255, 152, 53, 196).withOpacity(0.35);
      case "MU":
        return Color.fromARGB(255, 255, 244, 0).withOpacity(0.35);
      case "SP":
        return Color.fromARGB(255, 0, 0, 0).withOpacity(0.35);
      case "E":
        return Color.fromARGB(255, 255, 0, 0).withOpacity(0.35);
      case "PA":
        return Color.fromARGB(255, 208, 0, 255).withOpacity(0.35);
      case "S":
        return Color.fromARGB(255, 255, 153, 0).withOpacity(0.35);

      default:
        return PGUColors.background.withOpacity(0.075);
    }
  }
}