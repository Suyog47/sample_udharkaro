import 'package:get/get.dart';
import 'package:udhaarkaroapp/api_calls/feedback.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/models/feedback_model.dart';

class FeedBackController extends GetxController {
  Rx<FeedbackModel> feedbackModel = FeedbackModel().obs;
  RxString response = "".obs;
  RxInt load = 0.obs;
  final UserController _userController = Get.find();

  Future addFeedback() async {
    try {
      load.value = 1;
      feedbackModel.value.userId = _userController.userModel.value.id;
      feedbackModel.value.createdAt = DateTime.now().toString();
      await FeedbackApiCall().setFeedback(feedbackModel.value).then((value) {
        response.value = value.toString();
      });
    } finally {
      load.value = 0;
    }
  }
}
