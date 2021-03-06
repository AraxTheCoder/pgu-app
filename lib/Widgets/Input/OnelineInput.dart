import 'package:flutter/material.dart';
import 'package:pgu/Values/Design/PGUColors.dart';

Widget OnelineInput(TextEditingController controller, String hint, IconData suffix){
  return TextField(
    maxLines: 1,
    autofocus: false,
    keyboardType: TextInputType.name,
    style: const TextStyle(
        color: PGUColors.background,
        fontFamily: 'Mont'
    ),
    controller: controller,
    decoration: InputDecoration(
      fillColor: PGUColors.inputBackground,
      filled: true,
      hintText: hint,
      prefix: const SizedBox(width: 15,),
      suffixIconConstraints: const BoxConstraints(
        minHeight: 60,
        minWidth: 60
      ),
      suffixIcon: Container(
        decoration: BoxDecoration(
          color: PGUColors.accent,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            style: BorderStyle.none
          )
        ),
        child: Icon(
            suffix,
          color: PGUColors.background.withOpacity(0.2),
        ),
      ),
      hintStyle: const TextStyle(
          color: PGUColors.inactive,
          fontFamily: 'Mont'
      ),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none
      ),
    ),
  );
}