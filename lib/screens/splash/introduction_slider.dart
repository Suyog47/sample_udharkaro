import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/custom_classes/navigations.dart';
import 'package:udhaarkaroapp/widgets/texts.dart';

class IntroductionSlider extends StatefulWidget {

  @override
  State<IntroductionSlider> createState() => _IntroductionSliderState();
}

class _IntroductionSliderState extends State<IntroductionSlider> {
  List<Slide> intoSlides = [];
  final CommonController _commonController = Get.find();
  @override
  void initState() {
    super.initState();
    intoSlides.add(
      Slide(
        title:
        LanguageController().getText(introHeader1Txt),
        maxLineTitle: 2,
        styleTitle: TextStyle(
          fontSize: 40,
          fontFamily: "Lobster",
          color: whiteColor,
          fontWeight: FontWeight.bold,
          fontStyle: (_commonController.hindi.value)
              ? FontStyle.italic
              : FontStyle.normal,
        ),
        description:
        LanguageController().getText(introSub1Txt),
        styleDescription: const TextStyle(
          fontSize: 16,
          color: whiteColor,
          fontStyle: FontStyle.italic,
        ),
        marginDescription:
        const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 20.0),
        centerWidget: const Image(
          height: 240,
          width: 200,
          image: AssetImage("assets/images/introslide1.png"),),
        backgroundColor: introBlueColor1,
        directionColorBegin: Alignment.topLeft,
        directionColorEnd: Alignment.bottomRight,
        onCenterItemPress: () {},
      ),
    );

    intoSlides.add(
      Slide(
        title:
        LanguageController().getText(introHeader2Txt),
        maxLineTitle: 3,
        styleTitle: TextStyle(
          fontSize: 30,
          fontFamily: "Lobster",
          color: blackColor,
          fontWeight: FontWeight.bold,
          fontStyle: (_commonController.hindi.value)
              ? FontStyle.italic
              : FontStyle.normal,
        ),
        centerWidget: const Image(
          height: 240,
          width: 200,
          image: AssetImage("assets/images/introslide2.png"),),
        description:
        LanguageController().getText(introSub2Txt),
        styleDescription: const TextStyle(
          fontSize: 16,
          color: blackColor,
          fontStyle: FontStyle.italic,
        ),
        marginDescription:
        const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 20.0),
        backgroundColor: whiteColor,
        directionColorBegin: Alignment.topLeft,
        directionColorEnd: Alignment.bottomRight,
        onCenterItemPress: () {},
      ),
    );

    intoSlides.add(
      Slide(
        title:
        LanguageController().getText(introHeader3Txt),
        maxLineTitle: 3,
        styleTitle: TextStyle(
          fontSize: 30,
          fontFamily: "Lobster",
          color: whiteColor,
          fontWeight: FontWeight.bold,
          fontStyle: (_commonController.hindi.value)
              ? FontStyle.italic
              : FontStyle.normal,
        ),
        description:
        LanguageController().getText(introSub3Txt),
        styleDescription: const TextStyle(
          fontSize: 16,
          color: whiteColor,
          fontStyle: FontStyle.italic,
        ),
        marginDescription:
        const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 20.0),
        centerWidget: const Image(
          height: 240,
          width: 200,
          image: AssetImage("assets/images/introslide3.png"),),
        backgroundColor: introBlueColor2,
        directionColorBegin: Alignment.topLeft,
        directionColorEnd: Alignment.bottomRight,
        onCenterItemPress: () {},
      ),
    );

    intoSlides.add(
      Slide(
        title:
        LanguageController().getText(introHeader4Txt),
        maxLineTitle: 2,
        styleTitle: TextStyle(
          fontSize: 40,
          fontFamily: "Lobster",
          color: blackColor,
          fontWeight: FontWeight.bold,
          fontStyle: (_commonController.hindi.value)
              ? FontStyle.italic
              : FontStyle.normal,
        ),
        description:
        LanguageController().getText(introSub4Txt),
        styleDescription: const TextStyle(
          fontSize: 16,
          color: blackColor,
          fontStyle: FontStyle.italic,
        ),
        marginDescription:
        const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 20.0),
        centerWidget: const Image(
          height: 240,
          width: 200,
          image: AssetImage("assets/images/introslide4.png"),),
        backgroundColor: whiteColor,
        directionColorBegin: Alignment.topLeft,
        directionColorEnd: Alignment.bottomRight,
        onCenterItemPress: () {},
      ),
    );
  }

  void onDonePress() {
   Navigate().toLogin(context);
  }

  Widget renderNextBtn() {
    return T16Light(txt: LanguageController().getText(nextBtnTxt),);
  }

  Widget renderDoneBtn() {
    return T16Light(txt: LanguageController().getText(doneBtnTxt),);
  }

  Widget renderSkipBtn() {
    return T16Light(txt: LanguageController().getText(skipBtnTxt),);
  }

  ButtonStyle myButtonStyle1() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(const StadiumBorder()),
      backgroundColor: MaterialStateProperty.all<Color>(lightOrangeColor),
    );
  }

  ButtonStyle myButtonStyle2() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(const StadiumBorder()),
      backgroundColor: MaterialStateProperty.all<Color>(lightBlueColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      slides: intoSlides,

      renderSkipBtn: renderSkipBtn(),
      onSkipPress: onDonePress,
      skipButtonStyle: myButtonStyle1(),

      renderNextBtn: renderNextBtn(),
      nextButtonStyle: myButtonStyle1(),

      renderDoneBtn: renderDoneBtn(),
      onDonePress: onDonePress,
      doneButtonStyle: myButtonStyle2(),

      colorDot: greyColor,
      colorActiveDot: lightBlueColor,
      sizeDot: 10.0,
    );
  }
}
