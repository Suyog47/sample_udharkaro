import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/widgets/widgets.dart';


class ShowBottomSheet{
  final CommonController _basicController = Get.find();
  final UserController _userController = Get.find();


  void getSharingBottomSheet(BuildContext context, String name, String number, String amount) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          color: (_basicController.dark.value) ? blackColor : whiteColor,
          child: ShareBottomSheet(
            name: name,
            number: number,
            amount: amount,
          ),
        );
      },
    );
  }

  void getUserBottomSheet(BuildContext context, String name, String number, String limit, String id,
      String status, String token, Function callback,) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          color: (_basicController.dark.value) ? blackColor : whiteColor,
          child: UserListBottomSheet(
            name: name,
            number: number,
            amount: limit,
            fromId: _userController.userModel.value.id,
            toId: id,
            status: status,
            token: token,
            callback: callback,
          ),
        );
      },
    );
  }
}
