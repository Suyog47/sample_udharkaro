import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:udhaarkaroapp/api_calls/user.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/custom_classes/navigations.dart';
import 'package:udhaarkaroapp/widgets/widgets.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final UserController _userController = Get.find();
  final CategoryController _categoryController = Get.find();
  final CommonController _commonController = Get.find();

  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final RemoteNotification notification = message.notification;
      final AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        notificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'high importance channel',
              'high importance notification',
              'channel is used to create notification',
              enableLights: true,
              importance: Importance.high,
              priority: Priority.high,
              icon: "@mipmap/launcher_icon",
            ),
          ),
        );
      }
    });
  }

  Future checkVersion() async {
    final res = await UserApiCalls().checkAppVersion();
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();

    if (res != "error") {
      final String dbVersion = res["version"].toString().split("+")[0];
      final String dbBuild = res["version"].toString().split("+")[1];

      final String systemVersion = packageInfo.version;
      final String systemBuild = packageInfo.buildNumber;

      if (int.parse(systemVersion.replaceAll(".", "")) ==
          int.parse(dbVersion.replaceAll(".", ""))) {
        if (int.parse(systemBuild) >= int.parse(dbBuild)) {
          if (!mounted) return;
          checkStatus(context);
        }
        else {
          if (!mounted) return;
          Alert().warningSweetAlert(
              LanguageController().getText(newVersionUpdateTxt), context, () {
            StoreRedirect.redirect(
              androidAppId: "com.pinsout.udhaarkaroapp",
              iOSAppId: "com.pinsout.udhaarkaroapp",);
          });
        }
      }
      else if (int.parse(systemVersion.replaceAll(".", "")) >
          int.parse(dbVersion.replaceAll(".", ""))) {
        if (!mounted) return;
        checkStatus(context);
      }
      else {
        if (!mounted) return;
        Alert().warningSweetAlert(
            LanguageController().getText(newVersionUpdateTxt), context, () {
          StoreRedirect.redirect(
            androidAppId: "com.pinsout.udhaarkaroapp",
            iOSAppId: "com.pinsout.udhaarkaroapp",);
        });
      }
    }
    else{
      if (!mounted) return;
      Alert().failSweetAlert(
        LanguageController().getText(errorTxt),
        context,
            () => exit(0),
      );
    }
  }

  Future getLogoutStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.getString('logout_status') == null)
        ? "logout"
        : prefs.getString('logout_status');
  }

  Future checkStatus(BuildContext context) async {
    await _commonController.getTheme();
    await _commonController.getLang();
    final status = await getLogoutStatus();
    if (status == "logout") {

      final bool firstRun = await IsFirstRun.isFirstRun();
      if (firstRun) {
        if (!mounted) return;
        await CustomDialog().selectLangDialog(context);
      }
      else{
        if (!mounted) return;
        Navigate().toLogin(context);
      }
    } else {
      _userController.userModel.value.mobileNumber =
          status.split("-")[0].toString();
      _userController.userModel.value.password =
          status.split("-")[1].toString();

      await _userController.logIn();

      if (_userController.response.value == "no data") {
        if (!mounted) return;
        Navigate().toLogin(context);
        }
       else if (_userController.response.value == "error") {
        if (!mounted) return;
        Alert().failSweetAlert(
          LanguageController().getText(errorTxt),
          context,
          () => exit(0),
        );
      } else {
        if (!mounted) return;
        Navigate().toMainScreen(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    checkVersion();
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/images/splashbg.png",
                ),
                fit: BoxFit.fill,),
          ),
          width: displayWidth(context),
          height: displayHeight(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Splash1Text(txt: "New Way"),
              height10,
              height10,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Splash1Text(txt: "to"),
                  width10,
                  width10,
                  Splash2Text(txt: "Udhaar"),
                ],
              ),
              height60,
              height30,
              const CircularProgressIndicator()
            ],
          ),
        ),
      ),
    );
  }
}
