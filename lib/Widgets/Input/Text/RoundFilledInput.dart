import 'package:flutter/material.dart';
import 'package:pgu/Values/Design/PGUColors.dart';
import 'package:pgu/Values/Size/SDP.dart';

class RoundFilledInput extends StatefulWidget {
  String hint;
  double? paddingTop, paddingSide, radius, hintSize, height;
  TextInputAction inputAction;
  bool obscureText;
  Color text, background;

  TextEditingController controller;

  RoundFilledInput(this.hint, this.controller,
      {this.text = PGUColors.text,
      this.background = PGUColors.background,
      this.paddingTop = 0,
      this.paddingSide = 25,
      this.radius = 10,
      this.hintSize = 20,
      this.height = 37.5,
      this.inputAction = TextInputAction.next,
      this.obscureText = false});

  @override
  _RoundInputState createState() => _RoundInputState();
}

class _RoundInputState extends State<RoundFilledInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: SDP.sdp(widget.paddingSide!),
          right: SDP.sdp(widget.paddingSide!),
          top: SDP.sdp(widget.paddingTop!)),
      child: Container(
        height: SDP.sdp(widget.height!),
        child: TextField(
          textInputAction: widget.inputAction,
          textCapitalization: TextCapitalization.sentences,
          keyboardType: TextInputType.text,
          obscureText: widget.obscureText,
          controller: widget.controller,
          maxLines: 1,
          style: TextStyle(
              color: widget.text,
              fontSize: SDP.sdp(widget.hintSize!),
              fontFamily: 'Mont'),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(SDP.sdp(widget.radius!)),
            ),
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              //borderSide: BorderSide(color: widget.text, width: 1.0),
              borderRadius:
                  BorderRadius.circular(SDP.sdp(widget.radius! * 0.65)),
            ),
            filled: true,
            hintStyle: new TextStyle(
              color: widget.text.withAlpha(200),
            ),
            hintText: widget.hint,
            fillColor: widget.background,
            contentPadding: EdgeInsets.only(
                bottom: widget.height!, left: SDP.sdp(20)),
          ),
        ),
      ),
    );
  }
}
