import 'package:flutter/material.dart';

import '../../core/base_veiw.dart';
import '../../core/config.dart';
import '../../viewmodels/currency_viewmodel.dart';
import '../app_texts_widget.dart';
import '../common/app_drawer.dart';
import '../common/app_scaffold.dart';

class CurrencyHistoryPage extends StatelessWidget {
  const CurrencyHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<CurrencyViewModel>(
      onModelReady: (model) async {
        model.getCurrencyHistory();
      },
      builder: (_, model, w) => AppScaffold(
        baseViewModel: model,
        isShowAppBar: true,
        appBarTitle: "Currency History",
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
                    itemCount: model.currencyHistory.length,
                    itemBuilder: (context, index) {
                      String key = model.currencyHistory.keys.elementAt(index);
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
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              key,
                              color: Colors.black,
                              bold: true,
                              fontSize: 16,
                            ),
                            ...model.getHistoryListFromConvertKey(key)
                            .map((e) => Container(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Row(
                                children: [
                                  AppText(
                                    "${e['date']} : ${e['value']}",
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ],
                              ),
                            ))
                            .toList(),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
