import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:pgu/Storage/StorageKeys.dart';
import 'package:pgu/Storage/StorageManager.dart';
import 'package:pgu/Values/Design/PGUColors.dart';
import 'package:pgu/Extensions/StringExtensions.dart';

class ColorChooser{

  static Map<String, int>? colors;

  static Color pickColor(String fach){
    fach = fach.substringToNumber().toUpperCase();

    if(colors == null)
      loadColors();

    int? color = colors![fach];

    if(color == null)
      color = PGUColors.background.value;

    return Color(color).withOpacity(0.5);
  }

  static void updateColor(Color color, String fach){
    colors![fach] = color.value;

    saveColors();
  }

  static void saveColors(){
    StorageManager.setString(StorageKeys.farben, jsonEncode(colors));
  }

  static void loadColors(){
    String jsonString = StorageManager.getString(StorageKeys.farben);

    if(jsonString.isEmpty)
      colors = Map<String, int>();
    else
      colors = Map<String, int>.from(jsonDecode(jsonString));
  }
}