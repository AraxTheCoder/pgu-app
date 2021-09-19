import 'package:flutter/material.dart';
import 'package:pgu/Values/Size/SDP.dart';

class RoundOutlinedButton extends StatelessWidget{
  String text;
  double paddingTop, paddingLeft, paddingRight;
  GestureTapCallback? onClick;
  Color buttonColor;
  Color? textColor;
  double height;
  double? fontSize;

  RoundOutlinedButton(this.text, this.buttonColor, { this.paddingTop = 0, this.paddingLeft = 30, this.paddingRight = 30, this.onClick, this.textColor, this.height = 37.5, this.fontSize = 15 });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: FractionalOffset.topCenter,
      child: Padding(
        padding: EdgeInsets.only(
            left: SDP.sdp(paddingLeft),
            right: SDP.sdp(paddingRight),
            top: paddingTop
        ),
        child: SizedBox(
          width: double.infinity,
          height: SDP.sdp(height),
          child: RaisedButton(
            color: buttonColor,
            onPressed: onClick,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(SDP.sdp(25)),
              side: BorderSide(
                style: BorderStyle.solid,
                color: textColor != null? textColor! : Colors.white,
                width: SDP.sdp(1.5)
              )
            ),
            child: Align(
              alignment: FractionalOffset.center,
              child: Text(
                text,
                style: TextStyle(
                    color: textColor != null? textColor : Colors.white,
                    fontFamily: 'Mont',
                    fontSize: SDP.sdp(fontSize!)
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}