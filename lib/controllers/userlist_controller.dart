import 'dart:async';
import 'package:get/get.dart';
import 'package:udhaarkaroapp/api_calls/user.dart';
import 'package:udhaarkaroapp/models/userlist_model.dart';


class UserListController extends GetxController {
  RxList<UserListModel> userList =
      List<UserListModel>.empty(growable: true).obs;
  List<UserListModel> userListTotal = List<UserListModel>.empty(growable: true);
  RxInt load = 1.obs;
  RxInt updateLoad = 0.obs;
  RxString response = "".obs;

  Future getUserData(String id) async {
    try {
      await UserApiCalls().getUsersList(id).then((value) {
        if (value != "error" && value != "") {
          userList.assignAll(value as Iterable<UserListModel>);
          userListTotal.assignAll(value as Iterable<UserListModel>);
        } else {
          response.value = value.toString();
        }
      });
    } finally {
      load.value = 0;
      updateLoad.value = 0;
    }
  }

  void getSearchedUser(String data) {
    userList.assignAll(userListTotal);
    final List toRemove = [];
    for (final userDetail in userList) {
      if (!userDetail.name.toLowerCase().contains(data.toLowerCase())) {
        toRemove.add(userDetail);
      }
    }

    userList.removeWhere((e) => toRemove.contains(e));
  }

  Future insertUserLimit(
      String fromId, String toId, String amount, String action,) async {
    updateLoad.value = 1;
    try {
      await UserApiCalls()
          .setUsersLimit(
              fromId, toId, amount, DateTime.now().toString(), action,)
          .then((value) {
        response.value = value.toString();
      });
    } finally {
      updateLoad.value = 0;
    }
  }
}
