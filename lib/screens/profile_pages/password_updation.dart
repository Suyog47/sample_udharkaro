import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/custom_classes/notification_click_check.dart';
import 'package:udhaarkaroapp/services/password_encryption_services.dart';
import 'package:udhaarkaroapp/widgets/widgets.dart';

class PasswordUpdation extends StatefulWidget {
  @override
  _PasswordUpdation createState() => _PasswordUpdation();
}

class _PasswordUpdation extends State<PasswordUpdation> {
  final _formKey = GlobalKey<FormState>();
  String _currentpass;
  String _newpass;
  String _cpass;
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
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    NormalHeader(text: LanguageController().getText(passUpdateHeaderTxt),),
                    height60,
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10,),
                      decoration: (!_commonController.dark.value)
                          ? rectDecorationLight
                          : rectDecorationDark,
                      child: Column(
                        children: [
                          PasswordTextField(
                            decoration: inputDecor2,
                            label: LanguageController().getText(enterOldPassTxt),
                            callback: (value) {
                              _currentpass = value.toString();
                            },
                          ),
                          height10,height10,
                          PasswordTextField(
                            decoration: inputDecor2,
                            label: LanguageController().getText(enterNewPassTxt),
                            callback: (value) {
                              _newpass = value.toString();
                            },
                          ),
                          height10,height10,
                          PasswordTextField(
                            decoration: inputDecor2,
                            label: LanguageController().getText(reEnterNewPassTxt),
                            callback: (value) {
                              _cpass = value.toString();
                            },
                            canValidate: false,
                          ),
                        ],
                      ),
                    ),
                    height30,
                    Center(
                      child: SubmitButton(
                        formKey: _formKey,
                        width: 180,
                        text: LanguageController().getText(updateBtnTxt),
                        color: darkBlueColor,
                        callback: () async {
                          if (PasswordEncryption().encrypt(_currentpass) ==
                              _userController.userModel.value.password) {
                            if (_newpass == _cpass) {
                              _newpass = PasswordEncryption().encrypt(_newpass);

                              await _userController.updateUserPass(_newpass);
                              if (_userController.response.value == "1") {
                                _userController.userModel.value.password =
                                    _newpass;

                                _commonController.setLogoutStatus(
                                  "${_userController.userModel.value.mobileNumber}-${_userController.userModel.value.password}",
                                );
                                if (!mounted) return;
                                Alert().successSweetAlert(
                                  LanguageController().getText(passUpdatedTxt),
                                  context,
                                  () => Navigator.pop(context),
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
                              LanguageController().getText(currentPassTxt),
                            );
                          }
                        },
                      ),
                    )
                  ],
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
      ),
    );
  }
}
