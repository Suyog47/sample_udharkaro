import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/custom_classes/navigations.dart';
import 'package:udhaarkaroapp/services/notification_services.dart';
import 'package:udhaarkaroapp/widgets/widgets.dart';

//UserListCard
//ReportListCard
//HomeCard
//UserDetails
//NotificationCard

final CommonController _commonController = Get.find();

class UserListCard extends StatelessWidget {
  final str;

  const UserListCard({
    @required this.str,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: InkWell(
        child: Column(
          children: [
            Card(
              color: (_commonController.dark.value) ? blackColor : whiteColor,
              elevation: 0,
              margin: const EdgeInsets.symmetric(vertical: 13),
              child: ListTile(
                leading: InkWell(
                  onTap: () {
                    if (str.pic != "") {
                      CustomDialog().profileDialog(str.pic.toString(), context);
                    }
                  },
                  child: Avatar(
                    radius: 25,
                    networkImg: str.pic.toString(),
                  ),
                ),
                title: Align(
                  alignment: Alignment.centerLeft,
                  child: T18Dark(
                    txt: str.name.toString(),
                  ),
                ),
              ),
            ),
            if (_commonController.dark.value) dividerLight else dividerDark,
          ],
        ),
      ),
    );
  }
}

class ReportedListCard extends StatelessWidget {
  final str;

  const ReportedListCard({
    @required this.str,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: (_commonController.dark.value) ? blackColor : whiteColor,
          elevation: 0,
          margin: const EdgeInsets.symmetric(vertical: 15),
          child: ListTile(
            leading: InkWell(
              onTap: () {
                if (str.pic != "") {
                  CustomDialog().profileDialog(str.pic.toString(), context);
                }
              },
              child: Avatar(
                radius: 25,
                networkImg: str.pic.toString(),
              ),
            ),
            title: Align(
              alignment: Alignment.centerLeft,
              child: T18Dark(
                txt: str.name.toString(),
              ),
            ),
          ),
        ),
        if (_commonController.dark.value) dividerLight else dividerDark,
      ],
    );
  }
}

class ReportCard extends StatelessWidget {
  final str;

  const ReportCard({
    @required this.str,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: (_commonController.dark.value) ? blackColor : whiteColor,
          elevation: 0,
          margin: const EdgeInsets.symmetric(vertical: 15),
          child: ListTile(
            leading: const Avatar(
              radius: 25,
            ),
            title: Align(
              alignment: Alignment.centerLeft,
              child: T16Dark(
                txt: LanguageController().getText(reportCardTxt),
              ),
            ),
            subtitle: Text(
              DateFormat('d MMM y, H:m')
                  .format(DateTime.parse(str.date.toString())),
              style: const TextStyle(color: greyColor, fontSize: 12),
            ),
          ),
        ),
        if (_commonController.dark.value) dividerLight else dividerDark,
      ],
    );
  }
}

class HomeCard extends StatelessWidget {
  final str;
  final int type;
  final int itemIndex;

  const HomeCard({@required this.str, @required this.type, @required this.itemIndex});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final UserDetailsController _userTxnController = Get.find();

