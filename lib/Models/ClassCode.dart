import 'package:flutter/material.dart';
import 'package:pgu/Values/Design/PGUColors.dart';
import 'package:pgu/Values/Size/SDP.dart';

class ClassCode{
  String? name;
  String? code;

  ClassCode(this.name, this.code);

  ClassCode.fromJson(Map<String, dynamic> json){
    this.name = json["name"];
    this.code = json["code"];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
    };
  }

  static Widget ClassCodeItem(ClassCode classCode, Function onDelete) {
    return Container(
      width: double.infinity,
      height: SDP.sdp(60),
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(bottom: SDP.sdp(10)),
      padding: EdgeInsets.only(left: SDP.sdp(20)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: PGUColors.background.withOpacity(0.075)),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
                text: "Klasse/Stufe\n",
                style: TextStyle(
                    fontFamily: 'Mont-normal',
                    fontSize: 12,
                    color: PGUColors.background),
                children: [
                  TextSpan(
                      text: classCode.name,
                      style: TextStyle(fontFamily: 'Mont', fontSize: 25))
                ]),
          ),
          Container(
            margin: EdgeInsets.only(left: SDP.sdp(20)),
            child: RichText(
              text: TextSpan(
                  text: "Code\n",
                  style: TextStyle(
                      fontFamily: 'Mont-normal',
                      fontSize: 12,
                      color: PGUColors.background),
                  children: [
                    TextSpan(
                        text: classCode.code,
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
                  child: Icon(
                    Icons.delete_rounded,
                    color: PGUColors.red,
                    size: 30,
                  ),
                ),
              )
          )
        ],
      ),
    );
  }
}