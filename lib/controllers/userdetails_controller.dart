import 'package:get/get.dart';
import 'package:udhaarkaroapp/api_calls/transaction.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/models/transaction_model.dart';

class UserDetailsController extends GetxController {
  final UserController _userController = Get.find();
  RxList<TransactionModel> userTxn =
      List<TransactionModel>.empty(growable: true).obs;
  RxList<TransactionModel> sortedUserTxn =
      List<TransactionModel>.empty(growable: true).obs;
  RxString yourId = "".obs;
  RxInt load = 1.obs;
  RxString response = "".obs;

  Future getUserTxn({
    String cType,
    String date,
  }) async {
    load = 1.obs;
    try {
      await TransactionApiCall()
          .getUserTransactions(_userController.userModel.value.id, yourId.value)
          .then((value) async {
        if (value != "error" && value != "") {
          userTxn.assignAll(value as Iterable<TransactionModel>);
        } else if (value == "") {
          userTxn.assignAll([]);
        } else {
          response.value = value.toString();
        }
      });
    } finally {
      getSortedList(
        cType ?? "All",
        date ?? DateTime.now().subtract(const Duration(hours: 24)).toString(),
      );
    }
  }

  void getSortedList(String cType, String date) {
    sortedUserTxn.clear();
    load.value = 1;
    try {
      if (cType == "All") {
        for (final element in userTxn) {
          if (DateTime.parse(element.date).isAfter(
            DateTime.parse(date),
          )) {
            sortedUserTxn.add(element);
          }
        }
      } else if (cType == "Sent") {
        for (final element in userTxn) {
          if (element.fromId == _userController.userModel.value.id) {
            if (DateTime.parse(element.date).isAfter(
              DateTime.parse(date),
            )) {
              sortedUserTxn.add(element);
            }
          }
        }
      } else {
        for (final element in userTxn) {
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
