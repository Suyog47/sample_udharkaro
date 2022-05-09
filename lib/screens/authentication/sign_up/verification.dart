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

class Verification extends StatefulWidget {
  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  final UserController _userController = Get.find();
  final CommonController _commonController = Get.find();
  String pin;
  Random random = Random();

  Timer timer;
  ValueNotifier<dynamic> timeNotifier = ValueNotifier(30);
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
    pin = (random.nextInt(900000) + 100000).toString();
    SMS().sendSms(_userController.userModel.value.mobileNumber, pin, "otp");
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    timerStatusNotifier.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            (!_commonController.dark.value) ? whiteColor : blackColor,
        body: Stack(
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
                    H2Dark(txt: LanguageController().getText(verifyHeaderTxt)),
                    height60,
                    height30,
                    T18Dark(
                      txt: LanguageController().getText(verifySubTxt),
                    ),
                    height30,
                    OTPTextField(
                      decoration: inputDecor2,
                      label: LanguageController().getText(otpTxt),
                      callback: (val) async {
                        if (val.length == 6) {
                          if (pin == val) {
                            final _newpass = PasswordEncryption().encrypt(
                              _userController.userModel.value.password,
                            );
                            _userController.userModel.value.password = _newpass;
                            await _userController.signUp();

                            if (_userController.response.value == "exists") {
                              if (!mounted) return;
                              Alert().warningSweetAlert(
                                LanguageController().getText(profileExistTxt),
                                context,
                                () => Navigate().toLogin(context),
                              );
                            } else if (_userController.response.value ==
                                "error") {
                              if (!mounted) return;
                              Alert().failSweetAlert(
                                LanguageController().getText(errorTxt),
                                context,
                                () => Navigator.pop(context),
                              );
                            } else {
                              _commonController.setLogoutStatus(
                                "${_userController.userModel.value.mobileNumber}-${_userController.userModel.value.password}",
                              );
                              if (!mounted) return;
                              Alert().successSweetAlert(
                                LanguageController().getText(profileCreatedTxt),
                                context,
                                () => Navigate().toSignUp2(context),
                              );
                            }
                          } else {
                            Alert().failFlutterToast(
                                LanguageController().getText(wrongOtpTxt));
                          }
                        }
                      },
                    ),
                    height30,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        T16Dark(
                            txt: LanguageController().getText(verifyBottomTxt)),
                        ValueListenableBuilder<bool>(
                          valueListenable: resendVisibleNotifier,
                         builder: (_, resend, __){
                            return AbsorbPointer(
                              absorbing: resend,
                              child: TextButton(
                                onPressed: () {
                                  timeNotifier.value = 30;
                                  resendVisibleNotifier.value = true;
                                  startTimer();
                                  final otp = (random.nextInt(900000) + 100000)
                                      .toString();
                                  SMS().sendSms(
                                    _userController.userModel.value.mobileNumber,
                                    otp,
                                    "otp",
                                  );
                                  pin = otp;
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
                              txt: "$time ${LanguageController().getText(secTxt)}",
                            );
                          },
                        )
                      ],
                    ),
                    height30,
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
