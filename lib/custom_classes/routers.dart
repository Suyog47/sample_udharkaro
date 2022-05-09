import 'package:flutter/material.dart';
import 'package:udhaarkaroapp/custom_classes/page_transitions.dart';
import 'package:udhaarkaroapp/screens/notification/reports.dart';
import 'package:udhaarkaroapp/screens/profile_pages/account_details.dart';
import 'package:udhaarkaroapp/screens/profile_pages/reported_list.dart';
import 'package:udhaarkaroapp/screens/screens.dart';
import 'package:udhaarkaroapp/screens/splash/introduction_slider.dart';
import 'package:udhaarkaroapp/screens/splash/splash_screen.dart';

mixin Routers {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/intro':
        return CustomPageTransitions()
            .bottomToTopTransition(IntroductionSlider(), settings);
        break;

      case '/splash':
        return CustomPageTransitions()
            .bottomToTopTransition(SplashScreen(), settings);
        break;

      case '/signup':
        return CustomPageTransitions().fadeTransition(SignUp(), settings);
        break;

      case '/signup2':
        return CustomPageTransitions()
            .rightToLeftFadeTransition(Signup2(), settings);
        break;

      case '/login':
        return CustomPageTransitions().fadeTransition(Login(), settings);
        break;

      case '/forgotpassword':
        return CustomPageTransitions()
            .rightToLeftFadeTransition(ForgotPassword(), settings);
        break;

      case '/newpassword':
        return CustomPageTransitions()
            .rightToLeftFadeTransition(NewPassword(), settings);
        break;

      case '/verification':
        return CustomPageTransitions()
            .rightToLeftFadeTransition(Verification(), settings);
        break;

      case '/qrscanner':
        return CustomPageTransitions()
            .fadeTransition(const QRCodeScanner(), settings);
        break;

      case '/enteramount':
        return CustomPageTransitions()
            .topToBottomTransition(EnterAmount(), settings);
        break;

      case '/takeamountconfirmation':
        return CustomPageTransitions()
            .bottomToTopTransition(TakeAmountConfirmation(), settings);
        break;

      case '/giveamountconfirmation':
        return CustomPageTransitions()
            .bottomToTopTransition(GiveAmountConfirmation(), settings);
        break;

      case '/givenamountdetails':
        return CustomPageTransitions()
            .rightToLeftFadeTransition(GivenAmountDetails(), settings);
        break;

      case '/takenamountdetails':
        return CustomPageTransitions()
            .rightToLeftFadeTransition(TakenAmountDetails(), settings);
        break;

      case '/mainscreen':
        return CustomPageTransitions().fadeTransition(MainScreen(), settings);
        break;

      case '/qr':
        return CustomPageTransitions().fadeTransition(QRCode(), settings);
        break;

      case '/userdetails':
        return CustomPageTransitions().fadeTransition(UserDetails(), settings);
        break;

      case '/accountdetails':
        return CustomPageTransitions()
            .fadeTransition(AccountDetails(), settings);
        break;

      case '/editprofile':
        return CustomPageTransitions().fadeTransition(EditProfile(), settings);
        break;

      case '/passwordupdate':
        return CustomPageTransitions()
            .fadeTransition(PasswordUpdation(), settings);
        break;

      case '/privacypolicy':
        return CustomPageTransitions()
            .fadeTransition(PrivacyPolicy(), settings);
        break;

      case '/aboutus':
        return CustomPageTransitions().fadeTransition(AboutUs(), settings);
        break;

      case '/settings':
        return CustomPageTransitions().fadeTransition(Settings(), settings);
        break;

      case '/feedbackform':
        return CustomPageTransitions().fadeTransition(FeedbackForm(), settings);
        break;

      case '/feedbackform2':
        return CustomPageTransitions()
            .fadeTransition(FeedbackForm2(), settings);
        break;

      case '/userlist':
        return CustomPageTransitions().fadeTransition(UsersList(), settings);

      case '/usertransaction':
        return CustomPageTransitions().fadeTransition(const UserTransaction(), settings);

      case '/reportlist':
        return CustomPageTransitions().fadeTransition(ReportedList(), settings);

      case '/reports':
        return CustomPageTransitions().fadeTransition(Reports(), settings);

      default:
        return null;
    }
  }
}
