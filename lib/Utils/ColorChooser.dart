import 'package:flutter/cupertino.dart';
import 'package:pgu/Values/Design/PGUColors.dart';

class ColorChooser{
  Map<String, Color> colors = {
    "BI": Color.fromARGB(255, 8, 236, 19),//Biologie
    "SW": Color.fromARGB(255, 255, 230, 0),//Sowi
    //"BI": fromHex("#1b5e20"),//Biologie
  };

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static Color pickColor(String fach){
    ColorChooser c = ColorChooser();//FIXME only for debug
    if(fach.length >= 2){
      fach = fach.toUpperCase().substring(0, 2);
    }
    return c.colors[fach] == null ? PGUColors.background.withOpacity(0.075) : c.colors[fach]!.withOpacity(0.35);
  }
}