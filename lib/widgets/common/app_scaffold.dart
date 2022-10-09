import 'package:codechallengemousa/core/base_view_model.dart';
import 'package:codechallengemousa/core/config.dart';
import 'package:codechallengemousa/widgets/common/app_loader_widget.dart';
import 'package:codechallengemousa/widgets/app_texts_widget.dart';
import 'package:codechallengemousa/widgets/common/screen_base_view.dart';
import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final String appBarTitle;
  final Widget? body;
  final bool isLoading;
  final bool isShowAppBar;
  final BaseViewModel? baseViewModel;
  final Color? backgroundColor;
  final PreferredSizeWidget? appBar;
  final Widget? drawer;
  final Widget? bottomNavigationBar;
  final List<Widget>? actions;

  const AppScaffold(
      {super.key,
      this.appBarTitle = '',
      this.body,
      this.isLoading = false,
      this.isShowAppBar = true,
      this.baseViewModel,
      this.backgroundColor,
      this.appBar,
      this.drawer,
      this.bottomNavigationBar,
      this.actions});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
          backgroundColor: backgroundColor ?? AppGlobal.backgroundColor,
          drawer: drawer,
          bottomNavigationBar: bottomNavigationBar,
          appBar: isShowAppBar
              ? appBar ??
                  AppBar(
                    elevation: 0,
                    backgroundColor: AppGlobal.backgroundColor,
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          appBarTitle.toUpperCase(),
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ],
                    ),
                    leading: drawer != null
                        ? null
                        : Builder(builder: (BuildContext context) {
                            return InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: const Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  // AppText(
                                  //   appBarTitle.toUpperCase(),
                                  //   color: Colors.white,
                                  //   fontSize: 12,
                                  // )
                                ],
                              ),
                            );
                          }),
                    leadingWidth: 28,
                    centerTitle: false,
                    iconTheme: const IconThemeData(color: Colors.white),
                    actions: <Widget>[
                      if (actions != null) ...actions!,
                    ],
                  )
              : null,
          body: body != null
              ? baseViewModel != null
                  ? ScreenBaseView(
                      baseViewModel: baseViewModel!,
                      child: body!,
                    )
                  : Stack(children: <Widget>[
                      body!,
                      buildAppLoaderWidget(isLoading)
                    ])
              : Container()),
    );
  }

  Widget buildAppLoaderWidget(bool isLoading) {
    return isLoading
        ? AppLoaderWidget(
            containerColor: AppGlobal.backgroundColor,
          )
        : Container();
  }
}