        _userTxnController.yourId.value = str.id.toString();
        Navigate().toUserDetails(context, {
          "id": str.id,
          "pic": str.pic,
          "name": str.name,
          "number": str.number,
          "amount": str.amount.replaceAll("-", ""),
          "reportStatus": str.reportStatus,
          "fcmToken": str.fcmToken,
          "type": type,
          "heroTag": "profile$itemIndex",
          "index": itemIndex,
        });
      },
      child: Card(
        color: (!_commonController.dark.value) ? whiteColor : black38,
        margin: const EdgeInsets.only(
          left: 5,
          right: 5,
          top: 5,
          bottom: 10,
        ),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: ListTile(
            leading: InkWell(
              onTap: () {
                if (str.pic != "") {
                  CustomDialog().profileDialog(str.pic.toString(), context);
                }
              },
              child: Hero(
                tag: "profile$itemIndex",
                child: Avatar(
                  radius: 22,
                  networkImg: str.pic.toString(),
                ),
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                T18Dark(txt: str.name.toString()),
                height10,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LanguageController().getText(lastTxnTxt),
                      style: const TextStyle(color: greyColor, fontSize: 11),
                    ),
                    T12Dark(
                      txt: DateFormat('d MMM y, H:m')
                          .format(DateTime.parse(str.date.toString())),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    height5,
                    Visibility(
                      visible:
                          (str.deficitTaken.toString() == '0') ? false : true,
                      child: Row(
                        children: [
                          Text(
                            LanguageController().getText(deficitTakenTxt),
                            style:
                                const TextStyle(color: greyColor, fontSize: 12),
                          ),
                          width5,
                          Text(
                            "+${str.deficitTaken}",
                            style: const TextStyle(
                                color: greenColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible:
                          (str.deficitGiven.toString() == '0') ? false : true,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          children: [
                            Text(
                              LanguageController().getText(deficitGivenTxt),
                              style: const TextStyle(
                                  color: greyColor, fontSize: 12),
                            ),
                            width5,
                            Text(
                              "-${str.deficitGiven}",
                              style: const TextStyle(
                                  color: redColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            //subtitle:
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                T16Dark(txt: LanguageController().getText(rsTxt)),
                T28Dark(
                  txt: str.amount
                      .replaceAll("-", "")
                      .toString()
                      .replaceAllMapped(
                        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                        (Match m) => '${m[1]},',
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserDetailCard extends StatelessWidget {
  final str;
  final int itemIndex;
  final BuildContext context;
  final UserController _userController = Get.find();
  final UserDetailsController _userTxnController = Get.find();
  final GetTakenTransactionController _takenTxnController = Get.find();

  UserDetailCard({
    @required this.str,
    @required this.itemIndex,
    @required this.context,
  });

  Future handleClick(String val) async {
    final TransactionController _txnController = Get.find();

    if (val == LanguageController().getText(cancelTransTxt) ||
        val == LanguageController().getText(declineTxt)) {
      if (val == LanguageController().getText(declineTxt)) {
        CustomDialog().reasonForDenyDialog(
          context,
          str.txnId.toString(),
          str.amount.toString(),
          _userController.userModel.value.name,
          str.fcmToken.toString(),
          () {
            _userTxnController.yourId.value = str.id.toString();
            _userTxnController.getUserTxn();
          },
        );
      } else {
        await _txnController.updateTransactionRead(
          "failed",
          str.txnId.toString(),
          "",
          "cancelled by Operator",
          () {
            _userTxnController.yourId.value = str.id.toString();
            _userTxnController.getUserTxn();
            _takenTxnController.getTakenTransactionData();
          },
        );
        if (_txnController.response.value == "success") {
          NotificationService().sendNotify(
            "Transaction Cancelled",
            "${_userController.userModel.value.name} has cancelled the transaction of Rs ${str.amount}.",
            str.fcmToken.toString(),
          );
        } else {
          Alert().snackBar("Something went wrong", context);
        }
      }
    } else {
      await _txnController.updateTransactionRead(
        "success",
        str.txnId.toString(),
        "",
        "accepted by Receiver",
        () {
          _userTxnController.yourId.value = str.id.toString();
          _userTxnController.getUserTxn();
          _takenTxnController.getTakenTransactionData();
        },
      );
      if (_txnController.response.value == "success") {
        NotificationService().sendNotify(
          "Transaction Accepted",
          "${str.name} has accepted the transaction of Rs ${str.amount}.",
          str.fcmToken.toString(),
        );
      } else {
        Alert().snackBar("Something went wrong", context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final TransactionController _txnController = Get.find();

        _txnController.txnModel.value.pic = str.pic.toString();
        _txnController.txnModel.value.name = str.name.toString();
        _txnController.txnModel.value.amount = str.amount.toString();
        _txnController.txnModel.value.date = str.date.toString();
        _txnController.txnModel.value.transactionId =
            str.transactionId.toString();
        _txnController.txnModel.value.note = str.note.toString();
        _txnController.txnModel.value.status = str.status.toString();
        _txnController.txnModel.value.rejectReason =
            str.rejectReason.toString();

        (str.id == str.fromId)
            ? Navigate()
                .toTakenAmount(context, {"heroTag": 'profile$itemIndex', "to": "back"})
            : Navigate().toGivenAmount(
                context,
                {"heroTag": 'profile$itemIndex', "to": "back"},
              );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: (str.transRead == "false" || str.status == "rejected")
                ? redColor
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: Card(
          color: (!_commonController.dark.value) ? whiteColor : blackColor,
          elevation: 0,
          margin: const EdgeInsets.only(
            top: 5,
            bottom: 5,
          ),
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color:
                    (str.id != str.fromId) ? lightOrangeColor : lightBlueColor,
              ),
              child: (str.id != str.fromId)
                  ? Transform.rotate(angle: 3.142 / 4, child: upArrowWhiteIcon)
                  : Transform.rotate(
                      angle: 3.142 / 4, child: downArrowWhiteIcon),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                H4Dark(
                  txt: (str.id == str.fromId)
                      ? LanguageController().getText(homeTakenTxt)
                      : LanguageController().getText(homeGivenTxt),
                ),
                height5,
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat('d MMM y, H:m')
                      .format(DateTime.parse(str.date.toString())),
                  style: const TextStyle(color: greyColor, fontSize: 12),
                ),
                height5,
                Text(
                  "Operated by: ${(str.operatedBy == _userController.userModel.value.id) ? "You" : str.name.toString()}",
                  style: const TextStyle(color: greyColor, fontSize: 12),
                ),
                height2,
                if (str.status == "rejected")
                  const Text(
                    "Failed",
                    style: TextStyle(color: redColor, fontSize: 14),
                  )
                else
                  const SizedBox(),
              ],
            ),
            trailing: SizedBox(
              width: 110,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (str.id != str.fromId)
                    Text(
                      "- ${LanguageController().getText(rsTxt)} ${str.amount.replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                      style: minusPriceTextStyle,
                    )
                  else
                    Text(
                      "+ ${LanguageController().getText(rsTxt)} ${str.amount.replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                      style: plusPriceTextStyle,
                    ),
                  width2,
                  if (str.transRead == "false")
                    PopupMenuButton<String>(
                      color: (!_commonController.dark.value)
                          ? blackColor
                          : whiteColor,
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0)),),
                      onSelected: handleClick,
                      itemBuilder: (BuildContext context) {
                        if (str.operatedBy ==
                            _userController.userModel.value.id) {
                          return [LanguageController().getText(cancelTransTxt)]
                              .map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Center(
                                child: Text(
                                  choice,
                                  style: TextStyle(
                                    color: (_commonController.dark.value)
                                        ? blackColor
                                        : whiteColor,
                                  ),
                                ),
                              ),
                            );
                          }).toList();
                        } else {
                          return [
                            PopupMenuItem<String>(
                              value: LanguageController().getText(acceptTxt),
                              child: Center(
                                  child: Text(
                                      LanguageController().getText(acceptTxt)),),
                            ),
                            const PopupMenuDivider(),
                            PopupMenuItem<String>(
                              value: LanguageController().getText(declineTxt),
                              child: Center(
                                  child: Text(LanguageController()
                                      .getText(declineTxt)),),
                            ),
                          ];
                        }
                      },
                      child: Icon(
                        Icons.more_vert,
                        color: (_commonController.dark.value)
                            ? whiteColor
                            : blackColor,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final str;
  final int itemIndex;
  final BuildContext context;

  final UserController _userController = Get.find();
  final CommonController _commonController = Get.find();
  final GetAllTransactionController _getAllTxnController = Get.find();

  NotificationCard(
      {@required this.str, @required this.context, @required this.itemIndex,});

  Future handleClick(String val) async {
    final TransactionController _txnController = Get.find();

    if (val == LanguageController().getText(cancelTransTxt) ||
        val == LanguageController().getText(declineTxt)) {
      if (val == LanguageController().getText(declineTxt)) {
        CustomDialog().reasonForDenyDialog(
          context,
          str.txnId.toString(),
          str.amount.toString(),
          _userController.userModel.value.name,
          str.fcmToken.toString(),
          () {
            _getAllTxnController
                .allTransactionData(_userController.userModel.value.id);
          },
        );
      } else {
        await _txnController.updateTransactionRead(
          "failed",
          str.txnId.toString(),
          "",
          "cancelled by Operator",
          () {
            _getAllTxnController
                .allTransactionData(_userController.userModel.value.id);
          },
        );
        if (_txnController.response.value == "success") {
          NotificationService().sendNotify(
            "Transaction Cancelled",
            "${_userController.userModel.value.name} has cancelled the transaction of Rs ${str.amount}.",
            str.fcmToken.toString(),
          );
        } else {
          Alert().snackBar("Something went wrong", context);
        }
      }
    } else {
      await _txnController.updateTransactionRead(
        "success",
        str.txnId.toString(),
        "",
        "accepted by Receiver",
        () {
          _getAllTxnController
              .allTransactionData(_userController.userModel.value.id);
        },
      );
      if (_txnController.response.value == "success") {
        NotificationService().sendNotify(
          "Transaction Accepted",
          "${str.name} has accepted the transaction of Rs ${str.amount}.",
          str.fcmToken.toString(),
        );
      } else {
        Alert().snackBar("Something went wrong", context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final TransactionController _txnController = Get.find();

        _txnController.txnModel.value.pic = str.pic.toString();
        _txnController.txnModel.value.name = str.name.toString();
        _txnController.txnModel.value.amount = str.amount.toString();
        _txnController.txnModel.value.date = str.date.toString();
        _txnController.txnModel.value.transactionId =
            str.transactionId.toString();
        _txnController.txnModel.value.note = str.note.toString();
        _txnController.txnModel.value.status = str.status.toString();
        _txnController.txnModel.value.rejectReason =
            str.rejectReason.toString();

        (str.id == str.fromId)
            ? Navigate()
                .toTakenAmount(context, {"heroTag": 'profile$itemIndex', "to": "back"})
            : Navigate().toGivenAmount(
                context,
                {"heroTag": 'profile$itemIndex', "to": "back"},
              );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: (str.transRead == "false" || str.status == "rejected")
                ? redColor
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: Card(
          color: (_commonController.dark.value) ? blackColor : whiteColor,
          margin: const EdgeInsets.symmetric(
            vertical: 5,
          ),
          elevation: 0,
          child: ListTile(
            contentPadding: const EdgeInsets.only(left: 10.0, right: 5.0),
            leading: InkWell(
              onTap: () {
                if (str.pic != "") {
                  CustomDialog().profileDialog(str.pic.toString(), context);
                }
              },
              child: Hero(
                tag: "profile$itemIndex",
                child: Avatar(
                  radius: 25,
                  networkImg: str.pic.toString(),
                ),
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                T12Dark(
                  txt: (str.id == str.fromId)
                      ? LanguageController().getText(fromTxt)
                      : LanguageController().getText(toTxt),
                ),
                T18Dark(txt: str.name.toString()),
                height5,
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat('d MMM y, H:m')
                      .format(DateTime.parse(str.date.toString())),
                  style: const TextStyle(color: greyColor, fontSize: 12),
                ),
                height5,
                Text(
                  "Operated by: ${(str.operatedBy == _userController.userModel.value.id) ? "You" : str.name.toString()}",
                  style: const TextStyle(color: greyColor, fontSize: 12),
                ),
                height2,
                if (str.status == "rejected")
                  const Text(
                    "Failed",
                    style: TextStyle(color: redColor, fontSize: 14),
                  )
                else
                  const SizedBox(),
              ],
            ),
            trailing: SizedBox(
              width: 110,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (str.id != str.fromId)
                    Text(
                      "- ${LanguageController().getText(rsTxt)}${str.amount.replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                      style: minusPriceTextStyle,
                    )
                  else
                    Text(
                      "+ ${LanguageController().getText(rsTxt)}${str.amount.replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                      style: plusPriceTextStyle,
                    ),
                  width2,
                  if (str.transRead == "false")
                    PopupMenuButton<String>(
                      color: (!_commonController.dark.value)
                          ? blackColor
                          : whiteColor,
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0)),),
                      onSelected: handleClick,
                      itemBuilder: (BuildContext context) {
                        if (str.operatedBy ==
                            _userController.userModel.value.id) {
                          return [LanguageController().getText(cancelTransTxt)]
                              .map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Center(
                                child: Text(
                                  choice,
                                  style: TextStyle(
                                    color: (_commonController.dark.value)
                                        ? blackColor
                                        : whiteColor,
                                  ),
                                ),
                              ),
                            );
                          }).toList();
                        } else {
                          return [
                            PopupMenuItem<String>(
                              value: LanguageController().getText(acceptTxt),
                              child: Center(
                                child: Text(
                                  LanguageController().getText(acceptTxt),
                                  style: TextStyle(
                                    color: (_commonController.dark.value)
                                        ? blackColor
                                        : whiteColor,
                                  ),
                                ),
                              ),
                            ),
                            const PopupMenuDivider(),
                            PopupMenuItem<String>(
                              value: LanguageController().getText(declineTxt),
                              child: Center(
                                  child: Text(
                                      LanguageController().getText(declineTxt),
                                      style: TextStyle(
                                          color: (_commonController.dark.value)
                                              ? blackColor
                                              : whiteColor,),),),
                            ),
                          ];
                        }
                      },
                      child: Icon(
                        Icons.more_vert,
                        color: (_commonController.dark.value)
                            ? whiteColor
                            : blackColor,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
