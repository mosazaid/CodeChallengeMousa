import 'package:flutter/material.dart';

class TextFieldsUtils {
  static BoxDecoration containerBorderDecoration(
      Color containerColor, Color borderColor,
      {double borderWidth = -1, double borderRadius = 12}) {
    return BoxDecoration(
      color: containerColor,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      border: Border.fromBorderSide(BorderSide(
        color: borderColor,
        width: borderWidth == -1 ? 2.0 : borderWidth,
      )),
    );
  }

  static InputDecoration textFieldSelectorDecoration(
      String hintText, String? selectedText, bool isDropDown,
      {IconData? suffixIcon,
      Color? dropDownColor,
      bool hasBorder = false, Color? underLineColor,
      IconButton? obscureIcon,
      Color? textColor}) {
    return InputDecoration(
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      counterText: '',
      focusedBorder:
          _setBorder(hasBorder: hasBorder, underLineColor: underLineColor),
      enabledBorder:
          _setBorder(hasBorder: hasBorder, underLineColor: underLineColor),
      disabledBorder:
          _setBorder(hasBorder: hasBorder, underLineColor: underLineColor),
      hintText: selectedText ?? hintText,
      suffixIcon: obscureIcon ??
          Icon(
            suffixIcon,
            color: Colors.white,
          ),
      hintStyle: TextStyle(
        fontSize: 16,
        color: textColor, // Colors.grey.shade600
      ),
    );
  }

  static InputBorder _setBorder(
      {bool hasBorder = false, Color? underLineColor}) {
    return hasBorder
        ? OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFCCCCCC), width: 2.0),
            borderRadius: BorderRadius.circular(8),
          )
        : UnderlineInputBorder(
            borderSide: BorderSide(
                color: underLineColor ??
                    (hasBorder ? const Color(0Xffffffff) : const Color(0xFF555863))),
          );
  }
}
