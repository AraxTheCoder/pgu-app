import 'dart:convert';

import 'package:crypto/crypto.dart';

extension StringExtensions on String{
  bool startsNumeric(){
    if(this.isEmpty)
      return false;

    return double.tryParse(this.substring(0, 1)) != null;
  }

  bool endsNumeric(){
    if(this.isEmpty)
      return false;

    return double.tryParse(this.substring(this.length - 1)) != null;
  }

  String trimEmpty(){
    return this.replaceAll("/", "").trim();
  }

  String toMd5() {
    return md5.convert(utf8.encode(this)).toString();
  }

  String shortVersion(){
    switch(this){
      case "eigenverantwortliches":
        return "Eva";
      case "CH":
        return "Chemie";
      case "D":
        return "Deutsch";
      case "E":
        return "Englisch";
      case "IF":
        return "Informatik";
      case "M":
        return "Mathe";
      case "F":
        return "Französisch";
      case "ER":
        return "Eva. Religion";
      case "LI":
        return "Literatur";
      case "PA":
        return "Pädagogik";
      case "PH":
        return "Physik";
    }

    return this;
  }

  String withoutNumbers(){
    String withoutNumbers = "";

    this.runes.forEach((int rune) {
      String character = new String.fromCharCode(rune);

      if(!character.startsNumeric())
        withoutNumbers += character;
    });

    return withoutNumbers;
  }

  String substringToNumber(){
    String substringToNumber = "";

    for(int rune in this.split(" ")[0].runes){
      String character = new String.fromCharCode(rune);

      if(double.tryParse(character) == null)
        substringToNumber += character;
      else
        break;
    }

    return substringToNumber;
  }

  String arrowFormat(){
    //https://stackoverflow.com/questions/50722987/how-to-make-a-line-through-text-in-flutter
    List<String> parts = this.split("?");

    if(parts.length == 2){
      return parts[0] + "➜" + parts[1];
    }

    return this;
  }

  String formatClass(){
    if(this.startsNumeric())
      return this;

    return this.toUpperCase();
  }
}