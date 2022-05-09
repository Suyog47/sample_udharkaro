import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/custom_classes/image_cropper.dart';
import 'package:udhaarkaroapp/custom_classes/navigations.dart';
import 'package:udhaarkaroapp/widgets/widgets.dart';


class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  Random random = Random();
  String _pass;
  String _cpass;
  ValueNotifier<File> imageNotifier = ValueNotifier(null);
  ValueNotifier<bool> obscureNotifier1 = ValueNotifier(true);
  ValueNotifier<bool> obscureNotifier2 = ValueNotifier(true);
  String buttonStatus = "unpressed";

  final UserController _userController = Get.find();
  final CommonController _commonController = Get.find();

  Future _cropImage(image) async{
    final croppedFile = await ImageCropping().crop(image);

    if (croppedFile != null) {
      imageNotifier.value = File(croppedFile.path);
      _userController.userModel.value.pic =
          base64Encode(imageNotifier.value.readAsBytesSync());
    } else {
      _userController.userModel.value.pic = "";
    }
  }

  Future _imgFromGallery() async {
    final picker = ImagePicker();
    final dynamic image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if(image != "" && image != null) {
      await _cropImage(image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            (!_commonController.dark.value) ? whiteColor : blackColor,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                H2Dark(txt: LanguageController().getText(signupHeaderTxt)),
                H4Dark(txt: LanguageController().getText(signupSubHeaderTxt)),
                height30,
                T18Dark(txt: LanguageController().getText(signupSubTxt)),
                height10,
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: (!_commonController.dark.value)
                      ? rectDecorationLight
                      : rectDecorationDark,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ValueListenableBuilder<File>(
                                valueListenable: imageNotifier,
                                builder: (_, image, __) {
                                  return Avatar(
                                    galleryImg: (image == null) ? null : image,
                                    radius: 60,
                                  );
                                },
                              ),
                            ),
                            InkWell(
                              onTap: () => _imgFromGallery(),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: whiteColor,
                                ),
                                child: addPhotoIcon,
                              ),
                            ),
                          ],
                        ),
                        height10,
                        height10,
                        NameTextField(
                          decoration: inputDecor2,
                          label: LanguageController().getText(signupNameTxt),
                          callback: (value) {
                            _userController.userModel.value.name =
                                value.toString();
                          },
                        ),
                        height10,
                        PhoneTextField(
                          decoration: inputDecor2,
                          label: LanguageController().getText(enterPhoneTxt),
                          callback: (value) {
                            _userController.userModel.value.mobileNumber =
                                value.toString();
                          },
                        ),
                        height10,
                        PasswordTextField(
                          decoration: inputDecor2,
                          label: LanguageController().getText(passTxt),
                          callback: (value) {
                            _userController.userModel.value.password =
                                value.toString();
                            _pass = value.toString();
                          },
                        ),
                        height10,
                        PasswordTextField(
                          decoration: inputDecor2,
                          label: LanguageController().getText(signupConfirmPassTxt),
                          callback: (value) {
                            _cpass = value.toString();
                          },
                          canValidate: false,
                        ),
                        height10,
                      ],
                    ),
                  ),
                ),
                height10,
                height10,
                Center(
                  child: SubmitButton(
                    formKey: _formKey,
                    callback: () async {
                      if (buttonStatus == "unpressed") {
                        buttonStatus = "pressed";
                        if (_pass == _cpass) {
                          await _userController.checkUser();
                          if (_userController.response.value == "error") {
                            if (!mounted) return;
                            Alert().failSweetAlert(
                              LanguageController().getText(errorTxt),
                              context,
                              () => {Navigator.pop(context)},
                            );
                          } else if (_userController.response.value ==
                              "no data" || _userController.response.value == "dummy data") {
                            if (!mounted) return;
                            Navigate().toVerification(context);
                          } else {
                            if (!mounted) return;
                            Alert().warningSweetAlert(
                              LanguageController().getText(profileExistTxt),
                              context,
                              () => Navigate().toLogin(context),
                            );
                          }
                        } else {
                          Fluttertoast.showToast(
                            msg:
                                "Confirm Password dont match with Password field",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }
                        buttonStatus = "unpressed";
                      }
                    },
                    text: LanguageController().getText(nextBtnTxt),
                    height: 40,
                    color: lightBlueColor,
                  ),
                ),
                height10,
                Center(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      T16Dark(txt: LanguageController().getText(signupBottomTxt)),
                      width5,
                      InkWell(
                        onTap: () {
                          Navigate().toLogin(context);
                        },
                        child: Text(
                          " ${LanguageController().getText(loginBtnTxt)}",
                          style: const TextStyle(fontSize: 18, color: redColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
