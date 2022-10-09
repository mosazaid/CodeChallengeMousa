import 'package:codechallengemousa/widgets/text_fields/text_field_error.dart';
import 'package:codechallengemousa/widgets/text_fields/text_fields_utils.dart';
import 'package:flutter/material.dart';

class CustomAutoCompleteTextField extends StatelessWidget {
  final bool isShowError;
  final Widget child;

  const CustomAutoCompleteTextField({
    Key? key,
    this.isShowError = false,
    required this.child,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            decoration: TextFieldsUtils.containerBorderDecoration(
              const Color(0Xffffffff),
              isShowError ? Colors.red.shade700 : const Color(0xFFEFEFEF),
            ),
            padding:
                const EdgeInsets.only(top: 0.2, bottom: 2.0, left: 8.0, right: 0.0),
            child: child,
          ),
          if (isShowError)
            const TextFieldsError(
              error: "something went wrong",
            )
        ],
      ),
    );
  }
}
