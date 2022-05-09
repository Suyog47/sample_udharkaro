import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/custom_classes/navigations.dart';
import 'package:udhaarkaroapp/custom_classes/notification_click_check.dart';
import 'package:udhaarkaroapp/widgets/show_bottom_sheet.dart';
import 'package:udhaarkaroapp/widgets/widgets.dart';
import '../screens.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  int data = 1;
  static String givenTxnSearch = "";
  static String takenTxnSearch = "";

  final GetTakenTransactionController _takenTxnController = Get.find();
  final GetGivenTransactionController _givenTxnController = Get.find();
  final CommonController _commonController = Get.find();

  final RefreshController _refreshController = RefreshController();
  final ScrollController _scrollController = ScrollController();
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _takenTxnController.load.value = 1;
    _takenTxnController.getTakenTransactionData();

    _givenTxnController.load.value = 1;
    _givenTxnController.getGivenTransactionData();

    //confirmationController.getConfirmationList();

    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    NotificationCheck().check(context);
  }

  @override
  void dispose() {
    _animationController.dispose();
    Get.delete<GetGivenTransactionController>();
    Get.delete<GetTakenTransactionController>();
    super.dispose();
  }

  Future _onRefresh() async {
    await _takenTxnController.getTakenTransactionData();
    await _givenTxnController.getGivenTransactionData();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor:
              (!_commonController.dark.value) ? whiteColor : blackColor,
          appBar: AppBar(
            toolbarHeight: 150,
            flexibleSpace: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: (!_commonController.dark.value) ? whiteColor : blackColor,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HomeHeaderText(
                        txt: LanguageController().getText(appName),
                      ),

                      InkWell(
                        onTap: () => Navigate().toQRCode(context),
                        child: qrCodeIcon,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            bottom: TabBar(
              tabs: [
                Obx(
                  () => HomePageTabBarButton(
                    color: lightBlueColor,
                    icon: upArrowWhiteIcon,
                    price: _takenTxnController.total.value.abs().toString(),
                    subtitle: LanguageController().getText(homeGiveHeader),
                    buttonText: LanguageController().getText(homeTakenTxt),
                    count: _takenTxnController.txn.length,
                  ),
                ),
                Obx(
                  () => HomePageTabBarButton(
                    color: lightOrangeColor,
                    icon: downArrowWhiteIcon,
                    price: _givenTxnController.total.value.abs().toString(),
                    subtitle: LanguageController().getText(homeTakeHeader),
                    buttonText: LanguageController().getText(homeGivenTxt),
                    count: _givenTxnController.txn.length,
                  ),
                ),
              ],
              indicatorColor: redColor,
            ),
          ),
          body: SmartRefresher(
            controller: _refreshController,
            onRefresh: _onRefresh,
            header: const WaterDropMaterialHeader(),
            child: TabBarView(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 10,
                      ),
                      child: SearchTextField(
                        value: takenTxnSearch,
                        decoration: inputDecor2,
                        label: LanguageController().getText(searchTxt),
                        callback: (val) {
                          takenTxnSearch = val.toString();
                          _takenTxnController.getSearchedUser(val.toString());
                        },
                      ),
                    ),
                    Obx(() {
                      if (_takenTxnController.load.value == 0) {
                        if (_takenTxnController.txn.isNotEmpty) {
                          return Flexible(
                            child: Scrollbar(
                              controller: _scrollController,
                              thickness: 7,
                              radius: const Radius.circular(20),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: _takenTxnController.txn.length,
                                      itemBuilder: (context, index) {
                                        return ListAnimation(
                                          position: index,
                                          itemCount:
                                              _takenTxnController.txn.length,
                                          slideDirection:
                                              SlideDirection.fromBottom,
                                          animationController:
                                              _animationController,
                                          child: HomeCard(
                                            type: 1,
                                            str: _takenTxnController.txn[index],
                                            itemIndex: index,
                                          ),
                                        );
                                      },
                                    ),
                                    height60,
                                    height10,
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else if (_takenTxnController.response.value ==
                            "error") {
                          return Flexible(
                            child: SingleChildScrollView(
                              child: ErrorScreen(
                                text: LanguageController().getText(errorTxt),
                                height: displayHeight(context) * 0.45,
                              ),
                            ),
                          );
                        } else {
                          return Flexible(
                            child: SingleChildScrollView(
                              child: NoDataScreen(
                                text: LanguageController()
                                    .getText(homeNoTakenDataTxt),
                                height: displayHeight(context) * 0.45,
                              ),
                            ),
                          );
                        }
                      } else {
                        return const FoldingCubeLoader(
                          load: 1,
                          bgContainer: false,
                          color: lightBlueColor,
                        );
                      }
                    }),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 10,
                      ),
                      child: SearchTextField(
                        value: givenTxnSearch,
                        decoration: inputDecor2,
                        label: LanguageController().getText(searchTxt),
                        callback: (val) {
                          givenTxnSearch = val.toString();
                          _givenTxnController.getSearchedUser(val.toString());
                        },
                      ),
                    ),
                    Obx(() {
                      if (_givenTxnController.load.value == 0) {
                        if (_givenTxnController.txn.isNotEmpty) {
                          return Flexible(
                            child: Scrollbar(
                              controller: _scrollController,
                              thickness: 7,
                              radius: const Radius.circular(20),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: _givenTxnController.txn.length,
                                      itemBuilder: (context, index) {
                                        return Slidable(
                                          actionPane:
                                              const SlidableDrawerActionPane(),
                                          actionExtentRatio: 0.5,
                                          secondaryActions: [
                                            IconSlideAction(
                                              caption: LanguageController()
                                                  .getText(sendUserReminderTxt),
                                              color: greenColor,
                                              icon: Icons.send,
                                              onTap: () async {
                                                ShowBottomSheet()
                                                    .getSharingBottomSheet(
                                                        context,
                                                        _givenTxnController
                                                            .txn[index].name,
                                                        _givenTxnController
                                                            .txn[index].number,
                                                        _givenTxnController
                                                            .txn[index].amount
                                                            .replaceAll(
                                                                "-", "",),);
                                              },
                                            ),
                                          ],
                                          child: ListAnimation(
                                            position: index,
                                            itemCount:
                                                _givenTxnController.txn.length,
                                            slideDirection:
                                                SlideDirection.fromBottom,
                                            animationController:
                                                _animationController,
                                            child: HomeCard(
                                              type: 2,
                                              str:
                                                  _givenTxnController.txn[index],
                                              itemIndex: index,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    height60,
                                    height10,
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else if (_givenTxnController.response.value ==
                            "error") {
                          return Flexible(
                            child: SingleChildScrollView(
                              child: ErrorScreen(
                                text: LanguageController().getText(errorTxt),
                                height: displayHeight(context) * 0.45,
                              ),
                            ),
                          );
                        } else {
                          return Flexible(
                            child: SingleChildScrollView(
                              child: NoDataScreen(
                                text: LanguageController()
                                    .getText(homeNoGivenDataTxt),
                                height: displayHeight(context) * 0.45,
                              ),
                            ),
                          );
                        }
                      } else {
                        return const Center(
                          child: FoldingCubeLoader(
                            load: 1,
                            bgContainer: false,
                            color: lightOrangeColor,
                          ),
                        );
                      }
                    }),
                  ],
                ),
              ],
            ),
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TakeFloatingButton(
                callback: () {
                  showGeneralDialog(
                    barrierLabel: "Label",
                    barrierDismissible: false,
                    barrierColor: Colors.black.withOpacity(0.4),
                    transitionDuration: const Duration(milliseconds: 300),
                    context: context,
                    pageBuilder: (context, anim1, anim2) {
                      return const QRCodeScanner(
                        type: 1,
                      );
                    },
                    transitionBuilder: (context, anim1, anim2, child) {
                      return FadeTransition(
                        opacity: Tween(begin: 0.0, end: 1.0).animate(anim1),
                        child: child,
                      );
                    },
                  );
                },
              ),
              GaveFloatingButton(
                callback: () {
                  showGeneralDialog(
                    barrierLabel: "Label",
                    barrierDismissible: false,
                    barrierColor: Colors.black.withOpacity(0.4),
                    transitionDuration: const Duration(milliseconds: 300),
                    context: context,
                    pageBuilder: (context, anim1, anim2) {
                      return const QRCodeScanner(
                        type: 2,
                      );
                    },
                    transitionBuilder: (context, anim1, anim2, child) {
                      return FadeTransition(
                        opacity: Tween(begin: 0.0, end: 1.0).animate(anim1),
                        child: child,
                      );
                    },
                  );
                },
              )
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        ),
      ),
    );
  }
}
