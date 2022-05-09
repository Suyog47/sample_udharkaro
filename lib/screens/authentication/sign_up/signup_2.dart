import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/custom_classes/navigations.dart';
import 'package:udhaarkaroapp/widgets/widgets.dart';

class Signup2 extends StatefulWidget {
  @override
  _CategoryDropDown createState() => _CategoryDropDown();
}

class _CategoryDropDown extends State<Signup2> {
  final UserController _userController = Get.find();
  final CategoryController _categoryController = Get.find();
  final CommonController _commonController = Get.find();

  final _formKey = GlobalKey<FormState>();
  ValueNotifier<String> categoryNotifier = ValueNotifier("Personal Account");
  ValueNotifier<String> mainBusinessNotifier = ValueNotifier(null);
  ValueNotifier<String> subBusinessNotifier = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    _categoryController.businessVisible.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            (!_commonController.dark.value) ? whiteColor : blackColor,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                H2Dark(txt: LanguageController().getText(signupHeaderTxt)),
                H4Dark(txt: LanguageController().getText(signup2SubHeaderTxt)),
                height60,
                //height60,
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: (!_commonController.dark.value)
                      ? rectDecorationLight
                      : rectDecorationDark,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      height10,
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            EmailTextField(
                              decoration: inputDecor2,
                              label: LanguageController().getText(emailTxt),
                              callback: (value) {
                                _userController.userModel.value.email =
                                    value.toString();
                              },
                            ),
                            height10,
                          ],
                        ),
                      ),
                      height30,
                      T16Dark(txt: LanguageController().getText(signup2AccountType)),
                      height5,
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          border: Border.all(
                              color: (_commonController.dark.value)
                                  ? whiteColor
                                  : Colors.black,),
                        ),
                        child: ValueListenableBuilder<String>(
                          valueListenable: categoryNotifier,
                          builder: (_, category, __){
                            return  DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: category,
                                dropdownColor: (!_commonController.dark.value)
                                    ? whiteColor
                                    : Colors.black,
                                icon: categoryDropDownIcon,
                                iconSize: 30,
                                isExpanded: true,
                                onChanged: (val) {
                                    categoryNotifier.value = val.toString();
                                  _userController.userModel.value.accountType =
                                      val.toString();
                                  if (val == "Business Account") {
                                    _categoryController.businessVisible.value =
                                    true;
                                  } else {
                                    _userController.userModel.value.businessMainCategory = "";
                                    _userController.userModel.value.businessSubCategory = "";
                                    _categoryController.businessVisible.value =
                                    false;
                                  }
                                },
                                items: ["Personal Account", "Business Account"]
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
                          }
                        ),
                      ),

                      height10,

                      Obx(
                        () => Visibility(
                          visible: _categoryController.businessVisible.value,
                          child: Column(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 14),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(7),),
                                  border: Border.all(
                                      color: (_commonController.dark.value)
                                          ? whiteColor
                                          : Colors.black,),
                                ),
                                child: ValueListenableBuilder<String>(
                                  valueListenable: mainBusinessNotifier,
                                  builder: (_, main, __){
                                    return DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        hint: const T16Dark(
                                          txt: "Select business main",),
                                        value: main,
                                        dropdownColor: (!_commonController.dark.value)
                                            ? whiteColor
                                            : Colors.black,
                                        icon: categoryDropDownIcon,
                                        iconSize: 30,
                                        isExpanded: true,
                                        onChanged: (val) {
                                            subBusinessNotifier.value = null;
                                            mainBusinessNotifier.value = val.toString();

                                          _categoryController
                                              .getSubBusinessCategory(
                                            val.toString(),);
                                          _userController.userModel.value
                                              .businessMainCategory =
                                              val.toString();
                                        },
                                        items: _categoryController.mainCategoryList
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
                                  }
                                ),
                              ),
                              height10,
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 14),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),),
                                  border: Border.all(
                                      color: (_commonController.dark.value)
                                          ? whiteColor
                                          : Colors.black,),
                                ),
                                child: ValueListenableBuilder<String>(
                                  valueListenable: subBusinessNotifier,
                                  builder: (_, sub, __){
                                    return DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        hint: const T16Dark(
                                          txt: "Select business sub",),
                                        value: sub,
                                        dropdownColor: (!_commonController.dark.value)
                                            ? whiteColor
                                            : Colors.black,
                                        icon: categoryDropDownIcon,
                                        iconSize: 30,
                                        isExpanded: true,
                                        onChanged: (val) {
                                            subBusinessNotifier.value = val.toString();

                                          _userController.userModel.value
                                              .businessSubCategory = val.toString();
                                        },
                                        items: _categoryController.subCategoryList
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
                      )
                    ],
                  ),
                ),
                height10,
                height10,
                Center(
                  child: SubmitButton(
                    text: LanguageController().getText(signupBtnTxt),
                    width: 200,
                    color: lightBlueColor,
                    formKey: _formKey,
                    callback: () async {
                      if(categoryNotifier.value == "Business Account" && (mainBusinessNotifier.value == null || subBusinessNotifier.value == null)) {
                        Alert().failFlutterToast(
                          LanguageController().getText(bothCategorySelectTxt),
                        );
                      }
                      else {
                        await _userController.updateUser(
                          _userController.userModel.value.name,
                          _userController.userModel.value.mobileNumber,
                          _userController.userModel.value.email,
                          _userController.userModel.value.accountType,
                          _userController.userModel.value.businessMainCategory,
                          _userController.userModel.value.businessSubCategory,
                        );

                        if (_userController.response.value == "Data Updated") {
                          if (!mounted) return;
                          Navigate().toMainScreen(context);
                        } else {
                          Alert().failFlutterToast(
                            LanguageController().getText(errorTxt),);
                        }
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
