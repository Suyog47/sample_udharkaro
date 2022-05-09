import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/custom_classes/notification_click_check.dart';
import 'package:udhaarkaroapp/widgets/widgets.dart';


class UserTransaction extends StatefulWidget {
  const UserTransaction({Key key}) : super(key: key);

  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> with SingleTickerProviderStateMixin {
  final CommonController _commonController = Get.find();
  final UserDetailsController userTxnController = Get.find();

  final RefreshController _refreshController = RefreshController();
  final ScrollController _scrollController = ScrollController();
  AnimationController _animationController;
  Map data = {};

  @override
  void initState() {
    super.initState();
    userTxnController.getUserTxn();
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    NotificationCheck().check(context);
  }

  Future _onRefresh() async {
    await userTxnController.getUserTxn();
    _refreshController.refreshCompleted();
  }

  @override
  void dispose() {
    Get.delete<UserDetailsController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments as Map;

    return SafeArea(
      child: Scaffold(
        backgroundColor: (!_commonController.dark.value) ? whiteColor : blackColor,
        body: Stack(
          children: [
            Column(
              children: [
                UserTransactionHeader(text: data["name"].toString()),
                ExpandableContainer(
                  callback: (String cType, String date) => userTxnController.getSortedList(cType, date),
                ),
                Flexible(
                  child: Scrollbar(
                    controller: _scrollController,
                    thickness: 7,
                    radius: const Radius.circular(20),
                    child: SmartRefresher(
                      controller: _refreshController,
                      onRefresh: _onRefresh,
                      header: const WaterDropMaterialHeader(),
                      child: Obx(() {
                        if (userTxnController.load.value == 0) {
                          if (userTxnController.sortedUserTxn.isNotEmpty) {
                            return SingleChildScrollView(
                              child: Column(
                                children: [
                                  height5,
                                  ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                    userTxnController.sortedUserTxn.length,
                                    itemBuilder: (context, index) {
                                      return ListAnimation(
                                        position: index,
                                        itemCount:  userTxnController.sortedUserTxn.length,
                                        slideDirection: SlideDirection.fromBottom,
                                        animationController: _animationController,
                                        child: UserDetailCard(
                                          str: userTxnController
                                              .sortedUserTxn[index],
                                          itemIndex: index,
                                          context: context,
                                        ),
                                      );
                                    },
                                  ),
                                  height60,
                                  height10,
                                ],
                              ),
                            );
                          } else if (userTxnController.response.value ==
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
                          return Center(
                            child: FoldingCubeLoader(
                              load: 1,
                              bgContainer: false,
                              color: (_commonController.dark.value)
                                  ? whiteColor
                                  : darkBlueColor,
                            ),
                          );
                        }
                      }),
                    ),
                  ),
                )
              ],
            ),
            // Obx(
            //       () => Center(
            //     child: CircularLoader(load: _txnController.load.value),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
