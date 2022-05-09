import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:get/get.dart';
import 'package:udhaarkaroapp/api_calls/transaction.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/models/transaction_model.dart';


class TransactionController extends GetxController {
  final UserController _userController = Get.find();

  Rx<TransactionModel> txnModel = TransactionModel().obs;
  RxInt load = 0.obs;
  RxString response = "".obs;
  RxString status = "".obs;
  Random random = Random();

  Future addTransaction(int type) async {
    try {
      txnModel.value.transactionId =
          (random.nextInt(99999999) + 100000).toString();
      txnModel.value.date = DateTime.now().toString();

      if (type == 1) {
        txnModel.value.reason = "accepted";
        txnModel.value.transRead = "true";
        txnModel.value.toId = _userController.userModel.value.id;
      } else {
        txnModel.value.transRead = "false";
        txnModel.value.fromId = _userController.userModel.value.id;
      }
      txnModel.value.status = "success";
      txnModel.value.operatedBy = _userController.userModel.value.id;
      await TransactionApiCall().addTxn(txnModel.value).then((value) {
        response.value = value.toString();
      });
    } finally {
      final GetTakenTransactionController _takenTxnController = Get.find();
      final GetGivenTransactionController _givenTxnController = Get.find();

      _takenTxnController.getTakenTransactionData();
      _givenTxnController.getGivenTransactionData();
    }
  }

  Future addAnotherUserData() async {
    try {
      load.value = 1;
      await TransactionApiCall().addUser({
        "name": txnModel.value.name,
        "phone": txnModel.value.number,
        "created": DateTime.now().toString(),
        "updated": DateTime.now().toString()
      }).then((value) {
        response.value = value.toString();
      });
    } finally {
      load.value = 0;
    }
  }

  Future getAnotherUserData(int type) async {
    load.value = 1;
    try {
      dynamic value;
      (type == 1)
          ? value = await TransactionApiCall().checkUserWithLimit(
              _userController.userModel.value.id,
              txnModel.value.number,
            )
          : value = await TransactionApiCall().checkUserNumber(
              txnModel.value.number,
            );

      response.value = value.toString();
      if (response.value != "no data" &&
          response.value != "limit exceeded" &&
          response.value != "error") {
        final res = jsonDecode(response.value);
        (type == 1)
            ? txnModel.value.fromId = res["id"].toString()
            : txnModel.value.toId = res["id"].toString();
        txnModel.value.name = res["name"].toString();
        txnModel.value.pic = res["pic"].toString();
        txnModel.value.limit = res["limit_value"].toString() ?? '0';
        txnModel.value.fcmToken = res["fcm_token"].toString() ?? '';
      }
    } finally {
      load.value = 0;
    }
  }

  Future updateTransactionRead(
    String status,
    String id,
    String msg,
    String reason,
      Function callback,
  ) async {
    try {
      await TransactionApiCall()
          .updateTransactionRead(status, id, reason, msg)
          .then((value) {
        if (value != "error") {
          response.value = "success";
        } else {
          response.value = "failed";
        }
      });
    } finally {
      callback();
    }
  }
}
