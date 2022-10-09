import 'dart:developer';

import 'package:codechallengemousa/core/base_Service.dart';
import 'package:codechallengemousa/core/config.dart';
import 'package:codechallengemousa/data/country_currency.dart';
import 'package:codechallengemousa/data/database_helpers.dart';

class CurrencyService extends BaseService {
  List<CountryCurrency> currencies = [];
  Map<String, dynamic> currencyHistory = {};

  Future checkDataFromDBAndGetData() async {
    hasError = false;
    await readFromDB();
    if (currencies.isEmpty) {
      await getCurrenciesFromNetwork();
    }
  }

  Future getCurrenciesFromNetwork() async {
    hasError = false;

    Map<String, dynamic> body = {};
    body['apiKey'] = API_KEY;

    await baseAppClient.get(getCountriesList,
        onSuccess: (dynamic body, int statusCode) {
      currencies.clear();
      if (body['results'] != null) {
        Map<String, dynamic> result = body['results'];
        result.forEach((key, value) async {
          CountryCurrency currency = CountryCurrency(
              key.toLowerCase(),
              value['name'],
              value['currencyId'],
              value['currencyName'],
              value['currencySymbol'],
              value['alpha3']);
          if (currency.id != "il") {
            // this is because there is no country called that and it is always Palestine
            currencies.add(currency);
            await addToDB(currency);
          }
        });
      }
      /* body['results'].forEach((data) {
            // currencies.add(CountryCurrency.fromJson(data));
            print(data);
          });*/
    }, onFailure: (String error, int statusCode) {
      hasError = true;
      super.error = error;
    }, queryParams: body);
  }

  Future getCurrenciesHistory(
      String convertCurrencies, String sDate, String eDate) async {
    hasError = false;

    Map<String, dynamic> body = {};
    body['q'] = convertCurrencies;
    body['compact'] = 'ultra';
    body['date'] = sDate;
    body['endDate'] = eDate;
    body['apiKey'] = API_KEY;

    await baseAppClient.get(GET_CURRENCIES_HISTORY,
        onSuccess: (dynamic body, int statusCode) {
      currencyHistory.clear();
      if (body != null) {
        currencyHistory = body;
      }
    }, onFailure: (String error, int statusCode) {
      hasError = true;
      super.error = error;
    }, queryParams: body);
  }

  Future readFromDB() async {
    log('Read Complete Data');
    DatabaseHelper helper = DatabaseHelper.instance;
    List<CountryCurrency>? temp = await helper.queryAllCurrency();
    currencies = temp ?? [];
  }

  Future deleteFromDB(int id) async {
    // delete one currency
    DatabaseHelper helper = DatabaseHelper.instance;
    log('Delete Data from id: $id');
    await helper.deleteCurrency(id);
  }

  Future addToDB(CountryCurrency currency) async {
    // insert
    DatabaseHelper helper = DatabaseHelper.instance;
    helper.insert(currency);
  }
}
