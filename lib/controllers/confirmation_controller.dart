import 'dart:async';
import 'package:get/get.dart';
import 'package:udhaarkaroapp/api_calls/confirmation.dart';
import 'package:udhaarkaroapp/models/confirmation_model.dart';

class ConfirmationController extends GetxController {
  RxList<ConfirmationModel> confirmationList =
      List<ConfirmationModel>.empty(growable: true).obs;
  RxInt load = 0.obs;
  RxString response = "".obs;
  RxString status = "".obs;
  String reason;

  // Future getConfirmationStatus(BuildContext context, int type) async {
  //   try {
  //     await ConfirmationApiCall()
  //         .getConfirmationStats(_txnController.txnModel.value.transactionId)
  //         .then((value) {
  //       status.value = value["status"].toString();
  //       reason = value["reason"].toString();
  //     });
  //   } finally {
  //     if (status.value == "pending") {
  //       getConfirmationStatus(context, type);
  //     } else if (status.value == "success") {
  //       takenTxnController.getTakenTransactionData();
  //       givenTxnController.getGivenTransactionData();
  //       Timer(const Duration(seconds: 3), () {
  //         if (type == 1) {
  //           Navigate().toTakenAmount(context, true, {"heroTag": ""});
  //         } else {
  //           Navigate().toGivenAmount(context, true, {"heroTag": ""});
  //         }
  //       });
  //     } else {
  //       if (reason == "denied by receiver") {
  //         Alert().failSweetAlert(
  //             LanguageController().getText(transCancelledTxt), context, () {
  //           Navigator.pop(context);
  //           Navigator.pop(context);
  //         });
  //       }
  //     }
  //   }
  // }

  Future updateTransactionStatus(
      String status, String reason, String id,) async {
    try {
      await ConfirmationApiCall().updateTransactionStats(status, reason, id);
    } finally {}
  }

  // Future getConfirmationList() async {
  //   try {
  //     await ConfirmationApiCall()
  //         .getConfirmationList(_userController.userModel.value.id)
  //         .then((value) {
  //       if (value != "" && value != "error") {
  //         confirmationList.assignAll(value as Iterable<ConfirmationModel>);
  //       } else {
  //         confirmationList.clear();
  //         response.value = value.toString();
  //       }
  //     });
  //   } finally {
  //     load.value = 0;
  //     if (_userController.login.value == true) {
  //       getConfirmationList();
  //     }
  //   }
  // }
}
