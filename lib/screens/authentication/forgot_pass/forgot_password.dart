import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/custom_classes/navigations.dart';
import 'package:udhaarkaroapp/services/sms_services.dart';
import 'package:udhaarkaroapp/widgets/widgets.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  Random random = Random();

  final UserController _userController = Get.find();
  final CommonController _commonController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (!_commonController.dark.value) ? whiteColor : blackColor,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                height: displayHeight(context) * 0.95,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          child: (_commonController.dark.value)
                              ? backIconLight
                              : backIconDark,
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      height30,
                      lockQuestionIcon,
                      height30,
                      H3Dark(
                          txt: LanguageController()
                              .getText(forgotPassTxt),),
                      height10,
                      T16Dark(
                        txt: LanguageController().getText(forgotPassSubTxt),
                      ),
                      height30,
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            PhoneTextField(
                              label:
                                  LanguageController().getText(enterPhoneTxt),
                              decoration: inputDecor2,
                              callback: (value) {
                                _userController.userModel.value.mobileNumber =
                                    value.toString();
                              },
                            ),
                            height30,
                            SubmitButton(
                              text:
                                  LanguageController().getText(continueBtnTxt),
                              width: 140,
                              color: lightBlueColor,
                              formKey: _formKey,
                              callback: () async {
                                await _userController.checkUser();
                                if (_userController.response.value ==
                                        "no data" ||
                                    _userController.response.value ==
                                        "dummy data") {
                                  Alert().failFlutterToast(
                                    LanguageController()
                                        .getText(numNotRegisteredTxt),
                                  );
                                } else if (_userController.response.value ==
                                    "error") {
                                  if (!mounted) return;
                                  Alert().failSweetAlert(
                                    LanguageController().getText(errorTxt),
                                    context,
                                    () => {Navigator.pop(context)},
                                  );
                                } else {
                                  final otp = (random.nextInt(900000) + 100000)
                                      .toString();
                                  SMS().sendSms(
                                    _userController
                                        .userModel.value.mobileNumber,
                                    otp,
                                    'fp',
                                  );
                                  if (!mounted) return;
                                  Navigate()
                                      .toNewPassword(context, {"otp": otp});
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Obx(
              () => Center(
                  child: CircularLoader(load: _userController.load.value),),
            )
          ],
        ),
      ),
    );
  }
}
