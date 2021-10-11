import 'package:flutter/material.dart';
import 'package:pgu/Pages/Vertretungen/Vertretungen.dart';
import 'package:pgu/Utils/ColorChooser.dart';
import 'package:pgu/Values/Design/PGUColors.dart';
import 'package:pgu/Values/Size/SDP.dart';
import 'package:pgu/Extensions/StringExtensions.dart';
import 'package:pgu/Widgets/List/swipe_widget.dart';

class Vertretung{
  String? klasse;
  String? kurs;
  String? stunde;
  String? vertreter;
  String? raum;
  String? art;
  String? datum;


  Vertretung(this.klasse, this.kurs, this.stunde, this.vertreter, this.raum, this.art, this.datum);

  Vertretung.fromJson(Map<String, dynamic> json){
    this.klasse = json["klasse"];
    this.kurs = json["kurs"];
    this.stunde = json["stunde"];
    this.vertreter = json["vertreter"];
    this.raum = json["raum"];
    this.art = json["art"];
    this.datum = json["datum"];
  }

  Map<String, dynamic> toJson() {
    return {
      'klasse': klasse,
      'kurs': kurs,
      'stunde': stunde,
      'vertreter': vertreter,
      'raum': raum,
      'art': art,
      'datum': datum,
    };
  }

  static Widget item(Vertretung vertretung, ScrollController controller) {
    return OnSlide(
        items: <ActionItems>[
          ActionItems(icon: Icon(Icons.visibility_off_rounded), text: "Kurs\nverbergen", onPress: (){ print("Kurs");}, backgroudColor: Colors.white),
          ActionItems(icon: Icon(Icons.edit_rounded), text: "Farbe\nändern", onPress: (){print("Farbe");}, backgroudColor: Colors.white),
        ],
        child: Padding(
          padding: EdgeInsets.only(
            left: SDP.sdp(25),
            right: SDP.sdp(25)
          ),
          child: Container(
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
                  color: ColorChooser.pickColor(vertretung.kurs!),
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
                            (vertretung.kurs! + " " + vertretung.vertreter!).trim().arrowFormat(),
                            style: TextStyle(
                                fontFamily: 'Mont',
                                fontSize: 17
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            vertretung.art!.shortVersion(),
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
                            vertretung.raum!.arrowFormat(),
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
                            vertretung.datum!.split("-")[2] + "." + vertretung.datum!.split("-")[1],
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
          ),
        )
    );
  }
}