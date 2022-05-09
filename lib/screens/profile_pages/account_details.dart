import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/widgets/widgets.dart';

class AccountDetails extends StatefulWidget {
  @override
  _AccountDetailsState createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  final CommonController _commonController = Get.find();
  final UserController _userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            (!_commonController.dark.value) ? whiteColor : blackColor,
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
              decoration: const BoxDecoration(
                color: darkBlueColor,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: backIconLight,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/editprofile').then(
                            (_) => setState(() {
                              _userController.userModel.value.email =
                                  _userController.userModel.value.email;
                              _userController.userModel.value.accountType =
                                  _userController.userModel.value.accountType;
                              _userController
                                      .userModel.value.businessMainCategory =
                                  _userController
                                      .userModel.value.businessMainCategory;
                              _userController
                                      .userModel.value.businessSubCategory =
                                  _userController
                                      .userModel.value.businessSubCategory;
                              _userController.userModel.value.pic =
                                  _userController.userModel.value.pic;
                            }),
                          );
                        },
                        child: editIcon,
                      ),
                    ],
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        if (_userController.userModel.value.pic != "") {
                          CustomDialog().profileDialog(
                            _userController.userModel.value.pic.toString(),
                            context,
                          );
                        }
                      },
                      child: Hero(
                        tag: "profile",
                        child: Avatar(
                          radius: 60,
                          networkImg:
                              _userController.userModel.value.pic.toString(),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: H3Light(txt: _userController.userModel.value.name),
                  )
                ],
              ),
            ),
            height30,
            Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: T18Dark(txt: LanguageController().getText(profileDetailTxt),),
                  ),
                  height5,
                  Container(
                    decoration: (!_commonController.dark.value)
                        ? rectDecorationLight
                        : rectDecorationDark,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 20,),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            phoneIcon,
                            width10,
                            width10,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AccountDetailsText(txt: LanguageController().getText(phoneTxt)),
                                // Text(
                                //   LanguageController().getText(phoneTxt),
                                //   style: const TextStyle(fontSize: 12, color: greyColor),
                                // ),
                                T18Dark(
                                  txt: _userController.userModel.value.mobileNumber,
                                ),
                              ],
                            ),
                          ],
                        ),
                        height30,
                        Row(
                          children: [
                            emailIcon,
                            width10,
                            width10,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AccountDetailsText(txt: LanguageController().getText(emailTxt)),
                                // Text(
                                //   LanguageController().getText(emailTxt),
                                //   style: const TextStyle(fontSize: 12, color: greyColor),
                                // ),
                                T18Dark(txt: (_userController.userModel.value.email == "") ? "-------------" : _userController.userModel.value.email),
                              ],
                            ),
                          ],
                        ),
                        height30,
                        Row(
                          children: [
                            categoryIcon,
                            width10,
                            width10,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AccountDetailsText(txt: LanguageController().getText(categoryTxt)),
                                // Text(
                                //   LanguageController().getText(categoryTxt),
                                //   style: const TextStyle(fontSize: 12, color: greyColor),
                                // ),
                                T18Dark(
                                  txt: _userController.userModel.value.accountType,
                                ),
                              ],
                            ),
                          ],
                        ),
                        height30,
                        if (_userController.userModel.value.businessMainCategory !=
                                "" &&
                            (_userController.userModel.value.businessMainCategory !=
                                null))
                          Row(
                            children: [
                              subCategoryIcon,
                              width10,
                              width10,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AccountDetailsText(txt: LanguageController().getText(businessMainTxt)),
                                  // Text(
                                  //   LanguageController().getText(businessMainTxt),
                                  //   style:
                                  //       const TextStyle(fontSize: 12, color: greyColor),
                                  // ),
                                  T18Dark(
                                    txt: _userController
                                        .userModel.value.businessMainCategory,
                                  ),
                                ],
                              ),
                            ],
                          )
                        else
                          Container(),
                        height30,
                        if (_userController.userModel.value.businessSubCategory !=
                                "" &&
                            (_userController.userModel.value.businessSubCategory !=
                                null))
                          Row(
                            children: [
                              subCategoryIcon,
                              width10,
                              width10,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AccountDetailsText(txt: LanguageController().getText(businessSubTxt)),
                                  // Text(
                                  //   LanguageController().getText(businessSubTxt),
                                  //   style:
                                  //       const TextStyle(fontSize: 12, color: greyColor),
                                  // ),
                                  T18Dark(
                                    txt: _userController
                                        .userModel.value.businessSubCategory,
                                  ),
                                ],
                              ),
                            ],
                          )
                        else
                          Container(),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
