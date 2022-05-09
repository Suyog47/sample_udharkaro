import 'package:flutter/material.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/widgets/texts.dart';

class RadioButton extends StatefulWidget {
  final List str;
  final Function callback;

  const RadioButton({
    @required this.str,
    @required this.callback,
  });

  @override
  _RadioButtonState createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  String group = "Somewhat";
  List values = [
    "Most Likely",
    "More Likely",
    "Somewhat",
    "Less Likely",
    "Never"
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) {
        return SizedBox(
          height: 38,
          child: ListTile(
            title: RadioButtonTextDark(
              txt: widget.str[index].toString(),
            ),
            leading: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: whiteColor,
              ),
              child: Radio(
                activeColor: blackColor,
                value: values[index],
                groupValue: group,
                onChanged: (value) {
                  setState(() {
                    group = value.toString();
                  });
                  widget.callback(value);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
