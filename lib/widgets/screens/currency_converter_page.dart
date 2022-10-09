import 'package:flutter/material.dart';

import '../../core/base_veiw.dart';
import '../../core/config.dart';
import '../../viewmodels/currency_viewmodel.dart';
import '../common/app_drawer.dart';
import '../common/app_scaffold.dart';

class CurrencyConverterPage extends StatelessWidget {
  const CurrencyConverterPage({Key? key}) : super(key: key);

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
          color: AppGlobal.backgroundColor,
        ),
      ),
    );
  }
}
