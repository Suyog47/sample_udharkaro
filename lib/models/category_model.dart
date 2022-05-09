import 'dart:convert';

List<CategoryModel> categoryFromJson(String str) =>
    List<CategoryModel>.from(json
            .decode(str)
            .map((x) => CategoryModel.fromJson(x as Map<String, dynamic>))
        as Iterable<dynamic>,);

String welcomeToJson(List<CategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class CategoryModel {

  String mainCategoryName;
  String subCategoryName;

  CategoryModel({
    this.mainCategoryName,
    this.subCategoryName,
  });


  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        mainCategoryName: json["main_category_name"].toString(),
        subCategoryName: json["sub_category_name"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "main_category_name": mainCategoryName,
        "sub_category_name": subCategoryName,
      };
}
