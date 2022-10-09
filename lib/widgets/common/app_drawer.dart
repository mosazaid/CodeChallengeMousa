import 'package:codechallengemousa/widgets/common/rounded_container_widget.dart';
import 'package:codechallengemousa/widgets/screens/currency_list_page.dart';
import 'package:flutter/material.dart';

import '../../core/SizeConfig.dart';
import '../screens/currency_history_page.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      width: SizeConfig.realScreenWidth * 0.60,
      margin: const EdgeInsets.all(0),
      customCornerRaduis: false,
      child: Container(
        color: Colors.white,
        child: Drawer(
          child: ListView(padding: EdgeInsets.zero, children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Digitinary Code Challenge'),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const CurrencyListPage()));
              },
            ),
            ListTile(
              title: const Text('History'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const CurrencyHistoryPage()));
              },
            ),
            ListTile(
              title: const Text('Currency Converter'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const CurrencyListPage()));
              },
            ),
          ]),
        ),
      ),
    );
  }
}
