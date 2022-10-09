import 'package:flutter/material.dart';

class RoundedContainer extends StatefulWidget {
  final double? width;
  final double? height;
  final double radius;
  final Color backgroundColor;
  final EdgeInsets? margin;
  final double elevation;
  final bool showBorder;
  final Color borderColor;
  final double shadowWidth;
  final double shadowSpreadRadius;
  final double shadowDy;
  final bool customCornerRaduis;
  final double topLeft;
  final double bottomRight;
  final double topRight;
  final double bottomLeft;
  final Widget child;
  final double borderWidth;

  const RoundedContainer(
      {required this.child,
      this.width,
      this.height,
      this.radius = 10,
      this.backgroundColor = Colors.white,
      this.margin,
      this.elevation = 1,
      this.showBorder = false,
      this.borderColor = Colors.red,
      this.shadowWidth = 0.1,
      this.shadowSpreadRadius = 10,
      this.shadowDy = 5,
      this.customCornerRaduis = false,
      this.topLeft = 0,
      this.topRight = 0,
      this.bottomRight = 0,
      this.bottomLeft = 0,
      this.borderWidth = 1});

  @override
  _RoundedContainerState createState() => _RoundedContainerState();
}

class _RoundedContainerState extends State<RoundedContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.width,
        height: widget.height,
        margin: widget.margin,
        decoration: widget.showBorder == true
            ? BoxDecoration(
                color: Theme.of(context).primaryColor,
                border: Border.all(
                    color: widget.borderColor, width: widget.borderWidth),
                borderRadius: widget.customCornerRaduis
                    ? BorderRadius.only(
                        topLeft: Radius.circular(widget.topLeft),
                        topRight: Radius.circular(widget.topRight),
                        bottomRight: Radius.circular(widget.bottomRight),
                        bottomLeft: Radius.circular(widget.bottomLeft))
                    : BorderRadius.circular(widget.radius),
                boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(widget.shadowWidth),
                      spreadRadius: widget.shadowSpreadRadius,
                      blurRadius: 5,
                      offset: Offset(0, widget.shadowDy), // changes position of shadow
                    ),
                  ])
            : null,
        child: Card(
          margin: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: widget.customCornerRaduis
                ? BorderRadius.only(
                    topLeft: Radius.circular(widget.topLeft),
                    topRight: Radius.circular(widget.topRight),
                    bottomRight: Radius.circular(widget.bottomRight),
                    bottomLeft: Radius.circular(widget.bottomLeft))
                : BorderRadius.circular(widget.radius),
          ),
          color: widget.backgroundColor,
          child: widget.child,
        ));
  }
}
