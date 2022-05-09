import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/custom_classes/navigations.dart';
import 'package:udhaarkaroapp/custom_classes/validation_helpers.dart';
import 'package:udhaarkaroapp/services/notification_services.dart';
import 'package:udhaarkaroapp/widgets/widgets.dart';


class CustomDialog {
  final CommonController _commonController = Get.find();

  void profileDialog(String url, BuildContext context) {
    showDialog(
      context: context,
      barrierColor: const Color(0xFF000000).withOpacity(0.8),
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 10),
          backgroundColor: Colors.transparent,
          child: InteractiveViewer(
            child: Container(
              height: displayHeight(context) * 0.6,
              width: displayWidth(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: darkBlueColor, width: 2),
                image: DecorationImage(
                  image: NetworkImage(url),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> selectLangDialog(BuildContext context,) async {
    final ValueNotifier<bool> langNotifier = ValueNotifier(false);
    final ValueNotifier<bool> themeNotifier = ValueNotifier(false);

    showDialog(
      barrierDismissible: false,
      context: context,
      barrierColor: const Color(0xFF000000).withOpacity(0.8),
      builder: (context) {
        return Obx((){
          return AlertDialog(
            backgroundColor: (_commonController.dark.value) ? blackColor : whiteColor,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),),
            content:  Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                H4Dark(txt: LanguageController().getText(selectLangTxt)),
                height5,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 15.0),
                      child: T18Dark(txt: "English",),
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: langNotifier,
                      builder: (_, lang,__){
                        return Switch(
                          onChanged: (stats){
                            _commonController.switchLang();
                            langNotifier.value = stats;
                          },
                          value: lang,
                          activeColor: lightBlueColor,
                          activeTrackColor: lightGreyColor,
                          inactiveThumbColor: lightOrangeColor,
                          inactiveTrackColor: lightGreyColor,
                        );
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 15.0, right: 8.0),
                      child: T18Dark(txt: " हिंदी",),
                    )
                  ],
                ),
                height30,
                H4Dark(txt: LanguageController().getText(selectThemeTxt)),
                height5,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 15.0, left: 10.0),
                      child: T18Dark(txt: "Light",),
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: themeNotifier,
                      builder: (_, theme, __){
                        return Switch(
                          onChanged: (stats){
                            _commonController.switchTheme();
                            themeNotifier.value = stats;
                          },
                          value: theme,
                          activeColor: whiteColor,
                          activeTrackColor: lightGreyColor,
                          inactiveThumbColor: Colors.black,
                          inactiveTrackColor: lightGreyColor,
                        );
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: T18Dark(txt: "Dark",),
                    )
                  ],
                ),
                height30,
                Button(
                  text: LanguageController().getText(continueBtnTxt),
                  height: 40,
                  color: darkBlueColor,
                  callback: () async {
                    await _commonController.setLang();
                    await _commonController.setTheme();
                    Navigate().toIntroScreen(context);
                  },
                ),
              ],
            ),
          );
        });
      },
    );
  }

  Future<void> reasonForDenyDialog(BuildContext context, String id, String amount, String name, String fcmToken, Function callback) async {

    String denialMsg = "";
    showDialog(
      barrierDismissible: false,
      context: context,
      barrierColor: const Color(0xFF000000).withOpacity(0.8),
      builder: (context) {
        return AlertDialog(
            backgroundColor: (_commonController.dark.value) ? blackColor : whiteColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),),
            content:  Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                T18Dark(txt: LanguageController().getText(reasonToSendTxt)),
                height10,
                height5,
                TextFormField(
                  style: TextStyle(
                    fontSize: 16,
                    color: (_commonController.dark.value)
                        ? whiteColor
                        : blackColor,),
                  decoration: inputDecor2.copyWith(
                    hintText: LanguageController().getText(writeSomethingTxt),
                    hintStyle: TextStyle(
                      color: (_commonController.dark.value)
                          ? whiteColor
                          : blackColor,),
                  ),
                  cursorColor: redColor,
                  validator: (val) {
                    return ValidationHelpers().onlyEngValidator(val);
                  },
                  onChanged: (val) => denialMsg = val,
                  minLines: 5,
                  maxLines: 7,
                ),
                height10,
                height5,
                Button(
                  text: LanguageController().getText(declineTxt),
                  height: 35,
                  width: 120,
                  color: darkBlueColor,
                  callback: () async {
                    NotificationService().sendNotify("Transaction Denied", " Your Transaction of Rs $amount has been denied by $name. The reason is $denialMsg",
                      fcmToken,
                    );
                    TransactionController()
                        .updateTransactionRead("rejected", id, denialMsg, "cancelled by Receiver", (){callback();});
                   Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
      },
    );
  }

  Future<void> signUpIfNotExistsDialog(BuildContext context, Function() callback) async {
    final TransactionController _txnController = Get.find();
    showDialog(
      barrierDismissible: false,
      context: context,
      barrierColor: const Color(0xFF000000).withOpacity(0.8),
      builder: (context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 10),
          backgroundColor: (_commonController.dark.value) ? blackColor : whiteColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),),
          content:  Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              T16Dark(txt: LanguageController().getText(userNotRegisteredTxt)),
              height10,
              height5,
              NameTextField(
                decoration: inputDecor2,
                label: LanguageController().getText(signupNameTxt),
                callback: (value) {
                  _txnController.txnModel.value.name = value.toString();
                },
              ),
              height10,
              height5,
              Button(
                text: LanguageController().getText(addTxt),
                height: 40,
                width: 180,
                color: darkBlueColor,
                callback: () async {
                 callback();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
