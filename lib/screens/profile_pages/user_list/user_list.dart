import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/custom_classes/notification_click_check.dart';
import 'package:udhaarkaroapp/widgets/show_bottom_sheet.dart';
import 'package:udhaarkaroapp/widgets/widgets.dart';

class UsersList extends StatefulWidget {
  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList>
    with SingleTickerProviderStateMixin {
  final UserController _userController = Get.find();
  final UserListController _userListController = Get.find();
  final CommonController _commonController = Get.find();

  final RefreshController _refreshController = RefreshController();
  final ScrollController _scrollController = ScrollController();
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _userListController.load.value = 1;
    _userListController.getUserData(_userController.userModel.value.id);

    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    NotificationCheck().check(context);
  }

  Future _onRefresh() async {
    await _userListController.getUserData(_userController.userModel.value.id);
    _refreshController.refreshCompleted();
  }

  @override
  void dispose() {
    _animationController.dispose();
    Get.delete<ReportListController>();
    Get.delete<UserListController>();
    Get.delete<TransactionController>();
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
                    text: LanguageController().getText(userListHeaderTxt),),
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
                          _userListController.getSearchedUser(val.toString());
                        },
                      ),
                    ),
                    centerTitle: true,
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    SingleChildScrollView(
                      child: SizedBox(
                        height: displayHeight(context) * 0.7,
                        child: Scrollbar(
                          controller: _scrollController,
                          thickness: 7,
                          radius: const Radius.circular(20),
                          child: SmartRefresher(
                            controller: _refreshController,
                            onRefresh: _onRefresh,
                            header: const WaterDropMaterialHeader(),
                            child: Obx(() {
                              if (_userListController.load.value == 0) {
                                if (_userListController.userList.isNotEmpty) {
                                  return ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: _userListController.userList
                                        .length,
                                    itemBuilder: (context, index) {
                                      return ListAnimation(
                                        position: index,
                                        itemCount: _userListController.userList
                                            .length,
                                        slideDirection: SlideDirection
                                            .fromBottom,
                                        animationController: _animationController,
                                        child: InkWell(
                                          onTap: () {
                                            return ShowBottomSheet()
                                                .getUserBottomSheet(
                                                context,
                                                _userListController
                                                    .userList[index].name,
                                                _userListController
                                                    .userList[index].mobileNumber,
                                                _userListController
                                                    .userList[index].limit,
                                                _userListController
                                                    .userList[index].id,
                                                _userListController
                                                    .userList[index].reportStatus,
                                                _userListController
                                                    .userList[index].token,() async {
                                              _userListController.updateLoad.value = 1;
                                              await _userListController.getUserData(_userController.userModel.value.id);
                                              _userListController.updateLoad.value = 0;
                                            },);
                                          },
                                          child: UserListCard(
                                            str: _userListController
                                                .userList[index],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                } else if (_userListController.response.value ==
                                    "error") {
                                  return ErrorScreen(
                                    text:
                                    LanguageController().getText(errorTxt),
                                  );
                                } else {
                                  return NoDataScreen(
                                    text: LanguageController().getText(
                                        noUsersDataTxt,),
                                  );
                                }
                              } else {
                                return const Text("");
                              }
                            }),
                          ),
                        ),
                      ),
                    )
                  ]),
                ),
              ],
            ),
            Obx(
                  () =>
                  Center(
                    child: FoldingCubeLoader(
                      load: _userListController.load.value,
                      bgContainer: false,
                      color: (_commonController.dark.value)
                          ? whiteColor
                          : darkBlueColor,
                    ),
                  ),
            ),
            Obx(
                  () =>
                  CircularLoader(load: _userListController.updateLoad.value),
            ),
          ],
        ),
      ),
    );
  }
}
