import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/custom_classes/notification_click_check.dart';
import 'package:udhaarkaroapp/custom_classes/transaction_operation.dart';
import 'package:udhaarkaroapp/widgets/widgets.dart';

class QRCodeScanner extends StatefulWidget {
  final int type;

  const QRCodeScanner({this.type});

  @override
  _QRCodeScannerState createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends State<QRCodeScanner> {
  final TransactionController _txnController = Get.find();
  final UserController _userController = Get.find();
  final CommonController _commonController = Get.find();

  final _formKey = GlobalKey<FormState>();
  QRViewController controller;
  String num;

  @override
  void initState() {
    super.initState();
    NotificationCheck().check(context);
  }

  @override
  void dispose() {
    controller?.dispose();
    Get.delete<TransactionController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Dismissible(
        direction: DismissDirection.down,
        key: const Key('key'),
        onDismissed: (_) => Navigator.of(context).pop(),
        child: Scaffold(
          body: Stack(
            children: [
              SingleChildScrollView(
                reverse: true,
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 0.7 * displayHeight(context),
                          color: blackColor,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              width30,
                              H3Light(
                                  txt: LanguageController()
                                      .getText(qrPageHeader),),
                              height10,
                              QRScanner(
                                callback: (QRViewController controller) async {
                                  await TxnOperation()
                                      .operation(context, widget.type, mounted);
                                },
                              ),
                            ],
                          ),
                        ),
                        Obx(() {
                          return Form(
                            key: _formKey,
                            child: Container(
                              height: 0.275 * displayHeight(context),
                              color: (!_commonController.dark.value)
                                  ? whiteColor
                                  : black38,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
                                  height5,
                                  H4Dark(
                                      txt: LanguageController()
                                          .getText(qrOrTxt),),
                                  height5,
                                  PhoneTextField(
                                    suffixIcon: InkWell(
                                      onTap: () async {
                                        if (await FlutterContacts
                                            .requestPermission()) {
                                          final contact =
                                              await FlutterContacts
                                                  .openExternalPick();
                                          final number =
                                              contact.phones[0].number;
                                          _txnController
                                                  .txnModel.value.number =
                                              number
                                                  .split(' ')
                                                  .join()
                                                  .split('')
                                                  .reversed
                                                  .join()
                                                  .substring(0, 10)
                                                  .split('')
                                                  .reversed
                                                  .join();
                                          if (_txnController
                                                  .txnModel.value.number !=
                                              _userController.userModel
                                                  .value.mobileNumber) {
                                            if (!mounted) return;
                                            await TxnOperation().operation(
                                              context,
                                              widget.type,
                                              mounted,
                                            );
                                          } else {
                                            if (!mounted) return;
                                            Alert().snackBar(
                                              LanguageController().getText(
                                                  cantSelectOwnTxt,),
                                              context,
                                            );
                                          }
                                        }
                                      },
                                      child: (_commonController.dark.value)
                                          ? accountCircleOutlinedIconLight
                                          : accountCircleOutlinedIconDark,
                                    ),
                                    decoration: inputDecor2,
                                    label: LanguageController()
                                        .getText(enterPhoneTxt),
                                    callback: (value) {
                                      _txnController.txnModel.value.number =
                                          value.toString();
                                    },
                                  ),
                                  height10,
                                  height5,
                                  Center(
                                    child: SubmitButton(
                                      text: LanguageController()
                                          .getText(proceedBtnTxt),
                                      width: 200,
                                      height: 45,
                                      color: lightBlueColor,
                                      formKey: _formKey,
                                      callback: () async {
                                        if (_txnController
                                                .txnModel.value.number !=
                                            _userController
                                                .userModel.value.mobileNumber) {
                                          await TxnOperation().operation(
                                            context,
                                            widget.type,
                                            mounted,
                                          );
                                        } else {
                                          Alert().snackBar(
                                            LanguageController()
                                                .getText(cantWriteOwnTxt),
                                            context,
                                          );
                                        }
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              ),
              Obx(
                () => Center(
                  child: CircularLoader(
                    load: _txnController.load.value,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
