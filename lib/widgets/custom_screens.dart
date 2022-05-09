import 'package:flutter/material.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/widgets/texts.dart';


class NoDataScreen extends StatelessWidget {
  final String text;
  final double height;
  const NoDataScreen({this.text = "No data found", this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: displayWidth(context),
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
              image: AssetImage("assets/images/no_data.png"), height: 80, width: 80,),
          T14Dark(txt: text),
        ],
      ),
    );
  }
}

class ErrorScreen extends StatelessWidget {
  final String text;
  final double height;
  const ErrorScreen({this.text = "Some error occured", this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: displayWidth(context),
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
              image: AssetImage("assets/images/error_data.png"),
              height: 80,
              width: 80,),
          T14Dark(txt: text),
        ],
      ),
    );
  }
}
