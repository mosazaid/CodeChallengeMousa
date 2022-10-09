import 'dart:math';

// database table and column names
const String tableCurrency = 'country_currency';
const String columnId = 'id';
const String columnName = 'name';
const String columnCurrencyId = 'currency_id';
const String columnCurrencyName = 'currency_name';
const String columnCurrencySymbol = 'currency_symbol';
const String columnAlpha3 = 'alpha3';

class CountryCurrency {
  late String _id;
  late String _name;
  late String _currencyId;
  late String _currencyName;
  late String _currencySymbol;
  late String _alpha3;

  String get id => _id;

  String get name => _name;

  String get currencyId => _currencyId;

  String get currencyName => _currencyName;

  String get currencySymbol => _currencySymbol;

  String get alpha3 => _alpha3;

  CountryCurrency(this._id, this._name, this._currencyId, this._currencyName,
      this._currencySymbol, this._alpha3);

  CountryCurrency.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _currencyId = json['currencyId'];
    _currencyName = json['currencyName'];
    _currencySymbol = json['currencySymbol'];
    _alpha3 = json['alpha3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['name'] = _name;
    data['currencyId'] = _currencyId;
    data['currencyName'] = _currencyName;
    data['currencySymbol'] = _currencySymbol;
    data['alpha3'] = _alpha3;
    return data;
  }

  factory CountryCurrency.fromMap(Map<String, dynamic> map) => CountryCurrency(
      map[columnId],
      map[columnName],
      map[columnCurrencyId],
      map[columnCurrencyName],
      map[columnCurrencySymbol],
      map[columnAlpha3]);

  // convenience method to create a Map from this Currency object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnName: _name,
      columnCurrencyId: _currencyId,
      columnCurrencyName: _currencyName,
      columnCurrencySymbol: _currencySymbol,
      columnAlpha3: _alpha3
    };
    map[columnId] = _id;
    return map;
  }

}
