import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/screens/screens.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final CommonController _commonController = Get.find();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ValueNotifier<int> indexNotifier = ValueNotifier(1);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ValueListenableBuilder<int>(
        valueListenable: indexNotifier,
        builder: (_, index, __) {
          return  WillPopScope(
            onWillPop: () async {
              SystemNavigator.pop();
              return true;
            },
            child: Scaffold(
              key: _scaffoldKey,
              body: (index == 0)
                  ? Notifications()
                  : (index == 1)
                      ? Home()
                      : ProfilePage(),

              bottomNavigationBar: Obx(
                    () => CurvedNavigationBar(
                      color: (_commonController.dark.value)
                          ? black38
                          : Colors.grey[200],
                      backgroundColor: Colors.transparent,
                      buttonBackgroundColor: lightOrangeColor,
                      height: 50,
                      index: index,
                      animationDuration: const Duration(milliseconds: 300),
                      items: [
                        if (!_commonController.dark.value)
                          bellIconDark
                        else
                          bellIconLight,
                        if (!_commonController.dark.value)
                          homeIconDark
                        else
                          homeIconLight,
                        if (!_commonController.dark.value)
                          accountCircleIconDark
                        else
                          accountCircleIconLight,
                      ],
                      onTap: (index) {
                        indexNotifier.value = index;
                      },
                    ),
            ),
            ),
          );
        },
      ),
    );
  }
}
