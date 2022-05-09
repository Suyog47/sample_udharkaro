import 'package:get/get.dart';
import 'package:translator/translator.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';

class LanguageController{
  GoogleTranslator translator = GoogleTranslator();
  final CommonController _commonController = Get.find();

   String getText(List msg) {
     final bool hindi = _commonController.hindi.value;
    if(hindi) {
      return msg[1].toString();
    }
    else{
      return msg[0].toString();
    }
  }

  Future<String> getTranslatedText(String txt) async {
    final bool hindi = _commonController.hindi.value;
    if(hindi) {
      final cText = await translator.translate(txt, from: 'en', to: 'hi');
      return cText.toString();
    }
    else {
      return txt;
    }
  }
}
