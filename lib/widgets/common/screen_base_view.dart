import 'package:codechallengemousa/core/base_view_model.dart';
import 'package:codechallengemousa/core/config.dart';
import 'package:codechallengemousa/widgets/app_texts_widget.dart';
import 'package:flutter/material.dart';

import 'app_loader_widget.dart';

class ScreenBaseView extends StatelessWidget {
  final BaseViewModel baseViewModel;
  final Widget child;

  const ScreenBaseView(
      {super.key, required this.baseViewModel, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: buildBaseViewWidget(),
    );
  }

  buildBaseViewWidget() {
    switch (baseViewModel.state) {
      case ViewState.ErrorLocal:
      case ViewState.Idle:
      case ViewState.BusyLocal:
        return child;
      case ViewState.Busy:
        return AppLoaderWidget(containerColor: AppGlobal.backgroundColor);
      case ViewState.Error:
        return Center(
          child:
              AppText(baseViewModel.error, textAlign: TextAlign.center),
        );
    }
  }
}
