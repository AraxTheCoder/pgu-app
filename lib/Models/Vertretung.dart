import 'package:flutter/material.dart';
import 'package:pgu/Pages/Vertretungen/Vertretungen.dart';
import 'package:pgu/Values/Design/PGUColors.dart';
import 'package:pgu/Values/Size/SDP.dart';

class Vertretung{
  String? klasse;
  String? kurs;
  String? stunde;
  String? vertreter;
  String? fach;
  String? raum;
  String? art;
  String? vertretungstext;
  String? datum;


  Vertretung(this.klasse, this.kurs, this.stunde, this.vertreter, this.fach, this.raum, this.art, this.vertretungstext, this.datum);

  Vertretung.fromJson(Map<String, dynamic> json){
    this.klasse = json["klasse"];
    this.kurs = json["kurs"];
    this.stunde = json["stunde"];
    this.vertreter = json["vertreter"];
    this.fach = json["fach"];
    this.raum = json["raum"];
    this.art = json["art"];
    this.vertretungstext = json["vertretungstext"];
    this.datum = json["datum"];
  }

  Map<String, dynamic> toJson() {
    return {
      'klasse': klasse,
      'kurs': kurs,
      'stunde': stunde,
      'vertreter': vertreter,
      'fach': fach,
      'raum': raum,
      'art': art,
      'vertretungstext': vertretungstext,
      'datum': datum,
    };
  }

  static Widget item(Vertretung vertretung) {
    return Text(
        vertretung.klasse! + " " + vertretung.kurs! + " " + vertretung.stunde! + " " + vertretung.vertreter! + " " + vertretung.fach! + " " + vertretung.raum! + " " + (vertretung.vertretungstext!.trim().isNotEmpty ? vertretung.vertretungstext! : vertretung.art!),
      style: TextStyle(
        fontFamily: 'Mont',
        fontSize: 20
      ),
    );
  }
}