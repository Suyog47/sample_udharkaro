import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/custom_classes/navigations.dart';
import 'package:udhaarkaroapp/custom_classes/notification_click_check.dart';
import 'package:udhaarkaroapp/widgets/widgets.dart';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  final UserController _userController = Get.find();
  final CommonController _commonController = Get.find();

  AnimationController animationController;
  Animation<double> animation;
  ValueNotifier<bool> circleAnimationNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    circleAnimationNotifier.value = false;
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    );
    animationController.forward();
    NotificationCheck().check(context);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = displaySize(context);
    return ValueListenableBuilder<bool>(
      valueListenable: circleAnimationNotifier,
      builder: (_, cirAn, __) {
        return cirAn
            ? CircularRevealAnimation(
                centerOffset: Offset(size.height / 15, size.width / 8.5),
                animation: animation,
                child: _body(),
              )
            : _body();
      },
    );
  }

  Widget _body() {
    return SafeArea(
      child: Obx((){
        return Scaffold(
          backgroundColor:
          (!_commonController.dark.value) ? whiteColor : blackColor,
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
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
                            _commonController.switchTheme();
                            _commonController.setTheme();
                            circleAnimationNotifier.value = true;
                            if (animationController.status ==
                                AnimationStatus.forward ||
                                animationController.status ==
                                    AnimationStatus.completed) {
                              animationController.reset();
                              animationController.forward();
                            } else {
                              animationController.forward();
                            }
                            // circleAnimationNotifier.value = false;
                          },
                          child: Obx(
                                () => Icon(
                              (!_commonController.dark.value)
                                  ? Icons.wb_sunny
                                  : MdiIcons.moonWaxingCrescent,
                              color: whiteColor,
                            ),
                          ),
                        ),
                        InkWell(
                          child: shareIconLight,
                          onTap: () {
                            Share.share(
                              'Ab Udhaar Karo befikar, check out the UdhaarKaro app - the modern generation Bahi Khata - https://play.google.com/store/apps/details?id=com.pinsout.udhaarkaroapp',
                              subject: "Udhaar karo app invitation",
                            );
                          },
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
                            radius: 50,
                            networkImg:
                            _userController.userModel.value.pic.toString(),
                          ),
                        ),
                      ),
                    ),
                    height10,
                    Center(
                      child: H3Light(txt: _userController.userModel.value.name),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: SingleChildScrollView(
                  child: Obx(
                        () => Container(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Column(
                        children: [
                          InkWell(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                T20Dark(
                                  txt: LanguageController()
                                      .getText(profileDetailTxt),
                                ),
                                if (_commonController.dark.value)
                                  profilePageIconLight
                                else
                                  profilePageIconDark,
                              ],
                            ),
                            onTap: () {
                              Navigate().toAccountDetails(context);
                            },
                          ),
                          height10,
                          height10,
                          InkWell(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                T20Dark(
                                  txt:
                                  LanguageController().getText(changePassTxt),
                                ),
                                if (_commonController.dark.value)
                                  profilePageIconLight
                                else
                                  profilePageIconDark,
                              ],
                            ),
                            onTap: () {
                              Navigate().toPasswordUpdation(context);
                            },
                          ),
                          height10,
                          height10,
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, "/privacypolicy");
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                T20Dark(
                                  txt: LanguageController()
                                      .getText(privacyPolicyTxt),
                                ),
                                if (_commonController.dark.value)
                                  profilePageIconLight
                                else
                                  profilePageIconDark,
                              ],
                            ),
                          ),
                          height10,
                          height10,
                          InkWell(
                            onTap: () {
                              Navigate().toFeedback(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                T20Dark(
                                  txt: LanguageController()
                                      .getText(feedbackFormTxt),
                                ),
                                if (_commonController.dark.value)
                                  profilePageIconLight
                                else
                                  profilePageIconDark,
                              ],
                            ),
                          ),
                          height10,
                          height10,
                          InkWell(
                            onTap: () {
                              Navigate().toUserList(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                T20Dark(
                                  txt: LanguageController().getText(userListTxt),
                                ),
                                if (_commonController.dark.value)
                                  profilePageIconLight
                                else
                                  profilePageIconDark,
                              ],
                            ),
                          ),
                          height10,
                          height10,
                          InkWell(
                            onTap: () {
                              Navigate().toReportList(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                T20Dark(
                                  txt:
                                  LanguageController().getText(reportListTxt),
                                ),
                                if (_commonController.dark.value)
                                  profilePageIconLight
                                else
                                  profilePageIconDark,
                              ],
                            ),
                          ),
                          height10,
                          height10,
                          InkWell(
                            onTap: () {
                              Navigate().toAboutUs(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                T20Dark(
                                  txt: LanguageController().getText(aboutUsTxt),
                                ),
                                if (_commonController.dark.value)
                                  profilePageIconLight
                                else
                                  profilePageIconDark,
                              ],
                            ),
                          ),
                          height10,
                          height10,
                          InkWell(
                            onTap: () {
                              Navigate().toSettings(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                T20Dark(
                                  txt: LanguageController().getText(settingsTxt),
                                ),
                                if (_commonController.dark.value)
                                  profilePageIconLight
                                else
                                  profilePageIconDark,
                              ],
                            ),
                          ),
                          height10,
                          height5,
                          if (_commonController.dark.value)
                            dividerLight
                          else
                            dividerDark,
                          height10,
                          height10,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                child: LogoutText(
                                  txt: LanguageController().getText(logoutTxt),
                                ),
                                onTap: () {
                                  Get.delete<UserController>();
                                  _commonController.setLogoutStatus("logout");
                                  Navigate().toLogin(context);
                                },
                              ),
                              if (_commonController.dark.value)
                                logoutIconLight
                              else
                                logoutIconDark
                            ],
                          ),
                          height30,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      })
    );
  }
}
