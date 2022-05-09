import 'package:flutter/material.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/widgets/widgets.dart';

//SubmitButton
//Button
//TakeFloatingButton
//GaveFloatingButton
//SmallButton

class SubmitButton extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final double width;
  final double height;
  final double elevation;
  final Color borderColor;
  final double borderRadius;
  final double borderWidth;
  final Color color;
  final Function callback;
  final GlobalKey<FormState> formKey;

  const SubmitButton({
    this.text = "",
    this.textStyle = h4_Light,
    this.width = 100,
    this.height = 50,
    this.elevation = 0.0,
    this.color = greyColor,
    this.borderColor = whiteColor,
    this.borderRadius = 10.0,
    this.borderWidth = 1.0,
    @required this.callback,
    @required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: greyColor,
            offset: Offset(0.0, elevation),
            blurRadius: (elevation == 0) ? 0 : 20, //(x,y)
          ),
        ],
      ),
      child: RawMaterialButton(
        child: Text(text, style: textStyle),
        onPressed: () {
          if (formKey.currentState.validate() == true) {
            callback();
          }
        },
      ),
    );
  }
}

class Button extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final double width;
  final double height;
  final double elevation;
  final Color borderColor;
  final double borderRadius;
  final double borderWidth;
  final Color color;
  final Function callback;

  const Button({
    this.text = "",
    this.textStyle = h4_Light,
    this.width = 100,
    this.height = 50,
    this.elevation = 0.0,
    this.color = greyColor,
    this.borderColor = whiteColor,
    this.borderRadius = 10.0,
    this.borderWidth = 1.0,
    @required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor, width: borderWidth),
        boxShadow: [
          BoxShadow(
            color: greyColor,
            offset: Offset(0.0, elevation),
            blurRadius: (elevation == 0) ? 0 : 20, //(x,y)
          ),
        ],
      ),
      child: RawMaterialButton(
        elevation: elevation,
        child: Text(text, style: textStyle),
        onPressed: () {
          callback();
        },
      ),
    );
  }
}

class TakeFloatingButton extends StatelessWidget {
  final Function callback;

  const TakeFloatingButton({@required this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        color: lightBlueColor,
      ),
      child: RawMaterialButton(
        onPressed: () {
          callback();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.rotate(angle: 3.142 / 4, child: downArrowWhiteIcon),
            width5,
            H4Light(txt: LanguageController().getText(floatButtonTake),),
          ],
        ),
      ),
    );
  }
}

class GaveFloatingButton extends StatelessWidget {
  final Function callback;

  const GaveFloatingButton({@required this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        color: lightOrangeColor,
      ),
      child: RawMaterialButton(
        onPressed: () {
          callback();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.rotate(angle: 3.142 / 4, child: upArrowWhiteIcon),
            width5,
            H4Light(txt: LanguageController().getText(floatButtonGive)),
          ],
        ),
      ),
    );
  }
}
