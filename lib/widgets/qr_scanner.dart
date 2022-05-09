import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';


class QRScanner extends StatefulWidget {
  final Function callback;

  const QRScanner({@required this.callback});

  @override
  _QRScannerState createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode result;
  QRViewController controller;
  final TransactionController _txnController = Get.find();
  final UserController _userController = Get.find();

  ValueNotifier<bool> flashNotifier = ValueNotifier(false);
  ValueNotifier<String> msgNotifier = ValueNotifier("");


  @override
  void initState() {
    super.initState();
    msgNotifier.value =  LanguageController().getText(qrSubTxt);
  }

  @override
  void dispose() {
    super.dispose();
    msgNotifier.value =  LanguageController().getText(qrSubTxt);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 0.40 * displayHeight(context),
          width: 0.70 * displayHeight(context),
          child: QRView(
            key: qrKey,
            overlay: QrScannerOverlayShape(
              borderRadius: 10,
              borderColor: lightOrangeColor,
              borderWidth: 10,
              borderLength: 30,
            ),
            onQRViewCreated: _onQRViewCreated,
          ),
        ),
        height10,
       Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ValueListenableBuilder<bool>(
                valueListenable: flashNotifier,
                builder: (_, flash, __){
                  return InkWell(
                    onTap: () {
                      _toggleFlash(controller);
                    },
                    child: flash
                        ? flashOnIcon
                        : flashOffIcon,
                  );
                },
              )
            ],
          ),
        height10,
       ValueListenableBuilder(
         valueListenable: msgNotifier,
         builder: (_, msg, __){
           return Text(
             msg.toString(),
             style: const TextStyle(color: lightOrangeColor),
             softWrap: true,
             textAlign: TextAlign.center,
           );
       },
       ),
      ],
    );
  }

  void _toggleFlash(QRViewController controller) {
    this.controller = controller;
    controller.toggleFlash();
    flashNotifier.value = !flashNotifier.value;
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return int.parse(s) != null;
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (scanData != null) {
        if (scanData.code.length == 10 &&
            isNumeric(scanData.code) &&
            int.parse(scanData.code[0]) >= 6) {
          if (scanData.code != _userController.userModel.value.mobileNumber) {
            controller.pauseCamera();
            _txnController.txnModel.value.number = scanData.code;
            widget.callback(controller);
          } else {
            msgNotifier.value =
                LanguageController().getText(qrOwnPhoneTxt);
          }
        } else {
          msgNotifier.value = LanguageController().getText(qrInvalidTxt);
        }
      }
    });
  }
}
