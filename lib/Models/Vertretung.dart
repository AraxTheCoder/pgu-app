import 'package:flutter/material.dart';
import 'package:pgu/Pages/Vertretungen/Vertretungen.dart';
import 'package:pgu/Values/Design/PGUColors.dart';
import 'package:pgu/Values/Size/SDP.dart';

class Vertretung{
  String? klasse;
  String? kurs;

  Vertretung(this.klasse, this.kurs);

  Vertretung.fromJson(Map<String, dynamic> json){
    this.klasse = json["klasse"];
    this.kurs = json["kurs"];
  }

  Map<String, dynamic> toJson() {
    return {
      'klasse': klasse,
      'kurs': kurs,
    };
  }

  static Widget item(Vertretung vertretung) {
    return Text(
        vertretung.klasse! + " " + vertretung.kurs!,
      style: TextStyle(
        fontFamily: 'Mont',
        fontSize: 20
      ),
    );
  }
}