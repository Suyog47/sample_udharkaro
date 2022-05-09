import 'package:get/get.dart';
import 'package:udhaarkaroapp/api_calls/category.dart';
import 'package:udhaarkaroapp/models/category_model.dart';

class CategoryController extends GetxController {
  RxList<CategoryModel> category =
      List<CategoryModel>.empty(growable: true).obs;
  RxList<String> mainCategoryList = List<String>.empty(growable: true).obs;
  RxList<String> subCategoryList = List<String>.empty(growable: true).obs;
  RxString response = "".obs;
  RxInt load = 0.obs;
  RxBool businessVisible = false.obs;

  @override
  void onInit() {
    super.onInit();
    load.value = 1;
    getBusinessCategory();
  }

  Future getBusinessCategory() async {
    try {
      await CategoryApiCall().getCategory().then((value) {
        if (value != "error") {
          category.assignAll(value as Iterable<CategoryModel>);
        } else {
          category.assignAll([]);
        }
      });
    } finally {
      getMainBusinessCategory();
    }
  }

  Future getMainBusinessCategory() async {
    try {
      for (final element in category) {
        if (!mainCategoryList.contains(element.mainCategoryName)) {
          mainCategoryList.add(element.mainCategoryName);
        }
      }
    } finally {
      load.value = 0;
    }
  }

  Future getSubBusinessCategory(String main) async {
    subCategoryList.clear();
    try {
      for (final element in category) {
        if (element.mainCategoryName == main) {
          subCategoryList.add(element.subCategoryName);
        }
      }
    } finally {}
  }
  
}
