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
      return this.toLowerCase();

    return this.toUpperCase();
  }

  bool isValidClassname(){
    //5a - 11c
    if(startsNumeric()){
      //a = 65
      //f = 70
      if(this.runes.toList()[1] >= 52 && this.runes.toList()[1] <= 70)
        return true;
    }

    //EF Q1 Q2 Q3
    if(this == "EF" || this == "Q1" || this == "Q2" || this == "Q3")
      return true;

    return false;
  }

  String dateString(){
    DateTime dateTime = DateTime.parse(this);

    return dateTime.hour.toString() + ":" + dateTime.minute.toString() + " " + dateTime.day.toString() + "." + dateTime.month.toString() + "." + dateTime.year.toString();
  }
}