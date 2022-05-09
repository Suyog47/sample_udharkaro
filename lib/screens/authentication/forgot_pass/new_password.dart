import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/custom_classes/navigations.dart';
import 'package:udhaarkaroapp/services/password_encryption_services.dart';
import 'package:udhaarkaroapp/services/sms_services.dart';
import 'package:udhaarkaroapp/widgets/widgets.dart';

class NewPassword extends StatefulWidget {
  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final _formKey = GlobalKey<FormState>();
  final UserController _userController = Get.find();
  final CommonController _commonController = Get.find();

  String _otp;
  String _pass;
  String _cpass;
  String pin;
  Map data = {};
  Random random = Random();

  Timer timer;
  ValueNotifier<int> timeNotifier = ValueNotifier(30);
  ValueNotifier<bool> resendVisibleNotifier = ValueNotifier(true);
  ValueNotifier<bool> timerStatusNotifier = ValueNotifier(true);

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (timerStatusNotifier.value) {
          if (timeNotifier.value == 0) {
            resendVisibleNotifier.value = false;
            timer.cancel();
          } else {
            timeNotifier.value--;
          }
        } else {
          timer.cancel();
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    timerStatusNotifier.value = false;
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments as Map;
    pin = data["otp"].toString();

    return Scaffold(
      backgroundColor: (!_commonController.dark.value) ? whiteColor : blackColor,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
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
                    H3Dark(txt: LanguageController().getText(newPassHeaderTxt)),
                    height30,
                    T16Dark(
                      txt: LanguageController().getText(newPassSubTxt),
                    ),
                    height30,
                    Form(
                      key: _formKey,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        decoration: (!_commonController.dark.value)
                            ? rectDecorationLight
                            : rectDecorationDark,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            OTPTextField(
                              decoration: inputDecor2,
                              label: LanguageController().getText(otpTxt),
                              callback: (val) {
                                _otp = val.toString();
                              },
                            ),
                            height10,
                            PasswordTextField(
                              decoration: inputDecor2,
                              label:
                                  LanguageController().getText(enterNewPassTxt),
                              callback: (value) {
                                _userController.userModel.value.password =
                                    value.toString();
                                _pass = value.toString();
                              },
                            ),
                            height10,
                            PasswordTextField(
                              decoration: inputDecor2,
                              label: LanguageController()
                                  .getText(reEnterNewPassTxt),
                              callback: (value) {
                                _cpass = value.toString();
                              },
                              canValidate: false,
                            ),
                          ],
                        ),
                      ),
                    ),
                    height10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        T16Dark(
                          txt: LanguageController().getText(verifyBottomTxt),
                        ),
                       ValueListenableBuilder<bool>(
                            valueListenable: resendVisibleNotifier,
                            builder: (_, resend,__){
                              return AbsorbPointer(
                                absorbing: resend,
                                child: TextButton(
                                  onPressed: () {
                                    timeNotifier.value = 30;
                                    resendVisibleNotifier.value = true;
                                    startTimer();
                                    pin = (random.nextInt(900000) + 100000)
                                        .toString();
                                    SMS().sendSms(
                                      _userController.userModel.value.mobileNumber,
                                      pin,
                                      "fp",
                                    );
                                  },
                                  child: Text(
                                    " ${LanguageController().getText(resendTxt)}",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: redColor,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        width5,
                        ValueListenableBuilder(
                          valueListenable: timeNotifier,
                          builder: (_, time, __) {
                            return T18Dark(
                              txt:
                                  "$time ${LanguageController().getText(secTxt)}",
                            );
                          },
                        ),
                      ],
                    ),
                    height10,
                    height10,
                    SubmitButton(
                      text: LanguageController().getText(resetPassBtnTxt),
                      width: 200,
                      color: lightBlueColor,
                      formKey: _formKey,
                      callback: () async {
                        if (_otp == pin) {
                          if (_pass == _cpass) {
                            _pass = PasswordEncryption().encrypt(_pass);

                            await _userController.updateUserPass(_pass);
                            if (_userController.response.value == "1") {
                              timerStatusNotifier.value = false;
                              if (!mounted) return;
                              Alert().successSweetAlert(
                                LanguageController().getText(passUpdatedTxt),
                                context,
                                () => Navigate().toLogin(context),
                              );
                            } else {
                              if (!mounted) return;
                              Alert().failSweetAlert(
                                LanguageController().getText(errorTxt),
                                context,
                                () => {Navigator.pop(context)},
                              );
                            }
                          } else {
                            Alert().failFlutterToast(
                              LanguageController().getText(passDontMatchTxt),
                            );
                          }
                        } else {
                          Alert().failFlutterToast(
                            LanguageController().getText(wrongOtpTxt),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            Obx(
              () => Center(
                child: CircularLoader(load: _userController.load.value),
              ),
            )
          ],
        ),
      ),
    );
  }
}
