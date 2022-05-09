import 'dart:async';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controllers.dart';


class CommonController extends GetxController {

  //for darkTheme and lightTheme implementation
  RxBool dark = false.obs;
  //RxBool cirAn = false.obs;
  void switchTheme() => dark.value = !dark.value;

  Future setTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('dark_theme', dark.value);
  }

  Future getTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('dark_theme') == null) {
      dark.value = false;
    } else {
      dark.value = prefs.getBool('dark_theme');
    }
  }

  //for Language implementation
  RxBool hindi = false.obs;
  void switchLang() => hindi.value = !hindi.value;

  Future setLang() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('hindi', hindi.value);
  }

  Future getLang() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('hindi') == null) {
      hindi.value = false;
    } else {
      hindi.value = prefs.getBool('hindi');
    }
  }

  //to set Confirmation bottomsheet status
  Future setConfirmationBSstatus(bool status, String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('$id-bs_status', status);
  }

  Future getConfirmationBSstatus(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('$id-bs_status') == null) {
      return true;
    } else {
      return prefs.getBool('$id-bs_status');
    }
  }

  //for logout detection

  Future setLogoutStatus(String st) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("logout_status", st);
  }

  //for transaction session timer
  Timer tmr;
  final start = 120.obs;
  final tmrStatus = true.obs;
  Function callback;

  void startTmr(TransactionController _txnController, ConfirmationController _confirmationController) {
    const oneSec = Duration(seconds: 1);
    tmr = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (tmrStatus.value) {
          if (start.value == 0) {
           timer.cancel();
            _confirmationController.updateTransactionStatus(
              "failed",
              "session timeout",
              _txnController.txnModel.value.transactionId,
            );
           callback();
          } else {
            start.value--;
          }
        } else {
          timer.cancel();
        }
      },
    );
  }
}
