import 'dart:convert';

List<UserListModel> userListFromJson(String str) =>
    List<UserListModel>.from(json
            .decode(str)
            .map((x) => UserListModel.fromJson(x as Map<String, dynamic>))
        as Iterable<dynamic>,);

String userListToJson(List<UserListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserListModel {

  String id = "";
  String pic = "";
  String name = "";
  String reportStatus = "";
  String token = "";
  String mobileNumber = "";
  String limit = "";

  UserListModel({
    this.id,
    this.pic,
    this.name,
    this.reportStatus,
    this.token,
    this.mobileNumber,
    this.limit,
  });


  factory UserListModel.fromJson(Map<String, dynamic> json) => UserListModel(
        id: json["id"].toString(),
        pic: json["pic"].toString(),
        name: json["name"].toString(),
        reportStatus: json["status"].toString(),
        token: json["fcm_token"].toString(),
        mobileNumber: json["mobile_number"].toString(),
        limit: json["limit_value"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pic": pic,
        "name": name,
        "status": reportStatus,
        "token": token,
        "mobile_number": mobileNumber,
        "limit_value": limit,
      };
}
