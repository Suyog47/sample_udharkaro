import 'dart:convert';
import 'package:get/get.dart';
import 'package:udhaarkaroapp/api_calls/user.dart';
import 'package:udhaarkaroapp/models/user_model.dart';
import 'package:udhaarkaroapp/services/notification_services.dart';

class UserController extends GetxController {
  Rx<UserModel> userModel = UserModel().obs;
  RxInt load = 0.obs;
  RxString response = "".obs;
  RxBool login = false.obs;

  Future logIn() async {
    try {
      load.value = 1;
      userModel.value.lastLoginAt = DateTime.now().toString();
      await UserApiCalls().logIn(userModel.value).then((value) {
        response.value = value.toString();
        if (response.value != "no data" && response.value != "error") {
          final res = jsonDecode(response.value);
          userModel.value.id = res["id"].toString();
          userModel.value.pic = res["pic"].toString();
          userModel.value.name = res["name"].toString();
          userModel.value.email = res["email"].toString();
          userModel.value.accountType = res["account_type"].toString();
          userModel.value.businessMainCategory =
              res["businessMainCategory"].toString();
          userModel.value.businessSubCategory =
              res["businessSubCategory"].toString();
          login.value = true;
        }
      });
    } finally {
      load.value = 0;
    }
  }

  Future signUp() async {
    try {
      load.value = 1;
      userModel.value.accountType = "Personal Account";
      userModel.value.fcmToken = await NotificationService().getFcmToken();
      userModel.value.createdAt = DateTime.now().toString();
      userModel.value.updatedAt = DateTime.now().toString();
      userModel.value.lastLoginAt = DateTime.now().toString();
      userModel.value.status = "success";

      await UserApiCalls().addUser(userModel.value).then((value) {
        response.value = value.toString();
          if (response.value != "exists" && response.value != "error") {
            final res = jsonDecode(response.value);
              userModel.value.id = res["id"].toString();
              userModel.value.pic = res["pic"];
              login.value = true;
          }
          else {
            response.value = value.toString();
          }
      });
    } finally {
      load.value = 0;
    }
  }

  Future updateUser(String name, String num, String email, String category, String main,
      String sub,) async {
    try {
      load.value = 1;
      userModel.value.updatedAt = DateTime.now().toString();
      await UserApiCalls()
          .update(name, num, email, category, main, sub, userModel.value.updatedAt)
          .then((value) {
        response.value = value.toString();
      });
    } finally {
      load.value = 0;
    }
  }

  Future updateUserImage(String pic) async {
    try {
      await UserApiCalls()
          .updateImage(pic, userModel.value.mobileNumber)
          .then((value) {
        response.value = value.toString();
      });
    } finally {}
  }

  Future updateUserPass(String pass) async {
    load.value = 1;
    try {
      await UserApiCalls()
          .updatePass(pass, userModel.value.mobileNumber)
          .then((value) {
        response.value = value.toString();
      });
    } finally {
      load.value = 0;
    }
  }

  Future updateFcmToken(String token) async {
    try {
      await UserApiCalls()
          .updateFcm(token, userModel.value.mobileNumber)
          .then((value) {
        response.value = value.toString();
      });
    } finally {}
  }

  Future checkUser() async {
    load.value = 1;
    try {
      await UserApiCalls().checkUserData(userModel.value).then((value) {
        response.value = value.toString();
      });
    } finally {
      load.value = 0;
    }
  }

  void clearAllData(){
    userModel.value.id = "";
    userModel.value.pic = "";
    userModel.value.name = "";
    userModel.value.email = "";
    userModel.value.mobileNumber = "";
    userModel.value.password = "";
    userModel.value.accountType = "";
    userModel.value.businessMainCategory = "";
    userModel.value.businessSubCategory = "";
    userModel.value.fcmToken = "";
  }
}
