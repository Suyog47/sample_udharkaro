import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/custom_classes/navigations.dart';
import 'package:udhaarkaroapp/services/notification_services.dart';
import 'package:udhaarkaroapp/services/password_encryption_services.dart';
import 'package:udhaarkaroapp/widgets/widgets.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final UserController _userController = Get.find();
  final CommonController _commonController = Get.find();

  Future updateFcmToken() async {
    final bool firstRun = await IsFirstRun.isFirstRun();
    if (firstRun) {
      final token = await NotificationService().getFcmToken();
      _userController.updateFcmToken(token);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _userController.load.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            (!_commonController.dark.value) ? whiteColor : blackColor,
        body: Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 100,
                    right: 20,
                    bottom: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      H1Dark(txt: LanguageController().getText(welcomeTxt)),
                      H4Dark(txt: " ${LanguageController().getText(subTxt)}"),
                      height60,
                      Container(
                        decoration: (!_commonController.dark.value)
                            ? rectDecorationLight
                            : rectDecorationDark,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 20,
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              PhoneTextField(
                                decoration: inputDecor2,
                                label:
                                    LanguageController().getText(enterPhoneTxt),
                                callback: (value) {
                                  _userController.userModel.value.mobileNumber =
                                      value.toString();
                                },
                              ),
                              height10,
                              height10,
                              PasswordTextField(
                                decoration: inputDecor2,
                                label: LanguageController().getText(passTxt),
                                callback: (value) {
                                  _userController.userModel.value.password =
                                      value.toString();
                                },
                              ),
                              height5,
                              Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () {
                                    Navigate().toForgotPassword(context);
                                  },
                                  child: T14Dark(
                                      txt: LanguageController()
                                          .getText(forgotPassTxt),),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      height30,
                      Center(
                        child: SubmitButton(
                          text: LanguageController().getText(loginBtnTxt),
                          width: 150,
                          height: 40,
                          color: lightBlueColor,
                          formKey: _formKey,
                          callback: () async {
                            _userController.userModel.value.password =
                                PasswordEncryption().encrypt(
                              _userController.userModel.value.password,
                            );

                            await _userController.logIn();

                            if (_userController.response.value == "no data") {
                              if (!mounted) return;
                              Alert().failSweetAlert(
                                LanguageController().getText(wrongPhonePassTxt),
                                context,
                                () => {Navigator.pop(context)},
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
                              updateFcmToken();
                              _commonController.setLogoutStatus(
                                "${_userController.userModel.value.mobileNumber}-${_userController.userModel.value.password}",
                              );
                              if (!mounted) return;
                              Navigate().toMainScreen(context);
                            }
                          },
                        ),
                      ),
                      height60,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          T16Dark(txt: LanguageController().getText(bottomTxt)),
                          width5,
                          InkWell(
                            onTap: () {
                              Navigate().toSignUp(context);
                            },
                            child: Text(
                              " ${LanguageController().getText(signupBtnTxt)}",
                              style: const TextStyle(
                                  fontSize: 19, color: blueColor,),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Obx(
              () => Center(
                child: CircularLoader(
                  load: _userController.load.value,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
