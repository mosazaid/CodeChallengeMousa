import 'package:codechallengemousa/core/base_veiw.dart';
import 'package:codechallengemousa/core/config.dart';
import 'package:codechallengemousa/viewmodels/currency_viewmodel.dart';
import 'package:codechallengemousa/widgets/common/app_scaffold.dart';
import 'package:codechallengemousa/widgets/app_texts_widget.dart';
import 'package:flutter/material.dart';

import '../common/app_drawer.dart';

class CurrencyListPage extends StatelessWidget {
  const CurrencyListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<CurrencyViewModel>(
      onModelReady: (model) async {
        model.getCurrencies();
      },
      builder: (_, model, w) => AppScaffold(
        baseViewModel: model,
        isShowAppBar: true,
        appBarTitle: "All currencies",
        drawer: const SafeArea(child: AppDrawer()),
        body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: model.currencies.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: MediaQuery.of(context).size.width * 3 / 4,
                            padding: const EdgeInsets.only(
                                top: 8, bottom: 8.0, left: 16.0, right: 16.0),
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppGlobal.backgroundColor,
                                  style: BorderStyle.solid,
                                  width: 1.0,
                                ),
                                color: AppGlobal.backgroundLightColor,
                                borderRadius: BorderRadius.circular(12.0)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(
                                      model.currencies[index].name,
                                      color: Colors.black,
                                      bold: true,
                                      fontSize: 16,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      child: Image.asset(
                                          'assets/images/flags/${model.currencies[index].id}.png',
                                          width: 30,
                                          fit: BoxFit.cover),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                AppText(
                                  "${model.currencies[index].currencyName} ( ${model.currencies[index].currencyId} )",
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                )
                              ],
                            ),
                          );
                        }),
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
