import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/custom_classes/navigations.dart';
import 'package:udhaarkaroapp/services/notification_services.dart';
import 'package:udhaarkaroapp/widgets/alerts.dart';
import 'package:udhaarkaroapp/widgets/texts.dart';
import 'package:wakelock/wakelock.dart';


class TakeAmountConfirmation extends StatefulWidget {
  @override
  _TakeAmountConfirmationState createState() => _TakeAmountConfirmationState();
}

class _TakeAmountConfirmationState extends State<TakeAmountConfirmation> with WidgetsBindingObserver {
  String reason = "";
  final TransactionController _txnController = Get.find();
  final UserController _userController = Get.find();
  final ConfirmationController _confirmationController = Get.find();
  final CommonController _commonController = Get.find();

  @override
  void initState() {
    super.initState();
    Wakelock.enable();
    _commonController.start.value = 120;
    _commonController.tmrStatus.value = true;
    _commonController.callback = () =>
        Alert().failSweetAlert(LanguageController().getText(transSessionOver), context, () {
          reason = "session timeout";
          Navigator.pop(context);
          Navigator.pop(context);
        });
    _commonController.startTmr(_txnController, _confirmationController);
    add();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) return;

    final isBackground = state == AppLifecycleState.paused;

    if (isBackground) {
      if (reason == "") {reason = "cancelled by Operator";}
      _confirmationController.updateTransactionStatus(
        "failed",
        reason,
        _txnController.txnModel.value.transactionId,
      );
      _commonController.tmrStatus.value = false;
    }
    else{
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    super.dispose();
    Wakelock.disable();
    if (reason == "") {reason = "cancelled by Operator";}
      reason = "cancelled by giver";
      _confirmationController.updateTransactionStatus(
        "failed",
        reason,
        _txnController.txnModel.value.transactionId,
      );
      _commonController.tmrStatus.value = false;
    _commonController.tmr.cancel();
    Get.delete<ConfirmationController>();
  }

  Future add() async {
    await _txnController.addTransaction(1);
    String msg;
    if (_txnController.response.value == "success") {
      msg =
      "${_userController.userModel.value.name} have taken Rs ${_txnController.txnModel.value.amount.replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} from you.";

      NotificationService().sendNotify(
        "Hello ${_txnController.txnModel.value.name}",
        msg,
        _txnController.txnModel.value.fcmToken,
      );
      if (!mounted) return;
      Navigate().toTakenAmount(context, {"heroTag": "", "to": "main"});
    } else {
      _commonController.tmrStatus.value = false;
      if (!mounted) return;
      Alert().failSweetAlert(
          LanguageController().getText(errorTxt), context, () {
        Navigator.pop(context);
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.delete<TransactionController>();
        return true;
      },
      child: Scaffold(
        body: Container(
          color: lightBlueColor,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                T22Light(txt: LanguageController().getText(takingAmountTxt)),
                height10,
                H2Light(txt: _txnController.txnModel.value.name),
                height10,
                T18Light(
                  txt: "${LanguageController().getText(amountTxt)} ${_txnController.txnModel.value.amount.replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                ),
                height10,
                T18Light(txt: LanguageController().getText(transSessionTxt)),
                height5,
                Obx(
                  () => T20Light(
                    txt: "${_commonController.start.value} ${LanguageController().getText(secTxt)}",
                  ),
                ),
                height60,
                Obx(
                  () => (_txnController.status.value == "success")
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 250,
                          child: const FlareActor(
                            "assets/flares/success_green.flr",
                            animation: "success",
                          ),
                        )
                      : SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 250,
                          child: const FlareActor(
                            "assets/flares/loading.flr",
                            animation: "loading",
                          ),
                        ),
                ),
                height10,
                T16Light(txt: LanguageController().getText(dontCloseAppTxt)),
                height10,
                if (_txnController.status.value == "success")
                  T16Light(txt: LanguageController().getText(successMsgTxt))
                else
                  (_txnController.status.value == "failed" ||
                          _commonController.start.value == 0)
                      ? T16Light(txt: LanguageController().getText(failedMsgTxt))
                      : (_txnController.status.value == "error")
                          ? T16Light(
                              txt: LanguageController().getText(errorTxt),
                            )
                          : T16Light(
                              txt: LanguageController().getText(waitingMsgTxt),
                            )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
