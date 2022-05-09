import 'dart:convert';
import 'package:get/get.dart';
import 'package:udhaarkaroapp/api_calls/information.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/widgets/alerts.dart';

class InformationController extends GetxController {
  RxString privacyPolicy = "".obs;
  RxString aboutUs = "".obs;
  RxString response = "".obs;
  RxInt load = 0.obs;

  Future getInfo(String name) async {
    try {
      load.value = 1;
      await InformationApiCall().getInformation(name).then((value) {
        if (value != "error") {
          response.value = jsonDecode(value.toString())["info"].toString();
          if (name == "privacy policy") {
            privacyPolicy.value = response.value;
          } else {
            aboutUs.value = response.value;
          }
        } else {
          response.value = value.toString();
          Alert().failFlutterToast(LanguageController().getText(errorTxt));
        }
      });
    } finally {
      load.value = 0;
    }
  }
}
