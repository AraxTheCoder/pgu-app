import 'package:flutter/material.dart';

class Keyboard{
  static void close(BuildContext context){
    FocusScope.of(context).unfocus();
  }
}