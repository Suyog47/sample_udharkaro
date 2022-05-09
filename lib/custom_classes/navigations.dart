import 'package:flutter/material.dart';

class Navigate {
  void toIntroScreen(BuildContext context, [Map data]) {
    Navigator.pushNamedAndRemoveUntil(
      context, "/intro", (Route<dynamic> route) => false,
      arguments: data,);
  }

  void toSplash(BuildContext context, [Map data]) {
    Navigator.pushNamedAndRemoveUntil(
      context, "/splash", (Route<dynamic> route) => false,
      arguments: data,);
  }

  void toSignUp(BuildContext context, [Map data]) {
    Navigator.pushReplacementNamed(context, "/signup", arguments: data);
  }

  void toSignUp2(BuildContext context, [Map data]) {
    Navigator.pushNamed(context, "/signup2", arguments: data);
  }

  void toLogin(BuildContext context, [Map data]) {
    Navigator.pushNamedAndRemoveUntil(
        context, "/login", (Route<dynamic> route) => false,
        arguments: data,);
  }

  void toForgotPassword(BuildContext context, [Map data]) {
    Navigator.pushNamed(context, "/forgotpassword", arguments: data);
  }

  void toNewPassword(BuildContext context, [Map data]) {
    Navigator.pushReplacementNamed(context, "/newpassword", arguments: data);
  }

  void toVerification(BuildContext context, [Map data]) {
    Navigator.pushNamed(context, "/verification", arguments: data);
  }

  void toHome(BuildContext context, [Map data]) {
    Navigator.pushReplacementNamed(context, "/home", arguments: data);
  }

  void toReports(BuildContext context, [Map data]) {
    Navigator.pushNamed(context, "/reports", arguments: data);
  }

  void toUserDetails(BuildContext context, [Map data]) {
    Navigator.pushNamed(context, "/userdetails", arguments: data);
  }

  void toMainScreen(BuildContext context, [Map data]) {
    Navigator.pushNamedAndRemoveUntil(
        context, "/mainscreen", (Route<dynamic> route) => false,
        arguments: data,);
  }

  void toQRScanner(BuildContext context, [Map data]) {
    Navigator.pushNamed(context, "/qrscanner", arguments: data);
  }

  void toEnterAmount(BuildContext context, [Map data]) {
    Navigator.pushNamed(context, "/enteramount", arguments: data);
  }

  void toTakeAmountConfirmation(BuildContext context, [Map data]) {
    Navigator.pushNamed(context, "/takeamountconfirmation",
        arguments: data,);
  }

  void toGiveAmountConfirmation(BuildContext context, [Map data]) {
    Navigator.pushNamed(context, "/giveamountconfirmation",
        arguments: data,);
  }

  void toTakenAmount(BuildContext context, [Map data]) {
      Navigator.pushNamed(
        context,
        "/takenamountdetails",
        arguments: data,
      );
  }

  void toGivenAmount(BuildContext context, [Map data]) {
      Navigator.pushNamed(
        context,
        "/givenamountdetails",
        arguments: data,
      );
  }

  void toQRCode(BuildContext context, [Map data]) {
    Navigator.pushNamed(context, "/qr", arguments: data);
  }

  void toAccountDetails(BuildContext context, [Map data]) {
    Navigator.pushNamed(context, "/accountdetails", arguments: data);
  }

  void toEditProfile(BuildContext context, [Map data]) {
    Navigator.pushNamed(context, "/editprofile", arguments: data);
  }

  void toPasswordUpdation(BuildContext context, [Map data]) {
    Navigator.pushNamed(context, "/passwordupdate", arguments: data);
  }

  void toFeedback(BuildContext context, [Map data]) {
    Navigator.pushNamed(context, "/feedbackform", arguments: data);
  }

  void toFeedback2(BuildContext context, [Map data]) {
    Navigator.pushNamed(context, "/feedbackform2", arguments: data);
  }

  void toPrivacyPolicy(BuildContext context, [Map data]) {
    Navigator.pushNamed(context, "/privacypolicy", arguments: data);
  }

  void toAboutUs(BuildContext context, [Map data]) {
    Navigator.pushNamed(context, "/aboutus", arguments: data);
  }

  void toSettings(BuildContext context, [Map data]) {
    Navigator.pushNamed(context, "/settings", arguments: data);
  }

  void toUserList(BuildContext context, [Map data]) {
    Navigator.pushNamed(context, "/userlist", arguments: data);
  }

  void toUserTransaction(BuildContext context, [Map data]) {
    Navigator.pushNamed(context, "/usertransaction", arguments: data);
  }

  void toReportList(BuildContext context, [Map data]) {
    Navigator.pushNamed(context, "/reportlist", arguments: data);
  }
}
