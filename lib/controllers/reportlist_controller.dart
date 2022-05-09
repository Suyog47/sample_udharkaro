import 'package:get/get.dart';
import 'package:udhaarkaroapp/api_calls/user.dart';
import 'package:udhaarkaroapp/controllers/userlist_controller.dart';
import 'package:udhaarkaroapp/models/reportlist_model.dart';

class ReportListController extends GetxController {
  final reportedList = List<ReportListModel>.empty(growable: true).obs;
  final reportedListTotal = List<ReportListModel>.empty(growable: true);

  final reports = List<ReportListModel>.empty(growable: true).obs;
  RxInt load = 1.obs;
  RxInt updateLoad = 0.obs;
  RxString response = "".obs;

  //get list of all whom user have reported
  Future getReportList(String id) async {
    try {
      await UserApiCalls().getUserReportList(id).then((value) {
        if (value != "error") {
          reportedList
              .assignAll(value == "" ? [] : value as Iterable<ReportListModel>);
          reportedListTotal
              .assignAll(value == "" ? [] : value as Iterable<ReportListModel>);
        } else {
          response.value = value.toString();
        }
      });
    } finally {
      load.value = 0;
    }
  }

  //get list of all who have reported the user
  Future fetchReportList(String id) async {
    try {
      await UserApiCalls().fetchReportList(id).then((value) {
        if (value != "error") {
          reports
              .assignAll(value == "" ? [] : value as Iterable<ReportListModel>);
        } else {
          response.value = value.toString();
        }
      });
    } finally {
      load.value = 0;
    }
  }

  Future addReport(String fromId, String toId) async {
    final UserListController _userListController = Get.find();

    try {
      await UserApiCalls()
          .addReport(fromId, toId, DateTime.now().toString())
          .then((value) async {
        response.value = value.toString();
        _userListController.updateLoad.value = 1;
        await _userListController.getUserData(fromId);
      });
    } finally {
      _userListController.updateLoad.value = 0;
    }
  }

  void getSearchedUser(String data) {
    reportedList.assignAll(reportedListTotal);
    final List toRemove = [];
    for (final userDetail in reportedList) {
      if (!userDetail.name.toLowerCase().contains(data.toLowerCase())) {
        toRemove.add(userDetail);
      }
    }

    reportedList.removeWhere((e) => toRemove.contains(e));
  }

  Future deleteReport(String fromId, String toId) async {
    try {
      updateLoad.value = 1;
      await UserApiCalls().deleteReport(fromId, toId).then((value) {
        response.value = value.toString();
        if (value != "error" && value != "not deleted") {
          getReportList(fromId);
        }
      });
    } finally {
      updateLoad.value = 0;
    }
  }
}
