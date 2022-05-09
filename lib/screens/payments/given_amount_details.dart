import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/custom_classes/notification_click_check.dart';
import 'package:udhaarkaroapp/widgets/widgets.dart';

class GivenAmountDetails extends StatefulWidget {
  @override
  _GivenAmountDetailsState createState() => _GivenAmountDetailsState();
}

class _GivenAmountDetailsState extends State<GivenAmountDetails> {
  final TransactionController _txnController = Get.find();
  final CommonController _commonController = Get.find();
 // BannerAd ad;
  Map data = {};

  // void setAd() {
  //   ad = BannerAd(
  //     adUnitId: "ca-app-pub-9998862566272453/4060229350",
  //     request: const AdRequest(),
  //     size: AdSize.banner,
  //   );
  //
  //   ad.load();
  // }

  @override
  void initState() {
    super.initState();
    //setAd();
    NotificationCheck().check(context);
  }

  @override
  void dispose() {
   // ad?.dispose();
    Get.delete<TransactionController>();
    Get.delete<ConfirmationController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments as Map;

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          if(data["to"] == "main") {
            Navigator.of(context)
                .popUntil(ModalRoute.withName("/mainscreen"));
          }
          else{
            Navigator.pop(context);
          }
          return true;
        },
        child: Scaffold(
          backgroundColor:
              (!_commonController.dark.value) ? whiteColor : blackColor,
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox(
                height: displayHeight(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      decoration: const BoxDecoration(
                        color: lightOrangeColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              onTap: () {
                                if(data["to"] == "main") {
                                  Navigator.of(context)
                                      .popUntil(ModalRoute.withName("/mainscreen"));
                                }
                                else{
                                  Navigator.pop(context);
                                }
                              },
                              child: backIconDark,
                            ),
                          ),
                          Center(
                            child: InkWell(
                              onTap: () {
                                if (_txnController.txnModel.value.pic != "") {
                                  CustomDialog().profileDialog(
                                    _txnController.txnModel.value.pic,
                                    context,
                                  );
                                }
                              },
                              child: Hero(
                                tag: data["heroTag"] ?? "",
                                child: Avatar(
                                  radius: 40,
                                  networkImg: _txnController.txnModel.value.pic,
                                ),
                              ),
                            ),
                          ),
                          height10,
                          height5,
                          Center(child: T16Light(txt: LanguageController().getText(receiptGivenHeaderTxt))),
                          height5,
                          Center(
                            child: H3Light(
                              txt: _txnController.txnModel.value.name,
                            ),
                          ),
                          height5,
                        ],
                      ),
                    ),
                    Flexible(
                      child: SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20,),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              height5,
                              AmountDetailsText(txt: LanguageController().getText(receiptPaidTxt),),
                              Row(
                                children: [
                                  const T20Dark(txt: "₹"),
                                  H4Dark(
                                    txt: _txnController.txnModel.value.amount.replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},'),
                                  ),
                                ],
                              ),
                              height10,
                              height10,
                              AmountDetailsText(txt: LanguageController().getText(receiptDateTxt),),
                              T18Dark(
                                txt: DateFormat('d MMM y, H:m').format(
                                  DateTime.parse(
                                    _txnController.txnModel.value.date,
                                  ),
                                ),
                              ),
                              height10,
                              height10,
                              AmountDetailsText(txt: LanguageController().getText(receiptTransIdTxt),),
                              T18Dark(
                                txt: _txnController.txnModel.value.transactionId,
                              ),

                              if (_txnController.txnModel.value.note == "")
                                const SizedBox()
                              else
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    height10,
                                    height10,
                                    AmountDetailsText(txt: LanguageController().getText(receiptNoteTxt),),
                                    T18Dark(txt: _txnController.txnModel.value.note),
                                  ],
                                ),

                              if (_txnController.txnModel.value.status != "rejected")
                                const SizedBox()
                              else
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    height10,
                                    height10,
                                    AmountDetailsText(txt: LanguageController().getText(statusTxt),),
                                    T18Dark(txt: LanguageController().getText(failedTxt)),
                                    height10,
                                    height10,
                                    AmountDetailsText(txt: LanguageController().getText(reasonTxt),),
                                    T18Dark(txt: _txnController.txnModel.value.rejectReason),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Container(
              //   width: ad.size.width.toDouble(),
              //   height: ad.size.height.toDouble(),
              //   alignment: Alignment.center,
              //   child: AdWidget(
              //     ad: ad,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
