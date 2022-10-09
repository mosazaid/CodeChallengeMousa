import 'package:flutter/material.dart';

import '../../data/country_currency.dart';
import '../../utils/helpers.dart';

class ListSelectDialog extends StatefulWidget {
  final List<CountryCurrency> list;
  final String attributeName;
  final String attributeValueId;
  final String okText;
  final Function(CountryCurrency) okFunction;
  CountryCurrency? selectedValue;
  final Widget? searchWidget;
  final bool usingSearch;
  final String? hintSearchText;

  ListSelectDialog({super.key,
    required this.list,
    required this.attributeName,
    required this.attributeValueId,
    required this.okText,
    required this.okFunction,
    this.searchWidget,
    this.usingSearch = false,
    this.hintSearchText,
  });

  @override
  _ListSelectDialogState createState() => _ListSelectDialogState();
}

class _ListSelectDialogState extends State<ListSelectDialog> {
  List<CountryCurrency> items = [];

  @override
  void initState() {
    widget.selectedValue = widget.selectedValue ?? widget.list[0];
    items.addAll(widget.list);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return showAlertDialog(context);
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
        child: const Text("Cancel"),
        onPressed: () {
          Navigator.of(context).pop();
        });
    Widget continueButton = TextButton(
        child: Text(widget.okText),
        onPressed: () {
          Navigator.of(context).pop();
          widget.okFunction(widget.selectedValue!);
        });
// set up the AlertDialog
    AlertDialog alert = AlertDialog(
      // title: Text(widget.title),
      content: createDialogList(),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    return alert;
  }

  Widget createDialogList() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (widget.searchWidget != null) widget.searchWidget!,
            if(widget.usingSearch)
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.070,
                  child: TextField(
                    decoration: Helpers.textFieldSelectorDecoration(
                        widget.hintSearchText ?? "Search", null, false, suffixIcon: const Icon(Icons.search,)),
                    enabled: true,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      filterSearchResults(value);
                    },
                  )),
            ...items
                .map((item) => RadioListTile(
              title: Text(item.name/*[widget.attributeName]*/.toString()),
              groupValue: widget.selectedValue!.id/*[widget.attributeValueId]*/
                  .toString(),
              value: item.id/*[widget.attributeValueId]*/.toString(),
              activeColor: Colors.blue.shade700,
              selected: item.id/*[widget.attributeValueId]*/.toString() ==
                  widget.selectedValue!.id/*[widget.attributeValueId]*/
                      .toString(),
              onChanged: (val) {
                setState(() {
                  widget.selectedValue = item;
                });
              },
            ))
                .toList()
          ],
        ),
      ),
    );
  }

  static closeAlertDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  void filterSearchResults(String query) {
    List<CountryCurrency> dummySearchList = [];
    dummySearchList.addAll(widget.list);
    if (query.isNotEmpty) {
      List<CountryCurrency> dummyListData = [];
      for (var item in dummySearchList) {
        if (item.name/*[widget.attributeName]*/.toString().toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      }
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(widget.list);
      });
    }
  }
}
