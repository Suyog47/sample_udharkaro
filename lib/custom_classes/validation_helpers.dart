import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';

class ValidationHelpers {

  String onlyEngValidator(String val) {
    if (val.isEmpty) {
      return null;
    } else {
      final RegExp regExp = RegExp(r"^[a-zA-Z0-9\s$&+,:;=?@#|'<>.^*()%!-]+$");
      if(regExp.hasMatch(val)) {
        return null;
      }
      return LanguageController().getText(onlyEngReqTxt);
    }
  }

  String nameValidation(String val) {
    if (val.isEmpty) {
      return LanguageController().getText(fieldRequiredTxt);
    } else {
      final RegExp regExp = RegExp(r"^[a-zA-Z0-9\s$&+,:;=?@#|'<>.^*()%!-]+$");
      if (regExp.hasMatch(val)) {
        return null;
      }
      return LanguageController().getText(onlyEngReqTxt);
    }
  }

  String emailValidation(String val) {
    if (val.isEmpty) {
      return null;
    } else {
      final RegExp regExp1 = RegExp(
          r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
      final RegExp regExp2 = RegExp(r"^[a-zA-Z0-9\s$&+,:;=?@#|'<>.^*()%!-]+$");
      if (regExp1.hasMatch(val) && regExp2.hasMatch(val)) {
        return null;
      }
      return LanguageController().getText(validEmailTxt);
    }
  }

  String phoneValidation(String val) {
    if (val.length == 10 && int.parse(val[0]) >= 6) {
      return null;
    }
    return LanguageController().getText(validPhoneTxt);
  }

  String passwordValidation(String val) {
    if (val.isEmpty) {
      return LanguageController().getText(enterPassTxt);
    } else {
      if (val.length < 6 || val.length > 20) {
        return LanguageController().getText(validPassTxt);
      } else {
        return null;
      }
    }
  }

  String otpValidation(String val) {
    if (val.length == 6) {
      return null;
    }
    return LanguageController().getText(validOtpTxt);
  }

  String transactionValidation(String val) {
    if (val.isEmpty) {
      return LanguageController().getText(enterAmountTxt);
    } else {
      return null;
    }
  }

}
