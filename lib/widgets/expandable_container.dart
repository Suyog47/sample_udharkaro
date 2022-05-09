import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/widgets/widgets.dart';


class ExpandableContainer extends StatefulWidget {
  final Function callback;

  const ExpandableContainer({@required this.callback});

  @override
  _ExpandableContainerState createState() => _ExpandableContainerState();
}

class _ExpandableContainerState extends State<ExpandableContainer> {
  DateTime now = DateTime.now();
  final CommonController _commonController = Get.find();
  String cType = "All";
  String date = DateTime.now().subtract(const Duration(hours: 24)).toString();

  ValueNotifier<int> typeIndexNotifier = ValueNotifier(2);
  ValueNotifier<int> durationIndexNotifier = ValueNotifier(0);
  ValueNotifier<double> typeAnimatedHeightNotifier = ValueNotifier(0.0);
  ValueNotifier<double> durationAnimatedHeightNotifier = ValueNotifier(0.0);

  @override
  void initState() {
    super.initState();
    typeAnimatedHeightNotifier.value = 0.0;
    durationAnimatedHeightNotifier.value = 0.0;
  }

  void typeAnimateTile() => typeAnimatedHeightNotifier.value != 0.0
      ? typeAnimatedHeightNotifier.value = 0.0
      : typeAnimatedHeightNotifier.value = 60.0;

  void durationAnimateTile() => durationAnimatedHeightNotifier.value != 0.0
      ? durationAnimatedHeightNotifier.value = 0.0
      : durationAnimatedHeightNotifier.value = 60.0;

  void changeType(int val) => typeIndexNotifier.value = val;

