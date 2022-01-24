import 'package:flutter/material.dart';
import 'package:pgu/Storage/StorageKeys.dart';
import 'package:pgu/Storage/StorageManager.dart';
import 'package:pgu/Values/Design/PGUColors.dart';
import 'package:pgu/Values/Size/SDP.dart';
import 'package:pgu/Extensions/StringExtensions.dart';

class ClassModel{
  String? name;

  ClassModel(this.name);

  ClassModel.fromJson(Map<String, dynamic> json){
    this.name = json["name"];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }

  static Widget item(ClassModel classCode, Function onDelete) {
    return Container(
      width: double.infinity,
      height: SDP.sdp(60),
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(bottom: SDP.sdp(10)),
      padding: EdgeInsets.only(left: SDP.sdp(30)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: PGUColors.background.withOpacity(0.075)),
      child: Row(
        children: [
          Container(
            // width: 100,
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(
                  text: classCode.name!.startsNumeric() ? "Klasse" : (StorageManager.getString(StorageKeys.loggedIn) == "s" ? "Stufe" : "Lehrer"),
                  style: TextStyle(
                      fontFamily: 'Mont-normal',
                      fontSize: 12,
                      color: PGUColors.background),
                  children: [
                    TextSpan(
                        text: "\n" + classCode.name!.formatClass(),
                        style: TextStyle(fontFamily: 'Mont', fontSize: 25))
                  ]),
            ),
          ),
          Expanded(
              child: GestureDetector(
                onTap: (){
                  onDelete(classCode);
                },
                child: Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(right: SDP.sdp(20)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.delete_rounded,
                        color: PGUColors.red,
                        size: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Entfernen",
                        style: TextStyle(fontFamily: 'Mont-normal', fontSize: 15),
                      )
                    ],
                  ),
                ),
              )
          )
        ],
      ),
    );
  }
}