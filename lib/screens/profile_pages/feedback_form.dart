import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/custom_classes/navigations.dart';
import 'package:udhaarkaroapp/custom_classes/notification_click_check.dart';
import 'package:udhaarkaroapp/widgets/widgets.dart';

class FeedbackForm extends StatefulWidget {
  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final FeedBackController _feedbackController = Get.find();
  final CommonController _commonController = Get.find();

  ValueNotifier<String> radioNotifier = ValueNotifier("Somewhat");

  final List _str = [
    LanguageController().getText(mostLikelyTxt),
    LanguageController().getText(moreLikelyTxt),
    LanguageController().getText(somewhatTxt),
    LanguageController().getText(lessLikelyTxt),
    LanguageController().getText(notLikelyTxt),
  ];

  double _rate = 3.0;

  @override
  void initState() {
    super.initState();
    NotificationCheck().check(context);
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<FeedBackController>();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            (!_commonController.dark.value) ? whiteColor : blackColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              NormalHeader(text: LanguageController().getText(feedbackFormTxt)),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        T20Dark(
                            txt: LanguageController().getText(ratingTxt),),
                        height10,
                        height10,
                        RatingBar.builder(
                          initialRating: _rate,
                          allowHalfRating: true,
                          minRating: 1,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 5.0),
                          itemBuilder: (context, _) => starIcon,
                          unratedColor: (_commonController.dark.value)
                              ? whiteColor
                              : blackColor,
                          onRatingUpdate: (rating) {
                            _rate = rating;
                          },
                        ),
                      ],
                    ),
                    height60,
                    Column(
                      children: [
                        T20Dark(
                            txt:
                            LanguageController().getText(suggestionTxt),),
                        height10,
                        height10,
                        ValueListenableBuilder<String>(
                          valueListenable: radioNotifier,
                          builder: (_, radio, __){
                            return RadioButton(
                              str: _str,
                              callback: (value) {
                                setState(() {
                                  radioNotifier.value = value.toString();
                                });
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    height10,
                    height10,
                    Align(
                      alignment: Alignment.centerRight,
                      child: Button(
                        text: LanguageController().getText(nextBtnTxt),
                        height: 40,
                        color: darkBlueColor,
                        callback: () {
                          _feedbackController.feedbackModel.value.rating =
                              _rate.toString();
                          _feedbackController
                              .feedbackModel.value.recommendation = radioNotifier.value;
                          Navigate().toFeedback2(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
