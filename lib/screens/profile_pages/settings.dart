import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/custom_classes/navigations.dart';
import 'package:udhaarkaroapp/widgets/widgets.dart';


class Settings extends StatefulWidget {

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final CommonController _commonController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:
        (!_commonController.dark.value) ? whiteColor : blackColor,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NormalHeader(text: LanguageController().getText(settingsTxt)),
              height60,
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      T18Dark(txt: LanguageController().getText(langSettingTxt)),
                      height10,
                      height5,
                      Container(
                        height: displayHeight(context) * 0.07,
                        width: displayWidth(context) * 0.9,
                        decoration: BoxDecoration(
                          color: greyColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                if(_commonController.hindi.value) {
                                  if (!mounted) return;
                                  Alert().warningSweetAlert(
                                      LanguageController().getText(appRestartTxt),
                                      context, () async {
                                    _commonController.switchLang();
                                    await _commonController.setLang();
                                    if (!mounted) return;
                                    Navigate().toSplash(context);
                                  });
                                }
                              },
                              child: Obx(() => Container(
                                height: displayHeight(context) * 0.06,
                                width: displayWidth(context) * 0.44,
                                decoration: BoxDecoration(
                                  color: (_commonController.hindi.value) ? Colors.transparent : whiteColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Center(
                                  child: SettingsLangText(txt: "English"),
                                  //Text("English", style: TextStyle(fontSize: 16, color: blackColor),),),
                              ),
                            ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                if(!_commonController.hindi.value) {
                                  if (!mounted) return;
                                  Alert().warningSweetAlert(
                                      LanguageController().getText(appRestartTxt),
                                      context, () async {
                                    _commonController.switchLang();
                                    await _commonController.setLang();
                                    if (!mounted) return;
                                    Navigate().toSplash(context);
                                  });
                                }
                              },
                              child: Obx(() => Container(
                                height: displayHeight(context) * 0.06,
                                width: displayWidth(context) * 0.44,
                                decoration: BoxDecoration(
                                  color: (_commonController.hindi.value) ? whiteColor : Colors.transparent,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Center(
                                    child: SettingsLangText(txt: "हिंदी"),
                                ),
                              ),),
                            )
                          ],
                        ),
                      )
                    ],
                ),
              ),
            ],
          ),),
    );
  }
}
