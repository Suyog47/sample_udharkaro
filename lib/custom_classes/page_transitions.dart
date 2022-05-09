import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class CustomPageTransitions {
  PageTransition bottomToTopTransition(Widget page, RouteSettings settings) {
    return PageTransition(
      child: page,
      type: PageTransitionType.bottomToTop,
      duration: const Duration(milliseconds: 100),
      reverseDuration: const Duration(milliseconds: 300),
      settings: settings,
    );
  }

  PageTransition topToBottomTransition(Widget page, RouteSettings settings) {
    return PageTransition(
      child: page,
      type: PageTransitionType.topToBottom,
      duration: const Duration(milliseconds: 300),
      settings: settings,
    );
  }

  PageTransition sizeTransition(Widget page, RouteSettings settings) {
    return PageTransition(
      child: page,
      type: PageTransitionType.size,
      duration: const Duration(milliseconds: 400),
      settings: settings,
      curve: Curves.fastOutSlowIn,
      alignment: Alignment.center,
    );
  }

  PageTransition fadeTransition(Widget page, RouteSettings settings) {
    return PageTransition(
      child: page,
      type: PageTransitionType.fade,
      duration: const Duration(milliseconds: 400),
      reverseDuration: const Duration(milliseconds: 400),
      settings: settings,
    );
  }

  PageTransition rightToLeftFadeTransition(
    Widget page,
    RouteSettings settings,
  ) {
    return PageTransition(
      child: page,
      type: PageTransitionType.rightToLeftWithFade,
      duration: const Duration(milliseconds: 600),
      reverseDuration: const Duration(milliseconds: 600),
      settings: settings,
      alignment: Alignment.center,
    );
  }
}
