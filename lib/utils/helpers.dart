import 'package:flutter/material.dart';

class Helpers {

  static InputDecoration textFieldSelectorDecoration(
      String hintText, String? selectedText, bool isDropDown,
      {Icon? suffixIcon, Color? dropDownColor}) {
    return InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFFCCCCCC), width: 2.0),
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFFCCCCCC), width: 2.0),
        borderRadius: BorderRadius.circular(8),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFFCCCCCC), width: 2.0),
        borderRadius: BorderRadius.circular(8),
      ),
      hintText: selectedText ?? hintText,
      suffixIcon: isDropDown
          ? suffixIcon ?? Icon(
        Icons.arrow_drop_down,
        color: dropDownColor ?? Colors.black,
      )
          : null,
      hintStyle: TextStyle(
        fontSize: 14,
        color: Colors.grey.shade600,
      ),
    );
  }
}