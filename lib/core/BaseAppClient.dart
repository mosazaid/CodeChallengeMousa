import 'dart:convert';
import 'package:codechallengemousa/core/config.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class BaseAppClient {

  get(String endPoint,
      {required Function(dynamic response, int statusCode) onSuccess,
        required Function(String error, int statusCode) onFailure,
        Map<String, dynamic>? queryParams,
        bool isExternal = false}) async {
    String url;
    if (isExternal) {
      url = endPoint;
    } else {
      url = baseUrl + endPoint;
    }
    if (queryParams != null) {
      String queryString = Uri(queryParameters: queryParams).query;
      url += '?$queryString';
    }
    if (kDebugMode) {
      print("URL : $url");
    }

      var uri = Uri.parse(url.trim());
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
      );
      final int statusCode = response.statusCode;
      if (kDebugMode) {
        print("statusCode :$statusCode");
      }

      if (statusCode < 200 || statusCode >= 400) {
        onFailure('Error While Fetching data', statusCode);
      } else {
        // var parsed = json.decode(response.body.toString());
        var parsed = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(parsed, statusCode);
      }
  }
}