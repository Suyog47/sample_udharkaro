import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/custom_classes/notification_click_check.dart';
import 'package:udhaarkaroapp/widgets/widgets.dart';

class Reports extends StatefulWidget {
  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<Reports> with SingleTickerProviderStateMixin {
  final ReportListController _reportListController = Get.find();
  final UserController _userController = Get.find();
  final CommonController _commonController = Get.find();

  final RefreshController _refreshController = RefreshController();
  final ScrollController _scrollController = ScrollController();
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    if (_reportListController.reports.isEmpty) {
      _reportListController.load.value = 1;
    }
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _reportListController.fetchReportList(_userController.userModel.value.id);
    NotificationCheck().check(context);
  }

  @override
  void dispose() {
    _animationController.dispose();
    Get.delete<ReportListController>();
    super.dispose();
  }

  Future _onRefresh() async {
    await _reportListController
        .fetchReportList(_userController.userModel.value.id);
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
            CustomScrollView(
              slivers: [
                SliverHeader(text: LanguageController().getText(reportHeaderTxt),),
                SliverList(
                  delegate: SliverChildListDelegate([
                    SingleChildScrollView(
                      child: SizedBox(
                        height: displayHeight(context) * 0.78,
                        child: Scrollbar(
                          controller: _scrollController,
                          thickness: 7,
                          radius: const Radius.circular(20),
                          child: SmartRefresher(
                            controller: _refreshController,
                            onRefresh: _onRefresh,
                            header: const WaterDropMaterialHeader(),
                            child: Obx(() {
                              if (_reportListController.load.value == 0) {
                                if (_reportListController.reports.isNotEmpty) {
                                  return ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: _reportListController.reports.length,
                                    itemBuilder: (context, index) {
                                      return ListAnimation(
                                        position: index,
                                        itemCount: _reportListController.reports.length,
                                        slideDirection: SlideDirection.fromBottom,
                                        animationController: _animationController,
                                        child: ReportCard(
                                          str: _reportListController.reports[index],
                                        ),
                                      );
                                    },
                                  );
                                } else if (_reportListController.response.value ==
                                    "error") {
                                  return ErrorScreen(
                                    text:
                                    LanguageController().getText(errorTxt),
                                  );
                                } else {
                                  return NoDataScreen(
                                    text: LanguageController().getText(noReportDataTxt),
                                  );
                                }
                              } else {
                                return const Text("");
                              }
                            }),
                          ),
                        ),
                      ),
                    ),
                  ]),
                )
              ],
            ),
            Obx(
              () => Center(
                child: FoldingCubeLoader(
                  load: _reportListController.load.value,
                  bgContainer: false,
                  color: (_commonController.dark.value)
                      ? whiteColor
                      : darkBlueColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
