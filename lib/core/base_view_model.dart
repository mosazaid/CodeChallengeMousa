import 'package:codechallengemousa/core/config.dart';
import 'package:flutter/material.dart';

class BaseViewModel extends ChangeNotifier {
  ViewState _state = ViewState.Idle;

  ViewState get state => _state;

  String error = "";

  void setState(ViewState viewState) {
    _state = viewState;

    notifyListeners();
  }

}