import 'package:get/get.dart';
import 'package:udhaarkaroapp/api_calls/transaction.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/models/transaction_model.dart';

class GetGivenTransactionController extends GetxController {
  final UserController _userController = Get.find();
  List<TransactionModel> txn = List<TransactionModel>.empty(growable: true).obs;
  List<TransactionModel> txnTotal =
      List<TransactionModel>.empty(growable: true);
  RxInt total = 0.obs;
  int tl = 0;
  RxInt load = 1.obs;
  RxString response = "".obs;

  Future getGivenTransactionData() async {
    try {
      await TransactionApiCall()
          .getGivenTxn(_userController.userModel.value.id)
          .then((value) async {
        if (value != "error" && value != "") {
          txn.assignAll(value as Iterable<TransactionModel>);
          txnTotal.assignAll(txn);

          for (final element in txn) {
            tl += int.parse(element.amount);
          }

          if (total.value != tl) {
            total.value = tl;
          }
          tl = 0;
        } else {
          response.value = value.toString();
        }
      });
    } finally {
      load.value = 0;
      if (_userController.login.value == true && txn.isNotEmpty) {
      } else {
        total.value = 0;
        txn.clear();
      }
    }
  }

  void getSearchedUser(String data) {
    txn.assignAll(txnTotal);
    final List toRemove = [];
    for (final userDetail in txn) {
      if (!userDetail.name.toLowerCase().contains(data.toLowerCase())) {
        toRemove.add(userDetail);
      }
    }

    txn.removeWhere((e) => toRemove.contains(e));
  }
}
