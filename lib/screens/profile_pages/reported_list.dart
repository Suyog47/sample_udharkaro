import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/custom_classes/notification_click_check.dart';
import 'package:udhaarkaroapp/widgets/widgets.dart';


class ReportedList extends StatefulWidget {
  @override
  _ReportedListState createState() => _ReportedListState();
}

class _ReportedListState extends State<ReportedList>
    with SingleTickerProviderStateMixin {
  final ReportListController _reportListController = Get.find();
  final UserController _userController = Get.find();
  final CommonController _commonController = Get.find();

  final RefreshController _refreshController = RefreshController();
  final ScrollController _scrollController = ScrollController();
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _reportListController.load.value = 1;
    _reportListController.getReportList(_userController.userModel.value.id);

    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    NotificationCheck().check(context);
  }

  Future _onRefresh() async {
    await _reportListController
        .getReportList(_userController.userModel.value.id);
    _refreshController.refreshCompleted();
  }

  @override
  void dispose() {
    _animationController.dispose();
    Get.delete<ReportListController>();
    super.dispose();
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
                SliverHeader(
                    text: LanguageController().getText(reportListHeaderTxt)),
                SliverAppBar(
                  pinned: true,
                  automaticallyImplyLeading: false,
                  toolbarHeight: 70,
                  backgroundColor:
                      (!_commonController.dark.value) ? whiteColor : blackColor,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                      ),
                      child: SearchTextField(
                        decoration: inputDecor2,
                        label: LanguageController().getText(searchTxt),
                        callback: (val) {
                          _reportListController.getSearchedUser(val.toString());
                        },
                      ),
                    ),
                    centerTitle: true,
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    SizedBox(
                      height: displayHeight(context) * 0.7,
                      child: SmartRefresher(
                        controller: _refreshController,
                        onRefresh: _onRefresh,
                        header: const WaterDropMaterialHeader(),
                        child: Obx(() {
                          if (_reportListController.load.value == 0) {
                            if (_reportListController.reportedList.isNotEmpty) {
                              return Scrollbar(
                                controller: _scrollController,
                                thickness: 4,
                                radius: const Radius.circular(20),
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      _reportListController.reportedList.length,
                                  itemBuilder: (context, index) {
                                    return Slidable(
                                      actionPane:
                                          const SlidableDrawerActionPane(),
                                      secondaryActions: <Widget>[
                                        IconSlideAction(
                                          caption: LanguageController()
                                              .getText(unReportBtnTxt),
                                          color: greenColor,
                                          icon: Icons.cancel_rounded,
                                          onTap: () async {
                                            final name = _reportListController
                                                .reportedList[index].name;

                                            await _reportListController
                                                .deleteReport(
                                              _userController
                                                  .userModel.value.id,
                                              _reportListController
                                                  .reportedList[index].id,
                                            );

                                            if (_reportListController
                                                        .response.value ==
                                                    "error" ||
                                                _reportListController
                                                        .response.value ==
                                                    "not deleted") {
                                              LanguageController()
                                                  .getText(operationFailedTxt);
                                            } else {
                                              Alert().successFlutterToast(
                                                  "${LanguageController().getText(unReportedTxt)} $name");
                                            }
                                          },
                                        ),
                                      ],
                                      child: ListAnimation(
                                        position: index,
                                        itemCount: _reportListController
                                            .reportedList.length,
                                        slideDirection:
                                            SlideDirection.fromBottom,
                                        animationController:
                                            _animationController,
                                        child: ReportedListCard(
                                          str: _reportListController
                                              .reportedList[index],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            } else if (_reportListController.response.value ==
                                    "error" &&
                                _reportListController.response.value ==
                                    "not deleted") {
                              return ErrorScreen(
                                text: LanguageController().getText(errorTxt),
                              );
                            } else {
                              return NoDataScreen(
                                text: LanguageController()
                                    .getText(noReportDataTxt),
                              );
                            }
                          } else {
                            return const Text("");
                          }
                        }),
                      ),
                    ),
                  ]),
                )
              ],
            ),
            Obx(
              () => Center(
                child: FoldingCubeLoader(
                  load: _reportListController.updateLoad.value,
                  bgContainer: false,
                  color: (_commonController.dark.value)
                      ? whiteColor
                      : darkBlueColor,
                ),
              ),
            ),
            Obx(
              () =>
                  CircularLoader(load: _reportListController.updateLoad.value),
            ),
          ],
        ),
      ),
    );
  }
}
