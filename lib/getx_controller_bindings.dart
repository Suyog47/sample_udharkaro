import 'package:get/get.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';

class GetXControllerBindings extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut(
          () => CommonController(),
      fenix: true,
    );

    Get.lazyPut(
          () => UserController(),
      fenix: true,
    );

    Get.lazyPut(
          () => LanguageController(),
      fenix: true,
    );


    Get.lazyPut(
          () => CategoryController(),
      fenix: true,
    );

    Get.lazyPut(
          () => ConfirmationController(),
      fenix: true,
    );

    Get.lazyPut(
          () => FeedBackController(),
      fenix: true,
    );

    Get.lazyPut(
          () => GetAllTransactionController(),
      fenix: true,
    );

    Get.lazyPut(
          () => GetGivenTransactionController(),
      fenix: true,
    );

    Get.lazyPut(
          () => GetTakenTransactionController(),
      fenix: true,
    );

    Get.lazyPut(
          () => InformationController(),
      fenix: true,
    );

    Get.lazyPut(
          () => ReportListController(),
      fenix: true,
    );

    Get.lazyPut(
          () => TransactionController(),
      fenix: true,
    );

    Get.lazyPut(
          () => UserDetailsController(),
      fenix: true,
    );

    Get.lazyPut(
          () => UserListController(),
      fenix: true,
    );
  }

}
