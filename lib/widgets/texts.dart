import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';

//H1_Dark
//H1_Light
//H2_Dark
//H2_Light
//H3_Dark
//H3_Light
//H4_Dark
//H4_Light

//T30_Dark
//T30_Light
//T28_Dark
//T28_Light
//T26_Dark
//T26_Light
//T24_Dark
//T24_Light
//T22_Dark
//T22_Light
//T20_Dark
//T20_Light
//T18_Dark
//T18_Light
//T16_Dark
//T16_Light
//T14_Dark
//T14_Light
//T12_Dark
//T12_Light

final CommonController _commonController = Get.find();

class H1Dark extends StatelessWidget {
  final String txt;

  const H1Dark({@required this.txt});

  @override
  Widget build(BuildContext context) {
    return Text(
        txt,
        style: (_commonController.dark.value) ? h1_Light : h1_Dark,
        textAlign: TextAlign.center,
    );
  }
}

class H1Light extends StatelessWidget {
  final String txt;

  const H1Light({@required this.txt});

  @override
  Widget build(BuildContext context) {
    return Text(
        txt,
        style: h1_Light,
        textAlign: TextAlign.center,
    );
  }
}

class H2Dark extends StatelessWidget {
  final String txt;

  const H2Dark({@required this.txt});

  @override
  Widget build(BuildContext context) {
    return Text(
        txt,
        style: (_commonController.dark.value) ? h2_Light : h2_Dark,
        textAlign: TextAlign.center,
    );
  }
}

class H2Light extends StatelessWidget {
  final String txt;

  const H2Light({@required this.txt});

  @override
  Widget build(BuildContext context) {
    return Text(
        txt,
        style: h2_Light,
        textAlign: TextAlign.center,
    );
  }
}

class H3Dark extends StatelessWidget {
  final String txt;

  const H3Dark({@required this.txt});

  @override
  Widget build(BuildContext context) {
    return Text(
        txt,
        style: (_commonController.dark.value) ? h3_Light : h3_Dark,
        textAlign: TextAlign.center,
    );
  }
}

class H3Light extends StatelessWidget {
  final String txt;

  const H3Light({@required this.txt});

  @override
  Widget build(BuildContext context) {
    return Text(
        txt,
        style: h3_Light,
        textAlign: TextAlign.center,
      );
  }
}

class H4Dark extends StatelessWidget {
  final String txt;

  const H4Dark({@required this.txt});

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: (_commonController.dark.value) ? h4_Light : h4_Dark,
      textAlign: TextAlign.center,
    );
  }
}

class H4Light extends StatelessWidget {
  final String txt;

  const H4Light({@required this.txt});

  @override
  Widget build(BuildContext context) {
    return Text(
        txt,
        style: h4_Light,
        textAlign: TextAlign.center,
    );
  }
}

class T30Dark extends StatelessWidget {
  final String txt;

  const T30Dark({@required this.txt});

  @override
  Widget build(BuildContext context) {
    return Text(
        txt,
        style: (_commonController.dark.value) ? t30_Light : t30_Dark,
        textAlign: TextAlign.center,
    );
  }
}

class T30Light extends StatelessWidget {
  final String txt;

  const T30Light({@required this.txt});

  @override
  Widget build(BuildContext context) {
    return Text(
        txt,
        style: t30_Light,
        textAlign: TextAlign.center,
    );
  }
}

class T28Dark extends StatelessWidget {
  final String txt;

  const T28Dark({@required this.txt});

  @override
  Widget build(BuildContext context) {
    return Text(
        txt,
        style: (_commonController.dark.value) ? t28_Light : t28_Dark,
        textAlign: TextAlign.center,
    );
  }
}

class T28Light extends StatelessWidget {
  final String txt;

  const T28Light({@required this.txt});

  @override
  Widget build(BuildContext context) {
    return Text(
        txt,
        style: t28_Light,
        textAlign: TextAlign.center,
    );
  }
}

class T26Dark extends StatelessWidget {
  final String txt;

  const T26Dark({@required this.txt});

  @override
  Widget build(BuildContext context) {
    return Text(
        txt,
        style: (_commonController.dark.value) ? t28_Light : t28_Dark,
        textAlign: TextAlign.center,
      );
  }
}

class T26Light extends StatelessWidget {
  final String txt;

  const T26Light({@required this.txt});

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: t26_Light,
      textAlign: TextAlign.center,
    );
  }
}

class T24Dark extends StatelessWidget {
  final String txt;

  const T24Dark({@required this.txt});

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: (_commonController.dark.value) ? t24_Light : t24_Dark,
      textAlign: TextAlign.center,
    );
  }
}

class T24Light extends StatelessWidget {
  final String txt;

  const T24Light({@required this.txt});

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: t24_Light,
      textAlign: TextAlign.center,
    );
  }
}

class T22Dark extends StatelessWidget {
  final String txt;

