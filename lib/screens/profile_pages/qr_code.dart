import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/custom_classes/notification_click_check.dart';
import 'package:udhaarkaroapp/widgets/widgets.dart';


class QRCode extends StatefulWidget {
  @override
  _QRCodeState createState() => _QRCodeState();
}

class _QRCodeState extends State<QRCode> {
  final UserController _userController = Get.find();
  final CommonController _commonController = Get.find();

  @override
  void initState() {
    super.initState();
    NotificationCheck().check(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            (!_commonController.dark.value) ? whiteColor : blackColor,
        body: Column(
          children: [
            NormalHeader(text: LanguageController().getText(qrCodeHeaderTxt),),
            Expanded(
              child: Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: redColor, width: 3),
                  ),
                  child: QrImage(
                    data: _userController.userModel.value.mobileNumber,
                    size: 250.0,
                    foregroundColor: blackColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
