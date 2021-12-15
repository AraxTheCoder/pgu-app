import 'package:flutter/services.dart';
import 'package:pgu/Extensions/StringExtensions.dart';

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.formatClass(),
      selection: newValue.selection,
    );
  }
}