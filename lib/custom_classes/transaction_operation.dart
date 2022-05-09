import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/custom_classes/navigations.dart';
import 'package:udhaarkaroapp/widgets/alerts.dart';
import 'package:udhaarkaroapp/widgets/dialogs.dart';

class TxnOperation {
  final TransactionController _txnController = Get.find();
  QRViewController controller;

  Future operation(BuildContext context, int type, bool mounted) async {

    await _txnController.getAnotherUserData(type);

    if (_txnController.response.value == "no data") {
      if (!mounted) return;
      CustomDialog().signUpIfNotExistsDialog(context, () async {
        Navigator.pop(context);
        await _txnController.addAnotherUserData();
        if (_txnController.response.value != "Data not Inserted" &&
            _txnController.response.value != "error") {
          final res = jsonDecode(_txnController.response.value);
          (type == 1)
              ? _txnController.txnModel.value.fromId = res["id"].toString()
              : _txnController.txnModel.value.toId = res["id"].toString();

          if (!mounted) return;
          Navigate().toEnterAmount(context, {"type": type});
        }
        else {
          if (!mounted) return;
          Alert().snackBar(LanguageController().getText(errorTxt), context);
        }
      });
    }
    else if (_txnController.response.value == "error") {
      if (!mounted) return;
      Alert().snackBar(LanguageController().getText(errorTxt), context);

      if (controller != null) controller.resumeCamera();
    }
    else if (_txnController.response.value == "limit exceeded") {
      if (!mounted) return;
      Alert().failSweetAlert(
        LanguageController().getText(transLimitExceedTxt),
        context,
        () => {Navigator.pop(context)},
      );
    }
    else {
      if (!mounted) return;
      Navigate().toEnterAmount(context, {"type": type});
    }

  }
}
