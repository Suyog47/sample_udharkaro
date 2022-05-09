import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/custom_classes/navigations.dart';
import 'package:udhaarkaroapp/custom_classes/notification_click_check.dart';
import 'package:udhaarkaroapp/custom_classes/validation_helpers.dart';
import 'package:udhaarkaroapp/widgets/widgets.dart';

class EnterAmount extends StatefulWidget {
  @override
  _EnterAmountState createState() => _EnterAmountState();
}

class _EnterAmountState extends State<EnterAmount> {
  Map _data = {};
  final TransactionController _txnController = Get.find();
  final CommonController _commonController = Get.find();

  @override
  void initState() {
    super.initState();
    NotificationCheck().check(context);
  }

  @override
  void dispose() {
    Get.delete<TransactionController>();
    super.dispose();
  }

  void submit() {
    if (_data["type"] == 1) {
      if (int.parse(_txnController.txnModel.value.limit) >
          0 &&
          int.parse(_txnController.txnModel.value.amount) >
              int.parse(
                _txnController.txnModel.value.limit,
              )) {
        Alert().snackBar(
          LanguageController().getText(cantEnterAmountTxt),
          context,
        );
      } else {
        Navigate().toTakeAmountConfirmation(context);
      }
    } else {
      Navigate().toGiveAmountConfirmation(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    _data = ModalRoute.of(context).settings.arguments as Map;

    _txnController.txnModel.value.amount = "";
    _txnController.txnModel.value.note = "";

    return SafeArea(
      child: Scaffold(
        backgroundColor:
            (!_commonController.dark.value) ? whiteColor : blackColor,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: (_commonController.dark.value)
                        ? backIconLight
                        : backIconDark,
                  ),
                ),
                height30,
                InkWell(
                  onTap: () {
                    if (_txnController.txnModel.value.pic != "") {
                      CustomDialog().profileDialog(
                        _txnController.txnModel.value.pic,
                        context,
                      );
                    }
                  },
                  child: Avatar(
                    radius: 35,
                    networkImg: _txnController.txnModel.value.pic ?? "",
                  ),
                ),
                height10,
                height10,
                H4Dark(txt: (_data["type"] == 1) ? LanguageController().getText(takingFromTxt) : LanguageController().getText(givingToTxt)),
                H3Dark(txt: _txnController.txnModel.value.name),
                height5,
                if (_data["type"] == 1)
                  T16Dark(
                    txt: (int.parse(_txnController.txnModel.value.limit) > 0)
                        ? "${LanguageController().getText(transLimitTxt)} ${_txnController.txnModel.value.limit}"
                        : LanguageController().getText(noTransLimitTxt),
                  )
                else
                  const Text(""),
                height60,
                SizedBox(
                  width: 225,
                  child: TextFormField(
                    decoration: (!_commonController.dark.value)
                        ? inputDecor2.copyWith(
                            fillColor: whiteColor,
                            labelText: LanguageController().getText(rsTxt),
                            labelStyle: t26_Dark,
                          )
                        : inputDecor2.copyWith(
                            fillColor: blackColor,
                            labelText: LanguageController().getText(rsTxt),
                            labelStyle: t26_Light,
                          ),
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(7)
                    ],
                    keyboardType: TextInputType.number,
                    style: (_commonController.dark.value) ? h1_Light : h1_Dark,
                    onChanged: (val) {
                      _txnController.txnModel.value.amount = val;
                    },
                  ),
                ),
                height30,
                SizedBox(
                  width: 220,
                  height: 80,
                  child: TextFormField(
                    style: (_commonController.dark.value) ? t20_Light : t20_Dark,
                    maxLines: 4,
                    textAlignVertical: TextAlignVertical.top,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: LanguageController().getText(addDescTxt),
                      hintStyle: TextStyle(
                        color: (_commonController.dark.value)
                            ? whiteColor
                            : blackColor,
                      ),
                    ),
                    onChanged: (value) =>
                        _txnController.txnModel.value.note = value,
                    validator: (val){
                      return ValidationHelpers().onlyEngValidator(val);
                    },
                  ),
                ),
                height30,
                height10,
                InkWell(
                  onTap: () {
                    if (_txnController.txnModel.value.amount == "") {
                      Alert().snackBar(LanguageController().getText(enterAmountTxt), context);
                    } else {
                      if (_txnController.txnModel.value.note.isEmpty) {
                        submit();
                      } else {
                        final RegExp regExp = RegExp(r"^[a-zA-Z0-9\s$&+,:;=?@#|'<>.^*()%!-]+$");
                        if(regExp.hasMatch(_txnController.txnModel.value.note)) {
                          submit();
                        }
                        Alert().snackBar(LanguageController().getText(onlyEngReqTxt), context);
                      }
                      }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 15,
                    ),
                    decoration: BoxDecoration(
                      color: lightBlueColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: arrowForwardIconLight,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
