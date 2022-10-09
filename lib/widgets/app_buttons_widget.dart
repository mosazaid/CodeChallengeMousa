import 'package:flutter/material.dart';

import '../core/SizeConfig.dart';
import '../core/config.dart';
import 'app_texts_widget.dart';


class AppButton extends StatefulWidget {
  final GestureTapCallback onPressed;
  final String? title;
  final IconData? iconData;
  final Widget? icon;
  final double iconPadding;
  final Color? color;
  final double fontSize;
  final double padding;
  final Color fontColor;
  final bool loading;
  final bool disabled;
  final FontWeight fontWeight;
  final bool hasBorder;
  final Color? borderColor;
  final double radius;
  final double vPadding;
  final double hPadding;

  AppButton({
    required this.onPressed,
    this.title,
    this.iconData,
    this.icon,
    this.iconPadding = 5.0,
    this.color,
    this.fontSize = 2,
    this.padding = 13,
    this.loading = false,
    this.disabled = false,
    this.fontColor = Colors.white,
    this.fontWeight = FontWeight.normal,
    this.vPadding = 0,
    this.hPadding = 0,
    this.radius = 8.0,
    this.hasBorder = false,
    this.borderColor,
  });

  _AppButtonState createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: widget.loading ||widget.disabled,
      child: RawMaterialButton(
        fillColor: widget.disabled
            ? Colors.grey : widget.color ?? AppGlobal.primaryColor,
        splashColor: widget.color,
        onPressed: widget.disabled ? (){} : widget.onPressed,
        shape: RoundedRectangleBorder(
            side: BorderSide(
              color:
                  widget.hasBorder ? widget.borderColor! : widget.disabled
                      ? Colors.grey : widget.color ?? AppGlobal.primaryColor,
              width: 0.8,
            ),
            borderRadius: BorderRadius.all(Radius.circular(widget.radius))),
        child: Padding(
          padding: (widget.hPadding > 0 || widget.vPadding > 0)
              ? EdgeInsets.symmetric(
                  vertical: widget.vPadding, horizontal: widget.hPadding)
              : EdgeInsets.only(
                  top: widget.padding,
                  bottom: widget.padding,
                  //right: SizeConfig.widthMultiplier * widget.padding,
                  //left: SizeConfig.widthMultiplier * widget.padding
                ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (widget.icon != null)
                SizedBox(width: 25, height: 25, child: widget.icon),
              if (widget.iconData != null)
                Icon(
                  widget.iconData,
                  color: Colors.white,
                ),
              if (widget.icon != null || widget.iconData != null)
                SizedBox(
                  width: widget.iconPadding,
                ),
              widget.loading
                  ? Padding(
                      padding: EdgeInsets.all(2.6),
                      child: SizedBox(
                        height: 19.0,
                        width: 19.0,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.grey[300]!,
                          ),
                        ),
                      ),
                    )
                  : AppText(
                    widget.title!,
                    color: widget.fontColor,
                    fontSize: SizeConfig.textMultiplier * widget.fontSize,
                    fontWeight: widget.fontWeight,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
