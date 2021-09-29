import 'package:flutter/material.dart';
import 'package:pgu/Pages/Vertretungen/Vertretungen.dart';
import 'package:pgu/Utils/ColorChooser.dart';
import 'package:pgu/Values/Design/PGUColors.dart';
import 'package:pgu/Values/Size/SDP.dart';
import 'package:pgu/Extensions/StringExtensions.dart';

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
    return Container(
      width: double.infinity,
      height: 90,
      decoration: BoxDecoration(
        color: PGUColors.background.withOpacity(0.075),
        borderRadius: BorderRadius.circular(15)
      ),
      margin: EdgeInsets.only(
        bottom: 10
      ),
      clipBehavior: Clip.hardEdge,
      //
      child: Row(
        children: [
          Container(
            width: 15,
            color: ColorChooser.pickColor(vertretung.fach!),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      vertretung.klasse!,
                      style: TextStyle(
                          fontFamily: 'Mont',
                          fontSize: 17
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        (vertretung.fach!.trim().isNotEmpty ? vertretung.fach! : vertretung.kurs!) + " " + vertretung.vertreter!,
                      style: TextStyle(
                          fontFamily: 'Mont',
                          fontSize: 17
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      vertretung.vertretungstext!.trim().isNotEmpty ? vertretung.vertretungstext! : vertretung.art!.shortVersion(),
                      style: TextStyle(
                          fontFamily: 'Mont',
                          fontSize: 17
                      ),
                    ),
                  ),

                  //Rechts
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      vertretung.raum!,
                      style: TextStyle(
                          fontFamily: 'Mont',
                          fontSize: 17
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      vertretung.stunde!,
                      style: TextStyle(
                          fontFamily: 'Mont',
                          fontSize: 17
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      vertretung.datum!.split(".")[0] + "." + vertretung.datum!.split(".")[1],
                      style: TextStyle(
                          fontFamily: 'Mont',
                          fontSize: 17
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}