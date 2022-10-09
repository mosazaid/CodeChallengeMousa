import 'package:codechallengemousa/widgets/app_texts_widget.dart';
import 'package:codechallengemousa/widgets/text_fields/app-textfield-custom.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../core/base_veiw.dart';
import '../../core/config.dart';
import '../../data/country_currency.dart';
import '../../viewmodels/currency_viewmodel.dart';
import '../app_buttons_widget.dart';
import '../common/ListSelectDialog.dart';
import '../common/app_drawer.dart';
import '../common/app_scaffold.dart';

class CurrencyConverterPage extends StatefulWidget {
  const CurrencyConverterPage({Key? key}) : super(key: key);

  @override
  State<CurrencyConverterPage> createState() => _CurrencyConverterPageState();
}

class _CurrencyConverterPageState extends State<CurrencyConverterPage> {
  CountryCurrency? _selectedCurrency1;
  CountryCurrency? _selectedCurrency2;

  String? currency1Error;
  String? currency2Error;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return BaseView<CurrencyViewModel>(
      builder: (_, model, w) => AppScaffold(
        baseViewModel: model,
        isShowAppBar: true,
        appBarTitle: "Currency Converter",
        drawer: const SafeArea(child: AppDrawer()),
        body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              width: double.infinity,
              height: screenSize.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppText(
                    "Select 2 currencies to convert",
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  AppTextFieldCustom(
                    hintText: "Select Currency 1",
                    height: screenSize.height * 0.075,
                    dropDownText: _selectedCurrency1 != null
                        ? _selectedCurrency1!.currencyId/*['_name']*/
                        : null,
                    enabled: false,
                    isIconSuffix: true,
                    validationError: currency1Error,
                    onClick: () {
                      ListSelectDialog dialog = ListSelectDialog(
                          list: model.currencies,
                          attributeName: '_name',
                          attributeValueId: '_id',
                          okText: 'ok',
                          okFunction: (selectedValue) {
                            setState(() {
                              _selectedCurrency1 = selectedValue;
                            });
                          });
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return dialog;
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  AppTextFieldCustom(
                    hintText: "Select Currency 2",
                    height: screenSize.height * 0.075,
                    dropDownText: _selectedCurrency2 != null
                        ? _selectedCurrency2!.currencyId/*['_name']*/
                        : null,
                    enabled: false,
                    isIconSuffix: true,
                    validationError: currency2Error,
                    onClick: () {
                      ListSelectDialog dialog = ListSelectDialog(
                          list: model.currencies,
                          attributeName: '_name',
                          attributeValueId: '_id',
                          okText: 'ok',
                          okFunction: (selectedValue) {
                            setState(() {
                              _selectedCurrency2 = selectedValue;
                            });
                          });
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return dialog;
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  AppButton(
                    title: "Convert",
                    color: const Color(0xFF555863),
                    fontSize: 2,
                    fontWeight: FontWeight.w500,
                    onPressed: () async {
                      if(_selectedCurrency1 != null && _selectedCurrency2 != null){
                        await model.getCurrencyConvertedValue(_selectedCurrency1!.currencyId, _selectedCurrency2!.currencyId).then((value) => null);
                      } else {
                        Fluttertoast.showToast(
                            msg: "need to select currency 1 and currency 2",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                   AppText(
                    model.convertedCurrencyValue,
                    color: Colors.red,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
