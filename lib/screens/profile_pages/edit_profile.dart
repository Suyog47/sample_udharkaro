import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/custom_classes/image_cropper.dart';
import 'package:udhaarkaroapp/custom_classes/notification_click_check.dart';
import 'package:udhaarkaroapp/widgets/widgets.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final UserController _userController = Get.find();
  final CategoryController _categoryController = Get.find();
  final CommonController _commonController = Get.find();

  ValueNotifier<String> categoryNotifier = ValueNotifier(null);
  ValueNotifier<String> mainBusinessNotifier = ValueNotifier(null);
  ValueNotifier<String> subBusinessNotifier = ValueNotifier(null);

  String _name;
  String _num;
  File _pic;
  String _email;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _name = _userController.userModel.value.name;
    _num = _userController.userModel.value.mobileNumber;
    _email = _userController.userModel.value.email;
    categoryNotifier.value = _userController.userModel.value.accountType;

    if (categoryNotifier.value == "Business Account") {
      _categoryController.businessVisible.value = true;
      mainBusinessNotifier.value =
          _userController.userModel.value.businessMainCategory;
      subBusinessNotifier.value =
          _userController.userModel.value.businessSubCategory;
      _categoryController.getSubBusinessCategory(mainBusinessNotifier.value);
    } else {
      _categoryController.businessVisible.value = false;
    }
    NotificationCheck().check(context);
  }

  @override
  void dispose(){
    //Get.delete<CategoryController>();
    super.dispose();
  }

  Future _cropImage(image) async {
    final croppedFile = await ImageCropping().crop(image);

    if (croppedFile != null) {
      _pic = File(croppedFile.path);
      await _userController
          .updateUserImage(base64Encode(_pic.readAsBytesSync()));
      if (_userController.response.value != "not updated") {
        setState(() {
          _userController.userModel.value.pic = _userController.response.value;
        });
        Alert()
            .successFlutterToast(LanguageController().getText(imageUpdatedTxt));
      } else {
        Alert().failFlutterToast(LanguageController().getText(errorTxt));
      }
    }
  }

  Future _imgFromGallery() async {
    final picker = ImagePicker();
    final dynamic image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (image != "" && image != null) {
      await _cropImage(image);
    }
  }

  Future update() async {
    await _userController.updateUser(
        _name,
        _num,
        _email,
        categoryNotifier.value,
        mainBusinessNotifier.value,
        subBusinessNotifier.value,);
    if (_userController.response.value == "Data Updated") {
      _userController.userModel.value.name = _name;
      _userController.userModel.value.email = _email;
      _userController.userModel.value.accountType = categoryNotifier.value;
      _userController.userModel.value.businessMainCategory =
          mainBusinessNotifier.value;
      _userController.userModel.value.businessSubCategory =
          subBusinessNotifier.value;
      Alert().successFlutterToast(LanguageController().getText(dataUpdatedTxt));
    } else {
      Alert().failFlutterToast(LanguageController().getText(errorTxt));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            (!_commonController.dark.value) ? whiteColor : blackColor,
        body: Stack(
          children: [
            Column(
              children: [
                Obx(() {
                  return Container(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                    decoration: const BoxDecoration(
                      color: darkBlueColor,
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: backIconLight,
                          ),
                        ),
                        Center(
                          child: Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Hero(
                                  tag: "profile",
                                  child: Avatar(
                                    networkImg: _userController
                                        .userModel.value.pic
                                        .toString(),
                                    radius: 60,
                                  ),
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
                        ),
                      ],
                    ),
                  );
                }),
                Flexible(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            NameTextField(
                              value: _name,
                              decoration: inputDecor,
                              label:
                                  LanguageController().getText(signupNameTxt),
                              callback: (value) {
                                _name = value.toString();
                              },
                            ),
                            height10,
                            PhoneTextField(
                              value: _num,
                              decoration: inputDecor,
                              label: LanguageController().getText(phoneTxt),
                              enabled: false,
                              callback: (value) {},
                            ),
                            height10,
                            EmailTextField(
                              value: _email,
                              decoration: inputDecor,
                              label: LanguageController().getText(emailTxt),
                              callback: (value) {
                                _email = value.toString();
                              },
                            ),
                            height10,
                            height10,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                T14Dark(
                                  txt:
                                      LanguageController().getText(categoryTxt),
                                ),
                                height2,
                                height1,
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    border: Border.all(
                                      color: (_commonController.dark.value)
                                          ? whiteColor
                                          : Colors.black,
                                    ),
                                  ),
                                  child: ValueListenableBuilder<String>(
                                    valueListenable: categoryNotifier,
                                    builder: (_, category, __) {
                                      return DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          hint: const T16Dark(
                                            txt: "Select account type",
                                          ),
                                          value: category ?? "Personal Account",
                                          dropdownColor:
                                              (!_commonController.dark.value)
                                                  ? whiteColor
                                                  : Colors.black,
                                          icon: categoryDropDownIcon,
                                          iconSize: 30,
                                          isExpanded: true,
                                          onChanged: (val) {
                                            categoryNotifier.value =
                                                val.toString();
                                            if (val == "Business Account") {
                                              _categoryController
                                                  .businessVisible.value = true;
                                            } else {
                                              _categoryController
                                                  .businessVisible
                                                  .value = false;
                                            }
                                          },
                                          items: [
                                            "Personal Account",
                                            "Business Account"
                                          ].map((e) {
                                            return DropdownMenuItem(
                                              value: e,
                                              child: T16Dark(
                                                txt: e,
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            height10,
                            Obx(
                              () => Visibility(
                                visible:
                                    _categoryController.businessVisible.value,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 14,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(7),
                                        ),
                                        border: Border.all(
                                          color: (_commonController.dark.value)
                                              ? whiteColor
                                              : Colors.black,
                                        ),
                                      ),
                                      child: ValueListenableBuilder<String>(
                                        valueListenable: mainBusinessNotifier,
                                        builder: (_, main, __) {
                                          return DropdownButtonHideUnderline(
                                            child: DropdownButton(
                                              hint: const T16Dark(
                                                txt: "Select business main",
                                              ),
                                              value: main,
                                              dropdownColor:
                                                  (!_commonController.dark.value)
                                                      ? whiteColor
                                                      : Colors.black,
                                              icon: categoryDropDownIcon,
                                              iconSize: 30,
                                              isExpanded: true,
                                              onChanged: (val) {
                                                subBusinessNotifier.value =
                                                    null;
                                                mainBusinessNotifier.value =
                                                    val.toString();

                                                _categoryController
                                                    .getSubBusinessCategory(
                                                  val.toString(),
                                                );
                                              },
                                              items: _categoryController
                                                  .mainCategoryList
                                                  .map((e) {
                                                return DropdownMenuItem(
                                                  value: e,
                                                  child: T16Dark(
                                                    txt: e,
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    height10,
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 14,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          bottomRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                        ),
                                        border: Border.all(
                                          color: (_commonController.dark.value)
                                              ? whiteColor
                                              : Colors.black,
                                        ),
                                      ),
                                      child: ValueListenableBuilder<String>(
                                        valueListenable: subBusinessNotifier,
                                        builder: (_, sub, __) {
                                          return DropdownButtonHideUnderline(
                                            child: DropdownButton(
                                              hint: const T16Dark(
                                                txt: "Select business sub",
                                              ),
                                              value: sub,
                                              dropdownColor:
                                                  (!_commonController.dark.value)
                                                      ? whiteColor
                                                      : Colors.black,
                                              icon: categoryDropDownIcon,
                                              iconSize: 30,
                                              isExpanded: true,
                                              onChanged: (val) {
                                                subBusinessNotifier.value =
                                                    val.toString();
                                              },
                                              items: _categoryController
                                                  .subCategoryList
                                                  .map((e) {
                                                return DropdownMenuItem(
                                                  value: e,
                                                  child: T16Dark(
                                                    txt: e,
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    height10,
                                  ],
                                ),
                              ),
                            ),
                            height30,
                            Center(
                              child: SubmitButton(
                                text: LanguageController().getText(saveBtnTxt),
                                width: 300,
                                color: darkBlueColor,
                                formKey: _formKey,
                                callback: () async {
                                  if (categoryNotifier.value ==
                                      "Business Account") {
                                    if (mainBusinessNotifier.value != "" &&
                                        subBusinessNotifier.value != "") {
                                      update();
                                    } else {
                                      Alert().failFlutterToast(
                                        LanguageController()
                                            .getText(bothCategorySelectTxt),
                                      );
                                    }
                                  } else {
                                    mainBusinessNotifier.value = "";
                                    subBusinessNotifier.value = "";
                                    update();
                                  }
                                },
                              ),
                            ),
                            height10,
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
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
