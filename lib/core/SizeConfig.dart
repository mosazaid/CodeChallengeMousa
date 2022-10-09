import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'config.dart';

const MAX_SMALL_SCREEN = 660;

class SizeConfig {
  static double _blockWidth = 0;
  static double _blockHeight = 0;

  static late double realScreenWidth;
  static late double realScreenHeight;
  static late double screenWidth;
  static late double screenHeight;
  static late double textMultiplier;
  static late double imageSizeMultiplier;
  static late double heightMultiplier;
  static late double widthMultiplier;

  static bool isPortrait = true;
  static bool isMobilePortrait = false;
  static bool isMobile = false;

  void init(BoxConstraints constraints, Orientation orientation) {
    realScreenHeight = constraints.maxHeight;
    realScreenWidth = constraints.maxWidth;


    if (constraints.maxWidth <= MAX_SMALL_SCREEN) {
      isMobile = true;
    }
    if (orientation == Orientation.portrait) {
      isPortrait = true;
      if (realScreenWidth < 450) {
        isMobilePortrait = true;
      }
      // textMultiplier = _blockHeight;
      // imageSizeMultiplier = _blockWidth;
      screenHeight = realScreenHeight;
      screenWidth = realScreenWidth;
    } else {
      isPortrait = false;
      isMobilePortrait = false;
      // textMultiplier = _blockWidth;
      // imageSizeMultiplier = _blockHeight;
      screenHeight = realScreenWidth;
      screenWidth = realScreenHeight;
    }
    _blockWidth = screenWidth / 100;
    _blockHeight = screenHeight / 100;

    textMultiplier = _blockHeight;
    imageSizeMultiplier = _blockWidth;
    heightMultiplier = _blockHeight;
    widthMultiplier = _blockWidth;

    if (kDebugMode) {
      print('realScreenWidth $realScreenWidth');
      print('realScreenHeight $realScreenHeight');
      print('textMultiplier $textMultiplier');
      print('imageSizeMultiplier $imageSizeMultiplier');
      print('heightMultiplier$heightMultiplier');
      print('widthMultiplier $widthMultiplier');
      print('isPortrait $isPortrait');
      print('isMobilePortrait $isMobilePortrait');
    }
  }
}