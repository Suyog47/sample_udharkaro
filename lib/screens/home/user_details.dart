import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/custom_classes/notification_click_check.dart';
import 'package:udhaarkaroapp/custom_classes/transaction_operation.dart';
import 'package:udhaarkaroapp/widgets/show_bottom_sheet.dart';
import 'package:udhaarkaroapp/widgets/widgets.dart';

class UserDetails extends StatefulWidget {
  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails>
    with SingleTickerProviderStateMixin {
  Map _data = {};
  final UserDetailsController _userTxnController = Get.find();
  final CommonController _commonController = Get.find();
  final GetGivenTransactionController _givenTxnController = Get.find();

  final RefreshController _refreshController = RefreshController();
  final ScrollController _scrollController = ScrollController();
  AnimationController _animationController;
  ValueNotifier<int> isLoading = ValueNotifier(0);
  String type;
  String duration;

  @override
  void initState() {
    super.initState();
    _userTxnController.getUserTxn();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    NotificationCheck().check(context);
  }

  void handleClick(String val) {
    if (val == LanguageController().getText(sendReminderTxt)) {
      ShowBottomSheet().getSharingBottomSheet(
        context,
        _data["name"].toString(),
        _data["number"].toString(),
        _data["amount"].toString(),
      );
    } else {
      final String limit =
          _givenTxnController.txn[int.parse(_data["index"].toString())].limit;

      ShowBottomSheet().getUserBottomSheet(
          context,
          _data["name"].toString(),
          _data["number"].toString(),
          limit,
          _data["id"].toString(),
          _data["reportStatus"].toString(),
          _data["fcmToken"].toString(), () async {
        isLoading.value = 1;
        await _givenTxnController.getGivenTransactionData();
        isLoading.value = 0;
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _givenTxnController.getGivenTransactionData();
    Get.delete<UserDetailsController>();
    Get.delete<GetAllTransactionController>();
    Get.delete<TransactionController>();
    super.dispose();
  }

  Future _onRefresh() async {
    await _userTxnController.getUserTxn(cType: type, date: duration);
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    _data = ModalRoute.of(context).settings.arguments as Map;

    return SafeArea(
      child: Scaffold(
        backgroundColor:
            (!_commonController.dark.value) ? whiteColor : blackColor,
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
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
                              Navigator.pop(context);
                            },
                            child: backIconLight,
                          ),
                          PopupMenuButton<String>(
                            icon: menuIcon,
                            color: whiteColor,
                            onSelected: handleClick,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            itemBuilder: (BuildContext context) {
                              if (_data["type"] == 1) {
                                return [
                                  LanguageController().getText(sendReminderTxt)
                                ].map((String choice) {
                                  return PopupMenuItem<String>(
                                    value: choice,
                                    child: Center(child: Text(choice)),
                                  );
                                }).toList();
                              } else {
                                return [
                                  PopupMenuItem<String>(
                                    value: LanguageController()
                                        .getText(setLimitReportTxt),
                                    child: Center(
                                      child: Text(LanguageController()
                                          .getText(setLimitReportTxt),),
                                    ),
                                  ),
                                  const PopupMenuDivider(),
                                  PopupMenuItem<String>(
                                    value: LanguageController()
                                        .getText(sendReminderTxt),
                                    child: Center(
                                      child: Text(
                                        LanguageController()
                                            .getText(sendReminderTxt),
                                      ),
                                    ),
                                  ),
                                ];
                              }
                              // return
                            },
                          ),
                        ],
                      ),
                      height5,
                      Center(
                        child: InkWell(
                          onTap: () {
                            if (_data["pic"] != "") {
                              CustomDialog().profileDialog(
                                _data["pic"].toString(),
                                context,
                              );
                            }
                          },
                          child: Hero(
                            tag: _data["heroTag"],
                            child: Avatar(
                              radius: 40,
                              networkImg: _data["pic"].toString(),
                            ),
                          ),
                        ),
                      ),
                      height10,
                      Center(child: H3Light(txt: _data["name"].toString())),
                      height5,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          T14Light(
                            txt: (_data["type"] == 1)
                                ? LanguageController().getText(headerSubTakeTxt)
                                : LanguageController()
                                    .getText(headerSubGiveTxt),
                          ),
                          T16Light(
                            txt: _data["amount"].toString().replaceAllMapped(
                                  RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                  (Match m) => '${m[1]},',
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ExpandableContainer(
                  callback: (String cType, String date) {
                    type = cType;
                    duration = date;
                    _userTxnController.getSortedList(cType, date);
                  },
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
                        if (_userTxnController.load.value == 0) {
                          if (_userTxnController.sortedUserTxn.isNotEmpty) {
                            return SingleChildScrollView(
                              child: Column(
                                children: [
                                  height5,
                                  ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        _userTxnController.sortedUserTxn.length,
                                    itemBuilder: (context, index) {
                                      return ListAnimation(
                                        position: index,
                                        itemCount: _userTxnController
                                            .sortedUserTxn.length,
                                        slideDirection:
                                            SlideDirection.fromBottom,
                                        animationController:
                                            _animationController,
                                        child: UserDetailCard(
                                          str: _userTxnController
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
                          } else if (_userTxnController.response.value ==
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
            ValueListenableBuilder<int>(
              valueListenable: isLoading,
              builder: (_, load, __) {
                return CircularLoader(load: load);
              },
            )
          ],
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TakeFloatingButton(
              callback: () async {
                final TransactionController _txnController = Get.find();
                _txnController.txnModel.value.number =
                    _data["number"].toString();

                isLoading.value = 1;
                await TxnOperation().operation(context, 1, mounted);
                isLoading.value = 0;
              },
            ),
            GaveFloatingButton(
              callback: () async {
                final TransactionController _txnController = Get.find();
                _txnController.txnModel.value.number =
                    _data["number"].toString();

                isLoading.value = 1;
                await TxnOperation().operation(context, 2, mounted);
                isLoading.value = 0;
              },
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
