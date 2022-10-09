import 'package:flutter/material.dart';

const baseUrl = 'https://free.currconv.com';
const API_KEY = 'pr_ca566c61d9a841d6a37b94ecde245a35';
const getCurrencyList = '/api/v7/currencies';
const getCountriesList = '/api/v7/countries';
const GET_CURRENCIES_HISTORY = '/api/v7/convert';

enum ViewState { Idle, Busy, Error, BusyLocal, ErrorLocal }

enum APP_STATUS { LOADING, NORMAL }

class AppGlobal {
  static Color textColor = const Color(0xFF575757);
  static Color primaryColor = const Color(0xFFef5e9f);
  static Color secondaryColor = const Color(0xFF413434);
  static Color backgroundColor = const Color(0x3D191919);
  static Color backgroundLightColor = const Color(0x132d2d2e);
}