  void changeDuration(int val) => durationIndexNotifier.value = val;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          color: darkBlueColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ValueListenableBuilder<double>(
                valueListenable: typeAnimatedHeightNotifier,
                builder: (_, typeAnimatedHeight, __) {
                  return Obx(
                    () => InkWell(
                      onTap: () => typeAnimateTile(),
                      child: Row(
                        children: [
                          T14Light(
                            txt: LanguageController().getText(selectTypeTxt),
                          ),
                          if (typeAnimatedHeight == 0.0)
                            keyDownArrowIcon
                          else
                            keyUpArrowIcon,
                        ],
                      ),
                    ),
                  );
                },
              ),
              ValueListenableBuilder<double>(
                  valueListenable: durationAnimatedHeightNotifier,
                  builder: (_, durationAnimatedHeight, __) {
                    return Obx(
                      () => InkWell(
                        onTap: () => durationAnimateTile(),
                        child: Row(
                          children: [
                            T14Light(
                              txt: LanguageController()
                                  .getText(selectDurationTxt),
                            ),
                            if (durationAnimatedHeight == 0.0)
                              keyDownArrowIcon
                            else
                              keyUpArrowIcon,
                          ],
                        ),
                      ),
                    );
                  },),
            ],
          ),
        ),
        ValueListenableBuilder<double>(
          valueListenable: typeAnimatedHeightNotifier,
          builder: (_, typeAnimatedHeight, __) {
            return Obx(
              () => AnimatedContainer(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                duration: const Duration(milliseconds: 120),
                height: typeAnimatedHeight,
                color: (!_commonController.dark.value)
                    ? Colors.grey[200]
                    : blackColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ValueListenableBuilder<int>(
                      valueListenable: typeIndexNotifier,
                      builder: (_, typeIndex, __) {
                        return Button(
                          text: LanguageController().getText(sentBtnTxt),
                          textStyle: t14_Dark,
                          height: 40,
                          color: whiteColor,
                          borderColor:
                              (typeIndex != 0) ? greyColor : greenColor,
                          borderWidth: 5,
                          borderRadius: 30,
                          callback: () {
                            changeType(0);
                            cType = "Sent";
                            widget.callback(cType, date);
                          },
                        );
                      },
                    ),
                    ValueListenableBuilder<int>(
                      valueListenable: typeIndexNotifier,
                      builder: (_, typeIndex, __) {
                        return Button(
                          text: LanguageController().getText(receivedBtnTxt),
                          textStyle: t14_Dark,
                          height: 40,
                          color: whiteColor,
                          borderColor:
                              (typeIndex != 1) ? greyColor : greenColor,
                          borderWidth: 5,
                          borderRadius: 30,
                          callback: () {
                            changeType(1);
                            cType = "Received";
                            widget.callback(cType, date);
                          },
                        );
                      },
                    ),
                    ValueListenableBuilder<int>(
                      valueListenable: typeIndexNotifier,
                      builder: (_, typeIndex, __) {
                        return Button(
                          text: LanguageController().getText(allBtnTxt),
                          textStyle: t14_Dark,
                          height: 40,
                          color: whiteColor,
                          borderColor:
                              (typeIndex != 2) ? greyColor : greenColor,
                          borderWidth: 5,
                          borderRadius: 30,
                          callback: () {
                            changeType(2);
                            cType = "All";
                            widget.callback(cType, date);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        ValueListenableBuilder(
          valueListenable: durationAnimatedHeightNotifier,
          builder: (_, durationAnimatedHeight, __) {
            return Obx(
              () => AnimatedContainer(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                duration: const Duration(milliseconds: 120),
                height: durationAnimatedHeightNotifier.value,
                color: (!_commonController.dark.value)
                    ? Colors.grey[200]
                    : blackColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ValueListenableBuilder<int>(
                      valueListenable: durationIndexNotifier,
                      builder: (_, durationIndex, __) {
                        return Button(
                          text: LanguageController().getText(hour24),
                          textStyle: t14_Dark,
                          width: 50,
                          height: 40,
                          color: whiteColor,
                          borderColor:
                              (durationIndex != 0) ? greyColor : greenColor,
                          borderWidth: 5,
                          borderRadius: 15,
                          callback: () {
                            changeDuration(0);
                            date = now
                                .subtract(const Duration(hours: 24))
                                .toString();

                            widget.callback(cType, date);
                          },
                        );
                      },
                    ),
                    ValueListenableBuilder<int>(
                      valueListenable: durationIndexNotifier,
                      builder: (_, durationIndex, __) {
                        return Button(
                          text: LanguageController().getText(day3),
                          textStyle: t14_Dark,
                          width: 50,
                          height: 40,
                          color: whiteColor,
                          borderColor:
                              (durationIndex != 1) ? greyColor : greenColor,
                          borderWidth: 5,
                          borderRadius: 15,
                          callback: () {
                            changeDuration(1);
                            date = now
                                .subtract(const Duration(days: 3))
                                .toString();

                            widget.callback(cType, date);
                          },
                        );
                      },
                    ),
                    ValueListenableBuilder<int>(
                      valueListenable: durationIndexNotifier,
                      builder: (_, durationIndex, __) {
                        return Button(
                          text: LanguageController().getText(day7),
                          textStyle: t14_Dark,
                          width: 50,
                          height: 40,
                          color: whiteColor,
                          borderColor:
                              (durationIndex != 2) ? greyColor : greenColor,
                          borderWidth: 5,
                          borderRadius: 15,
                          callback: () {
                            changeDuration(2);
                            date = now
                                .subtract(const Duration(days: 7))
                                .toString();
                            widget.callback(cType, date);
                          },
                        );
                      },
                    ),
                    ValueListenableBuilder<int>(
                      valueListenable: durationIndexNotifier,
                      builder: (_, durationIndex, __) {
                        return Button(
                          text: LanguageController().getText(day30),
                          textStyle: t14_Dark,
                          width: 50,
                          height: 40,
                          color: whiteColor,
                          borderColor:
                              (durationIndex != 3) ? greyColor : greenColor,
                          borderWidth: 5,
                          borderRadius: 15,
                          callback: () {
                            changeDuration(3);
                            date = now
                                .subtract(const Duration(days: 30))
                                .toString();

                            widget.callback(cType, date);
                          },
                        );
                      },
                    ),
                    ValueListenableBuilder<int>(
                      valueListenable: durationIndexNotifier,
                      builder: (_, durationIndex, __) {
                        return Button(
                          text: LanguageController().getText(allBtnTxt),
                          textStyle: t14_Dark,
                          width: 50,
                          height: 40,
                          color: whiteColor,
                          borderColor: (durationIndexNotifier.value != 4)
                              ? greyColor
                              : greenColor,
                          borderWidth: 5,
                          borderRadius: 15,
                          callback: () {
                            changeDuration(4);
                            date = "2000-01-01";

                            widget.callback(cType, date);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
