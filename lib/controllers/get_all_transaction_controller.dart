import 'dart:async';
import 'package:get/get.dart';
import 'package:udhaarkaroapp/api_calls/transaction.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/models/transaction_model.dart';

class GetAllTransactionController extends GetxController {
  final UserController _userController = Get.find();
  List<TransactionModel> txn = List<TransactionModel>.empty(growable: true).obs;
  List<TransactionModel> sortedUserTxn =
      List<TransactionModel>.empty(growable: true).obs;
  RxInt load = 1.obs;
  RxString response = "".obs;

  Future<dynamic> allTransactionData(String id,
      {String cType, String date,}) async {
    load = 1.obs;
    try {
      await TransactionApiCall().getAllTxn(id).then((value) {
        if (value != "error" && value != "") {
          txn.assignAll(value as Iterable<TransactionModel>);
        } else {
          response.value = value.toString();
        }
      });
    } finally {
      getSortedList(
          cType ?? "All",
          date ??
              DateTime.now().subtract(const Duration(hours: 24)).toString(),);
    }
  }

  void getSortedList(String cType, String date) {
    sortedUserTxn.clear();
    try {
      if (cType == "All") {
        for (final element in txn) {
          if (DateTime.parse(element.date).isAfter(
            DateTime.parse(date),
          )) {
            sortedUserTxn.add(element);
          }
        }
      } else if (cType == "Sent") {
        for (final element in txn) {
          if (element.fromId == _userController.userModel.value.id) {
            if (DateTime.parse(element.date).isAfter(
              DateTime.parse(date),
            )) {
              sortedUserTxn.add(element);
            }
          }
        }
      } else {
        for (final element in txn) {
          if (element.toId == _userController.userModel.value.id &&
              DateTime.parse(element.date).isAfter(
                DateTime.parse(date),
              )) {
            sortedUserTxn.add(element);
          }
        }
      }
    } finally {
      load.value = 0;
    }
  }
}
