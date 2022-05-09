import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/custom_classes/notification_click_check.dart';
import 'package:udhaarkaroapp/widgets/widgets.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications>
    with SingleTickerProviderStateMixin {
  final UserController _userController = Get.find();
  final GetAllTransactionController _allTxnController = Get.find();
  final CommonController _commonController = Get.find();
  String type;
  String duration;

  final RefreshController _refreshController = RefreshController();
  final ScrollController _scrollController = ScrollController();
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _allTxnController.allTransactionData(_userController.userModel.value.id);

    NotificationCheck().check(context);
  }

  @override
  void dispose() {
    _animationController.dispose();
    Get.delete<GetAllTransactionController>();
    Get.delete<UserDetailsController>();
    super.dispose();
  }

  Future _onRefresh() async {
    await _allTxnController
        .allTransactionData(_userController.userModel.value.id, cType: type, date: duration);
    _refreshController.refreshCompleted();
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
                NormalHeader(
                  text: LanguageController().getText(notifyHeaderTxt),
                  backIcon: false,
                  frontIcon: true,
                ),
                ExpandableContainer(callback: (String cType, String date) {
                  type = cType;
                  duration = date;
                  _allTxnController.getSortedList(cType, date);
                },),
                height5,
                Flexible(
                  child: Scrollbar(
                    controller: _scrollController,
                    thickness: 6,
                    radius: const Radius.circular(20),
                    child: SmartRefresher(
                      controller: _refreshController,
                      onRefresh: _onRefresh,
                      header: const WaterDropMaterialHeader(),
                      child: Obx(() {
                        if (_allTxnController.load.value == 0) {
                          if (_allTxnController.sortedUserTxn.isNotEmpty) {
                            return SingleChildScrollView(
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    _allTxnController.sortedUserTxn.length,
                                itemBuilder: (context, index) {
                                  return ListAnimation(
                                    position: index,
                                    itemCount:
                                        _allTxnController.sortedUserTxn.length,
                                    slideDirection: SlideDirection.fromBottom,
                                    animationController: _animationController,
                                    child: NotificationCard(
                                      str: _allTxnController
                                          .sortedUserTxn[index],
                                      context: context,
                                      itemIndex: index,
                                    ),
                                  );
                                },
                              ),
                            );
                          } else if (_allTxnController.response.value ==
                              "error") {
                            return ErrorScreen(
                              text: LanguageController().getText(errorTxt),
                            );
                          } else {
                            return NoDataScreen(
                              text: LanguageController().getText(noDataTxt),
                            );
                          }
                        } else {
                          return const Text("");
                        }
                      }),
                    ),
                  ),
                )
              ],
            ),
            Obx(
              () => Center(
                child: FoldingCubeLoader(
                  load: _allTxnController.load.value,
                  bgContainer: false,
                  color: (_commonController.dark.value)
                      ? whiteColor
                      : darkBlueColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
