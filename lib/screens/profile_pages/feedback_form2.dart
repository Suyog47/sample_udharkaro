import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/custom_classes/notification_click_check.dart';
import 'package:udhaarkaroapp/custom_classes/validation_helpers.dart';
import 'package:udhaarkaroapp/widgets/widgets.dart';

class FeedbackForm2 extends StatefulWidget {
  @override
  _FeedbackForm2State createState() => _FeedbackForm2State();
}

class _FeedbackForm2State extends State<FeedbackForm2> {
  String msg = "";
  final FeedBackController _feedbackController = Get.find();
  final CommonController _commonController = Get.find();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    NotificationCheck().check(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            (!_commonController.dark.value) ? whiteColor : blackColor,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  NormalHeader(text: LanguageController().getText(feedbackFormTxt)),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 40,),
                    child: Column(
                      children: [
                        T18Dark(
                            txt:
                            LanguageController().getText(anythingElseTxt),),
                        height30,
                        Form(
                          key: _formKey,
                          child: TextFormField(
                            style: TextStyle(
                                fontSize: 17,
                                color: (_commonController.dark.value)
                                    ? whiteColor
                                    : blackColor,),
                            decoration: inputDecor2.copyWith(
                              hintText: LanguageController().getText(writeSomethingTxt),
                              hintStyle: TextStyle(
                                  color: (_commonController.dark.value)
                                      ? whiteColor
                                      : blackColor,),
                            ),
                            cursorColor: redColor,
                            validator: (val) {
                            return ValidationHelpers().onlyEngValidator(val);
                            },
                            onChanged: (val) => msg = val,
                            minLines: 10,
                            maxLines: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: SubmitButton(
                      formKey: _formKey,
                      width: 180,
                      text: LanguageController().getText(sendTxt),
                      color: darkBlueColor,
                      callback: () async {
                        _feedbackController.feedbackModel.value.feedback = msg;
                        await _feedbackController.addFeedback();
                        if (_feedbackController.response.value == "error") {
                          Alert().failFlutterToast(
                            LanguageController().getText(errorTxt),
                          );
                        } else {
                          if (!mounted) return;
                          Alert().successSweetAlert(
                            LanguageController().getText(feedbackSentTxt),
                            context,
                            () => Navigator.popUntil(
                              context,
                              ModalRoute.withName('/mainscreen'),
                            ),
                          );
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
            Obx(
              () => Center(
                child: CircularLoader(load: _feedbackController.load.value),
              ),
            )
          ],
        ),
      ),
    );
  }
}