  const T22Dark({@required this.txt});

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: (_commonController.dark.value) ? t22_Light : t22_Dark,
      textAlign: TextAlign.center,
    );
  }
}

class T22Light extends StatelessWidget {
  final String txt;

  const T22Light({@required this.txt});

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: t22_Light,
      textAlign: TextAlign.center,
    );
  }
}

class T20Dark extends StatelessWidget {
  final String txt;

  const T20Dark({@required this.txt});

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: (_commonController.dark.value) ? t20_Light : t20_Dark,
      textAlign: TextAlign.center,
    );
  }
}

class T20Light extends StatelessWidget {
  final String txt;

  const T20Light({@required this.txt});

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: t20_Light,
      textAlign: TextAlign.center,
    );
  }
}

class T18Dark extends StatelessWidget {
  final String txt;

  const T18Dark({@required this.txt});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Text(
        txt,
        style: (_commonController.dark.value) ? t18_Light : t18_Dark,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class T18Light extends StatelessWidget {
  final String txt;

  const T18Light({@required this.txt});

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: t18_Light,
      textAlign: TextAlign.center,
    );
  }
}

class T16Dark extends StatelessWidget {
  final String txt;

  const T16Dark({@required this.txt});

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: (_commonController.dark.value) ? t16_Light : t16_Dark,
      textAlign: TextAlign.center,
    );
  }
}

class T16Light extends StatelessWidget {
  final String txt;

  const T16Light({@required this.txt});

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: t16_Light,
      textAlign: TextAlign.center,
    );
  }
}

class T14Dark extends StatelessWidget {
  final String txt;

  const T14Dark({@required this.txt});

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: (_commonController.dark.value) ? t14_Light : t14_Dark,
      textAlign: TextAlign.center,
    );
  }
}

class T14Light extends StatelessWidget {
  final String txt;

  const T14Light({@required this.txt});

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: t14_Light,
      textAlign: TextAlign.center,
    );
  }
}

class T12Dark extends StatelessWidget {
  final String txt;

  const T12Dark({@required this.txt});

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: (_commonController.dark.value) ? t12_Light : t12_Dark,
      textAlign: TextAlign.center,
    );
  }
}

class T12Light extends StatelessWidget {
  final String txt;

  const T12Light({@required this.txt});

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: t12_Light,
      textAlign: TextAlign.center,
    );
  }
}

class RadioButtonTextDark extends StatelessWidget {
  final String txt;

  const RadioButtonTextDark({@required this.txt});

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: (_commonController.dark.value)
          ? radioButtonTextStyle_Light
          : radioButtonTextStyle_Dark,
    );
  }
}

class RadioButtonTextLight extends StatelessWidget {
  final String txt;

  const RadioButtonTextLight({@required this.txt});

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: radioButtonTextStyle_Light,
    );
  }
}

//Custom Texts
class HomeHeaderText extends StatelessWidget {
  final String txt;

  const HomeHeaderText({@required this.txt});

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: TextStyle(
        fontSize: 38,
        fontFamily: "Lobster",
        color: (_commonController.dark.value)
            ? whiteColor
            : blackColor,
        fontWeight: FontWeight.bold,
        fontStyle: (_commonController.hindi.value)
            ? FontStyle.italic
            : FontStyle.normal,
      ),
    );
  }
}

class AmountDetailsText extends StatelessWidget {
  final String txt;

  const AmountDetailsText({@required this.txt});

  @override
  Widget build(BuildContext context) {
    return  Text(
      txt,
      style: amountDetailsTextStyle,
    );
  }
}

class AccountDetailsText extends StatelessWidget {
  final String txt;

  const AccountDetailsText({@required this.txt});

  @override
  Widget build(BuildContext context) {
    return  Text(
      txt,
      style: accountDetailsTextStyle,
    );
  }
}

class ShareText extends StatelessWidget {
  final String txt;

  const ShareText({@required this.txt});

  @override
  Widget build(BuildContext context) {
    return  Text(
      txt,
      style: shareTextStyle,
    );
  }
}

class LogoutText extends StatelessWidget {
  final String txt;

  const LogoutText({@required this.txt});

  @override
  Widget build(BuildContext context) {
    return  Text(
      txt,
      style: logoutTextStyle,
    );
  }
}

class SettingsLangText extends StatelessWidget {
  final String txt;

  const SettingsLangText({@required this.txt});

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: t16_Dark,
    );
  }
}

class Splash1Text extends StatelessWidget {
  final String txt;

  const Splash1Text({@required this.txt});

  @override
  Widget build(BuildContext context) {
    return  Text(
      txt,
      style: splash1TextStyle,
    );
  }
}

class Splash2Text extends StatelessWidget {
  final String txt;

  const Splash2Text({@required this.txt});

  @override
  Widget build(BuildContext context) {
    return  Text(
      txt,
      style: splash2TextStyle,
    );
  }
}
