import 'package:codechallengemousa/services/currency_service.dart';
import 'package:codechallengemousa/viewmodels/currency_viewmodel.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

///di
void setupLocator() {
  /// Services
  locator.registerLazySingleton(() => CurrencyService());
  /// View Model
  locator.registerFactory(() => CurrencyViewModel());
}
