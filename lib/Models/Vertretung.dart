import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:pgu/Storage/StorageKeys.dart';
import 'package:pgu/Storage/StorageManager.dart';
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
    klasse = json["klasse"];
    kurs = json["kurs"];
    stunde = json["stunde"];
    vertreter = json["vertreter"];
    raum = json["raum"];
    art = json["art"];
    datum = json["datum"];
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

  static Widget item(Vertretung vertretung, BuildContext context, Function refresh, int index) {

    if(vertretung.klasse == "INFO"){
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: PGUColors.background.withOpacity(0.055),
            borderRadius: BorderRadius.circular(15)
        ),
        margin: EdgeInsets.only(
            bottom: 20,
            top: index != 0 ? 30 : 0,
            left: SDP.sdp(25),
            right: SDP.sdp(25)
        ),
        padding: const EdgeInsets.all(20),
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: [
            Text(
              vertretung.datum!.split("-")[2] + "." + vertretung.datum!.split("-")[1],
              style: const TextStyle(
                  fontFamily: 'Mont',
                  fontSize: 17
              ),
            ),
            vertretung.art!.isNotEmpty ? Container(
              margin: const EdgeInsets.only(
                top: 10,
                right: 10,
                left: 10
              ),
              child: Text(
                vertretung.art!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontFamily: 'Mont-normal',
                    fontSize: 15
                ),
              ),
            ) : Container()
          ],
        ),
      );
    }

    List<ActionItems> items = [];

    if(vertretung.kurs != "/"){
      items = <ActionItems>[];

      if(StorageManager.getString(StorageKeys.loggedIn) == "s") {
        items.add(ActionItems(icon: const Icon(Icons.visibility_off_rounded), text: "Kurs\nverbergen", onPress: (){ hideKurs(context, vertretung.klasse!, vertretung.kurs!, vertretung.vertreter!.split("→")[0], refresh); }, backgroudColor: Colors.white));
      }

      items.add(ActionItems(icon: const Icon(Icons.edit_rounded), text: "Farbe\nändern", onPress: (){openColorpicker(context, vertretung.klasse!, vertretung.kurs!, refresh);}, backgroudColor: Colors.white));
    }

    return OnSlide(
        items: items,
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
            margin: const EdgeInsets.only(
                bottom: 10
            ),
            clipBehavior: Clip.hardEdge,
            //
            child: Row(
              children: [
                Container(
                  width: 15,
                  color: ColorChooser.pickColor(vertretung.kurs!).withOpacity(0.75),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            vertretung.klasse!,
                            style: const TextStyle(
                                fontFamily: 'Mont',
                                fontSize: 17
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            (vertretung.kurs! + " " + vertretung.vertreter!).trimEmpty().arrowFormat(),
                            style: const TextStyle(
                                fontFamily: 'Mont',
                                fontSize: 17
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            vertretung.art!.shortVersion(),
                            style: const TextStyle(
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
                            style: const TextStyle(
                                fontFamily: 'Mont',
                                fontSize: 17
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            vertretung.stunde!,
                            style: const TextStyle(
                                fontFamily: 'Mont',
                                fontSize: 17
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            vertretung.datum!.split("-")[2] + "." + vertretung.datum!.split("-")[1],
                            style: const TextStyle(
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

  static List<String>? kurse;

  static void hideKurs(BuildContext context, String klasse, String fach, String lehrer, Function refresh){
    String jsonString = StorageManager.getString(StorageKeys.ausgeblendeteKurse);

    if(jsonString.isEmpty) {
      kurse = [];
    } else {
      kurse = List<String>.from(jsonDecode(jsonString));
    }

    if(!kurse!.contains(klasse + "|" + fach + "|" + lehrer)) {
      kurse!.add(klasse + "|" + fach + "|" + lehrer);

      StorageManager.setString(
          StorageKeys.ausgeblendeteKurse, jsonEncode(kurse));

      refresh();
    }
  }

  static void openColorpicker(BuildContext context, String klasse, String fach, Function refresh){
    fach = fach.substringToNumber().toUpperCase();

    Color currentColor = ColorChooser.pickColor(fach);

    showDialog(
        context: context,
        builder: (b){
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            elevation: 6,
            backgroundColor: Colors.transparent,
            child: Container(
              //height: 250,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20
                    ),
                    child: Text(
                      fach.shortVersion(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: PGUColors.background,
                        fontFamily: 'Mont',
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                          top: 25,
                          right: 25,
                          left: 25
                      ),
                      child: SingleChildScrollView(
                        child: BlockPicker(
                          pickerColor: currentColor,
                          onColorChanged: (c) {
                            currentColor = c;
                          },
                        ),
                      )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 20
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          padding: const EdgeInsets.only(
                              left: 25,
                              right: 25,
                              top: 15,
                              bottom: 15
                          ),
                          // color: PGUColors.accent,
                          child: const Text(
                            "Abbrechen",
                            style: TextStyle(
                                color: PGUColors.background,
                                fontFamily: 'Mont'
                            ),
                          ),
                        ),
                        FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          onPressed: () {
                            ColorChooser.updateColor(currentColor, fach);
                            refresh();
                            Navigator.of(context).pop();
                          },
                          padding: const EdgeInsets.only(
                              left: 25,
                              right: 25,
                              top: 15,
                              bottom: 15
                          ),
                          color: PGUColors.accent,
                          child: const Text(
                            "Speichern",
                            style: TextStyle(
                                color: PGUColors.text,
                                fontFamily: 'Mont'
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
    );
  }

  static void closeKeyboard(BuildContext context){
    FocusScope.of(context).unfocus();
  }
}