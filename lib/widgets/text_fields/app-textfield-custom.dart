import 'package:codechallengemousa/widgets/text_fields/text_field_error.dart';
import 'package:codechallengemousa/widgets/text_fields/text_fields_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/SizeConfig.dart';
import '../../core/config.dart';
import '../app_texts_widget.dart';

class AppTextFieldCustom extends StatefulWidget {
  final double height;
  final Function()? onClick;
  final String hintText;
  final bool needUpperHint;
  final TextEditingController? controller;
  final bool isIconSuffix;
  final bool isDropDown;
  final bool hasBorder;
  final String? dropDownText;
  final IconButton? textFieldIcon;
  final Color? dropDownColor;
  final Color? underLineColor;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? textColor;
  final bool enabled;
  final TextInputType? inputType;
  final TextAlign? textAlign;
  final int minLines;
  final int maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final String? validationError;
  final bool canObscure;
  final TextInputAction? textInputAction;
  final double horizontalSpace;
  final double verticalSpace;

  const AppTextFieldCustom({
    super.key,
    this.height = 0,
    this.onClick,
    required this.hintText,
    this.needUpperHint = false,
    this.controller,
    this.hasBorder = true,
    this.isIconSuffix = true,
    this.isDropDown = false,
    this.dropDownText,
    this.textFieldIcon,
    this.dropDownColor,
    this.underLineColor,
    this.borderColor,
    this.backgroundColor,
    this.textColor,
    this.enabled = true,
    this.inputType,
    this.textAlign,
    this.minLines = 1,
    this.maxLines = 1,
    this.inputFormatters,
    this.onChanged,
    this.validationError,
    this.canObscure = false,
    this.textInputAction,
    this.horizontalSpace = 0,
    this.verticalSpace = 0,
  });

  @override
  _AppTextFieldCustomState createState() => _AppTextFieldCustomState();
}

class _AppTextFieldCustomState extends State<AppTextFieldCustom> {
  bool _isSecure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: widget.height != 0 && widget.maxLines == 1
              ? widget.height + 8
              : null,
          decoration: widget.hasBorder
              ? TextFieldsUtils.containerBorderDecoration(
                  widget.backgroundColor ?? const Color(0Xffffffff),
                  widget.validationError == null
                      ? widget.borderColor ?? const Color(0xFFEFEFEF)
                      : Colors.red.shade700)
              : !widget.hasBorder && widget.dropDownText != null
                  ? BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: widget.underLineColor ??
                              (widget.hasBorder
                                  ? const Color(0Xffffffff)
                                  : Colors.grey[300]!),
                        ),
                      ),
                    )
                  : null,
          margin: EdgeInsets.only(
              top: widget.verticalSpace,
              bottom: widget.verticalSpace,
              left: widget.horizontalSpace,
              right: widget.horizontalSpace),
          child: InkWell(
            onTap: widget.onClick,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (!widget.isIconSuffix && widget.textFieldIcon != null)
                  widget.textFieldIcon!,
                Expanded(
                  child: Container(
                    padding: widget.dropDownText == null
                        ? EdgeInsets.symmetric(
                            horizontal: widget.isIconSuffix ? 8 : 0)
                        : EdgeInsets.symmetric(
                            horizontal: widget.isIconSuffix ? 8 : 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.needUpperHint)
                          if ((widget.controller != null &&
                                  widget.controller!.text != "") ||
                              widget.dropDownText != null)
                            AppText(
                              widget.hintText,
                              color: widget.textColor ?? const Color(0xFF2E303A),
                              fontSize: SizeConfig.textMultiplier * 1.3,
                              fontWeight: FontWeight.w700,
                            ),
                        widget.dropDownText == null
                            ? Container(
                                height:
                                    widget.height != 0 && widget.maxLines == 1
                                        ? widget.height - 22
                                        : null,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                child: TextFormField(
                                  textAlign: widget.textAlign ?? TextAlign.left,
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: TextFieldsUtils
                                      .textFieldSelectorDecoration(
                                          widget.hintText, null, true,
                                          obscureIcon: widget.canObscure
                                              ? IconButton(
                                                  icon: Icon(_isSecure
                                                      ? Icons.visibility_off
                                                      : Icons.visibility),
                                                  onPressed: () {
                                                    setState(() {
                                                      _isSecure = !_isSecure;
                                                    });
                                                  },
                                                )
                                              : null,
                                          textColor: widget.textColor ??
                                              AppGlobal.textColor),
                                  style: TextStyle(
                                    fontSize: SizeConfig.textMultiplier * 1.7,
                                    color:
                                        widget.textColor ?? AppGlobal.textColor,
                                  ),
                                  controller: widget.controller,
                                  keyboardType: widget.inputType ??
                                      (widget.maxLines == 1
                                          ? TextInputType.text
                                          : TextInputType.multiline),
                                  enabled: widget.enabled,
                                  minLines: widget.minLines,
                                  maxLines: widget.maxLines,
                                  inputFormatters: widget.inputFormatters ?? [],
                                  onChanged: (value) {
                                    setState(() {});
                                    if (widget.onChanged != null) {
                                      widget.onChanged!(value);
                                    }
                                  },
                                  obscureText:
                                      widget.canObscure ? _isSecure : false,
                                  textInputAction: widget.textInputAction,
                                  onFieldSubmitted: (_) => widget
                                              .textInputAction ==
                                          TextInputAction.next
                                      ? FocusScope.of(context)
                                          .nextFocus() // focus to next
                                      : FocusScope.of(context)
                                          .unfocus(), // Unfocus and hide keyboard
                                ),
                              )
                            : AppText(
                                widget.dropDownText!,
                                color: const Color(0xFF575757),
                                fontSize: SizeConfig.textMultiplier * 1.7,
                              ),
                      ],
                    ),
                  ),
                ),
                if (widget.isDropDown)
                  InkWell(
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: widget.dropDownColor ?? Colors.black,
                    ),
                  )
                else
                  widget.isIconSuffix && widget.textFieldIcon != null
                      ? widget.textFieldIcon!
                      : Container(),
              ],
            ),
          ),
        ),
        if (widget.validationError != null)
          TextFieldsError(error: widget.validationError!),
      ],
    );
  }
}
