import 'dart:convert';

List<UserModel> welcomeFromJson(String str) => List<UserModel>.from(
    json.decode(str).map((x) => UserModel.fromJson(x as Map<String, dynamic>))
        as Iterable<dynamic>,);

String welcomeToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {

  String id;
  dynamic pic;
  String name;
  String email = "";
  String mobileNumber;
  String password;
  String accountType;
  String businessMainCategory;
  String businessSubCategory;
  String fcmToken;
  String createdAt;
  String updatedAt;
  String lastLoginAt;
  String status;

  UserModel({
    this.id = "",
    this.pic = "",
    this.name = "",
    this.email = "",
    this.mobileNumber = "",
    this.password = "",
    this.accountType = "",
    this.businessMainCategory = "",
    this.businessSubCategory = "",
    this.fcmToken = "",
    this.createdAt = "",
    this.updatedAt = "",
    this.lastLoginAt = "",
    this.status = "",
  });


  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"].toString(),
        pic: json["pic"].toString(),
        name: json["name"].toString(),
        email: json["email"].toString(),
        mobileNumber: json["mobile_number"].toString(),
        password: json["password"].toString(),
        accountType: json["account_type"].toString(),
        businessMainCategory: json["business_main_category"].toString(),
        businessSubCategory: json["business_sub_category"].toString(),
        fcmToken: json["fcm_token"].toString(),
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
        lastLoginAt: json["last_login_at"].toString(),
        status: json["status"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pic": pic,
        "name": name,
        "email": email,
        "mobile_number": mobileNumber,
        "password": password,
        "account_type": accountType,
        "business_main_category": businessMainCategory,
        "business_sub_category": businessSubCategory,
        "fcm_token": fcmToken,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "last_login_at": lastLoginAt,
        "status": status,
      };
}
