import 'package:flutter/material.dart';

class AppLoaderWidget extends StatefulWidget {
  final Color? containerColor;

  const AppLoaderWidget({Key? key, this.containerColor}) : super(key: key);

  @override
  _AppLoaderWidgetState createState() => new _AppLoaderWidgetState();
}

class _AppLoaderWidgetState extends State<AppLoaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Container(
            color: widget.containerColor ?? Colors.grey.withOpacity(0.6),
          ),
          Center(
            child: Container(
                width: 20, height: 20, child: const CircularProgressIndicator()),
          )
          /*Container(child: GifLoaderContainer(), margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.09))*/
        ],
      ),
    );
  }
}
