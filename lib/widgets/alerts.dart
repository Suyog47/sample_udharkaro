import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/widgets/texts.dart';

class Alert {
  void successFlutterToast(String value) {
    Fluttertoast.showToast(
      msg: value,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: greenColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void failFlutterToast(String value) {
    Fluttertoast.showToast(
      msg: value,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: redColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void successSweetAlert(
      String sTitle, BuildContext context, Function() callback,) {
    SweetAlert.show(
      context,
      title: LanguageController().getText(successTxt),
      subtitle: sTitle,
      style: SweetAlertStyle.success,
      confirmButtonColor: darkBlueColor,
      onPress: (bool isConfirm) {
        if (isConfirm) {
          callback();
        }
        return false;
      },
      confirmButtonText: LanguageController().getText(okTxt),
    );
  }

  Future<void> failSweetAlert(
      String sTitle, BuildContext context, Function() callback,) async {
    SweetAlert.show(
      context,
      title: LanguageController().getText(failedTxt),
      subtitle: sTitle,
      style: SweetAlertStyle.error,
      confirmButtonColor: darkBlueColor,
      onPress: (bool isConfirm) {
        if (isConfirm) {
          callback();
        }
        return false;
      },
      confirmButtonText: LanguageController().getText(okTxt),
    );
  }

  void warningSweetAlert(
      String sTitle, BuildContext context, Function() callback,) {
    SweetAlert.show(
      context,
      title: LanguageController().getText(warningTxt),
      subtitle: sTitle,
      style: SweetAlertStyle.confirm,
      confirmButtonColor: darkBlueColor,
      onPress: (bool isConfirm) {
        if (isConfirm) {
          callback();
        }
        return false;
      },
      confirmButtonText: LanguageController().getText(okTxt),
    );
  }

  void snackBar(String msg, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: T16Light(txt: msg),
      ),
    );
  }
}
