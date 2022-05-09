import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/custom_classes/navigations.dart';
import 'package:udhaarkaroapp/custom_classes/transaction_operation.dart';
import 'package:udhaarkaroapp/services/notification_services.dart';
import 'package:udhaarkaroapp/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class UserListBottomSheet extends StatefulWidget {

  final String name;
  final String number;
  final String amount;
  final String toId;
  final String fromId;
  final String status;
  final String token;
  final Function callback;

  const UserListBottomSheet(
      {this.name,
      this.number,
      this.amount,
      this.toId,
      this.fromId,
      this.status,
      this.token,
      this.callback,});

  @override
  _UserListBottomSheetState createState() => _UserListBottomSheetState();
}

class _UserListBottomSheetState extends State<UserListBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  String amt;
  String action;

  final UserListController _userListController = Get.find();
  final TransactionController _txnController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              height10,
              H4Dark(txt: LanguageController().getText(userSheetHeaderTxt)),
              H4Dark(txt: widget.name),
              height10,
              height10,

              Form(
                key: _formKey,
                child: TransactionTextField(
                  value: (widget.amount == "null") ? '0' : widget.amount,
                  label: LanguageController().getText(userSheetAmountTxt),
                  decoration: inputDecor2,
                  callback: (val) {
                    amt = val.toString();
                  },
                ),
              ),

              height10,

              SubmitButton(
                text: LanguageController().getText(updateBtnTxt),
                width: 150,
                height: 45,
                color: lightBlueColor,
                formKey: _formKey,
                callback: () async {
                  Navigator.pop(context);
                  if (widget.amount != "null" && amt != '0') {
                    amt = amt ?? widget.amount;
                    action = "update";
                  } else if (widget.amount != "null" && amt == '0') {
                    action = "delete";
                  } else {
                    action = "insert";
                  }

                  await _userListController.insertUserLimit(
                      widget.fromId, widget.toId, amt, action,);

                  if (_userListController.response.value == "error") {
                    Alert().failFlutterToast(
                      LanguageController().getText(errorTxt),);
                  } else {
                    Alert().successFlutterToast(LanguageController().getText(transLimitUpdateTxt));
                    widget.callback();
                  }
                },
              ),
              height10,
              height5,

              dividerGrey,

              height10,
              height5,

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TakeFloatingButton(
                    callback: () async {
                      Navigator.pop(context);
                      _txnController.txnModel.value.number = widget.number;
                      await TxnOperation().operation(context, 1, mounted);
                    },
                  ),
                  GaveFloatingButton(
                    callback: () async {
                      Navigator.pop(context);
                      _txnController.txnModel.value.number = widget.number;
                      await TxnOperation().operation(context, 2, mounted);
                    },
                  )
                ],
              ),

              height10,
              height5,

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Button(
                    height: displayHeight(context) * 0.07,
                    width: displayWidth(context) * 0.45,
                    color: widget.status == "reported" ? Colors.red[800] : redColor,
                    text: widget.status == "reported" ? LanguageController().getText(userSheetReportedTxt) : LanguageController().getText(userSheetReportTxt),
                    textStyle: t18_Light,
                    callback: () async {
                      final ReportListController _reportListController = Get.find();
                      final String name = widget.name;
                      final String token = widget.token;

                      if (widget.status != "reported") {
                        Navigator.pop(context);
                        await _reportListController.addReport(
                          widget.fromId,
                          widget.toId,
                        );
                        if (_reportListController.response.value == "error" ||
                            _reportListController.response.value ==
                                "not inserted") {
                          Alert().failFlutterToast(LanguageController().getText(operationFailedTxt));
                        } else {
                          NotificationService().sendNotify("Reported",
                              "You have been reported by a user", token,);
                          Alert().failFlutterToast(
                            "${LanguageController().getText(userSheetReportedTxt)} $name",
                          );
                        }
                      }
                    },
                  ),
                  Button(
                    height: displayHeight(context) * 0.07,
                    width: displayWidth(context) * 0.45,
                    color: darkBlueColor,
                    text: "Transactions",
                    callback: () {
                      Navigator.pop(context);
                      final UserDetailsController _userTxnController = Get.find();
                      _userTxnController.yourId.value = widget.toId;

                      Navigate().toUserTransaction(
                          context, {
                        "name": widget.name,
                      });
                    },
                  ),
                ],
              ),
              height10,
            ],
          ),
        ),
        Obx(() => CircularLoader(
              load: _txnController.load.value,
              color: redColor,
              bgContainer: false,
            ),),
      ],
    );
  }
}

class ShareBottomSheet extends StatefulWidget {
  final String name;
  final String number;
  final String amount;

  const ShareBottomSheet({this.name, this.number, this.amount});

  @override
  _ShareBottomSheetState createState() =>
      _ShareBottomSheetState();
}

class _ShareBottomSheetState extends State<ShareBottomSheet> {
  final UserController _userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        height10,
        H4Dark(txt: LanguageController().getText(sendReminderBottomSheetTxt)),
        H4Dark(txt: widget.name),
        height10,
        height10,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () async {
                  await launch(
                  "https://wa.me/91${widget.number}?text=${LanguageController().getText(rsTxt)}${widget.amount} - ${LanguageController().getText(reminderMsgTxt)} ${_userController.userModel.value.name} - ${LanguageController().getText(appName)}.",);
                },
                child: Column(
                  children: [
                    const Image(image: AssetImage("assets/images/whatsappicon.png"), height: 70, width: 70,),
                    height5,
                    T16Dark(txt: LanguageController().getText(whatsappTxt)),
                  ],
                ),
              ),

              InkWell(
                onTap: () async {
                  await launch(
                      "sms: +91${widget.number}?body=${LanguageController().getText(rsTxt)}${widget.amount} - ${LanguageController().getText(reminderMsgTxt)} ${_userController.userModel.value.name} - ${LanguageController().getText(appName)}.",);
                },
                child: Column(
                  children: [
                    const Image(image: AssetImage("assets/images/smsicon.png"), height: 70, width: 70,),
                    height5,
                    T16Dark(txt: LanguageController().getText(smsTxt)),
                  ],
                ),
              )
            ],
          ),
        )
    ],
    );
  }
}
