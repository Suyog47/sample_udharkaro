import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/custom_classes/notification_click_check.dart';
import 'package:udhaarkaroapp/widgets/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicy extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers =
      {Factory(() => EagerGestureRecognizer())}.toSet();
  final InformationController _informationController = Get.find();
  final CommonController _commonController = Get.find();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    getData();
    NotificationCheck().check(context);
  }

  Future getData() async {
    if (_informationController.privacyPolicy.value == "" ||
        _informationController.response.value == "error") {
      await _informationController.getInfo("privacy policy");
    }
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<InformationController>();
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
                    text: LanguageController().getText(privacyPolicyTxt),),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Obx(
                      () {
                        return (_informationController.privacyPolicy.value == null ||
                                _informationController.privacyPolicy.value == "")
                            ? const Center(child: CircularLoader(load: 1))
                            : SizedBox(
                                height: displayHeight(context) * 0.9,
                                width: displayWidth(context),
                                child: WebView(
                                  initialUrl:
                                      _informationController.privacyPolicy.value,
                                  javascriptMode: JavascriptMode.unrestricted,
                                  gestureRecognizers: gestureRecognizers,
                                  onWebViewCreated:
                                      (WebViewController webViewController) {
                                    _controller.complete(webViewController);
                                  },
                                  gestureNavigationEnabled: true,
                                ),
                              );
                      },
                    )
                  ]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
