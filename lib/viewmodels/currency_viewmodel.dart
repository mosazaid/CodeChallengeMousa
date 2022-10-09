import 'package:codechallengemousa/core/base_view_model.dart';
import 'package:codechallengemousa/core/config.dart';
import 'package:codechallengemousa/data/country_currency.dart';
import 'package:codechallengemousa/locator.dart';
import 'package:codechallengemousa/services/currency_service.dart';
import 'package:intl/intl.dart';

class CurrencyViewModel extends BaseViewModel {
  final CurrencyService _service = locator<CurrencyService>();

  List<CountryCurrency> get currencies => _service.currencies;

  Map<String, dynamic> get currencyHistory => _service.currencyHistory;

  Map<String, dynamic> get currencyConvert => _service.currencyConvert;

  String convertedCurrencyValue = "";

  void setConvertedValue() {
    currencyConvert.forEach((key, value) {
      convertedCurrencyValue = "$key : $value";
    });
    if (currencyConvert.isEmpty) {
      convertedCurrencyValue = "can't convert between currencies";
    }
    notifyListeners();
  }

  CountryCurrency getCurrency(dynamic currency) {
    return currency as CountryCurrency;
  }

  getCurrencies() async {
    setState(ViewState.Busy);
    await _service.checkDataFromDBAndGetData();
    if (_service.hasError) {
      error = _service.error ?? "";
      setState(ViewState.Error);
    } else {
      setState(ViewState.Idle);
    }
  }

  getCurrencyHistory() async {
    setState(ViewState.Busy);
    DateTime now = DateTime.now();
    DateTime nowMinus7 = DateTime(now.year, now.month, now.day - 7);
    String formattedSDate = DateFormat('yyyy-MM-dd').format(nowMinus7);
    String formattedEDate = DateFormat('yyyy-MM-dd').format(now);

    await _service.getCurrenciesHistory(
        "USD_JOD,JOD_USD", formattedSDate, formattedEDate);
    if (_service.hasError) {
      error = _service.error ?? "";
      setState(ViewState.Error);
    } else {
      setState(ViewState.Idle);
    }
  }

  List<Map<String, String>> getHistoryListFromConvertKey(String key) {
    List<Map<String, String>> history = [];
    Map<String, dynamic> historyMap = currencyHistory[key];
    historyMap.forEach((key, value) {
      history.add({'date': key, 'value': value.toString()});
    });
    return history;
  }

  Future getCurrencyConvertedValue(String currency1, String currency2) async {
    setState(ViewState.BusyLocal);
    String convertedValue = "${currency1}_$currency2";
    await _service.getCurrenciesConvert(convertedValue);

    if (_service.hasError) {
      error = _service.error ?? "";
      setState(ViewState.ErrorLocal);
    } else {
      setConvertedValue();
      setState(ViewState.Idle);
    }
  }
}
