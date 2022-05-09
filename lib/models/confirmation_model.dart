import 'dart:convert';

List<ConfirmationModel> confirmationFromJson(String str) =>
    List<ConfirmationModel>.from(
      json
              .decode(str)
              .map((x) => ConfirmationModel.fromJson(x as Map<String, dynamic>))
          as Iterable<dynamic>,
    );

String welcomeToJson(List<ConfirmationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ConfirmationModel {

  String userId;
  String name;
  String pic;
  String fromId;
  String toId;
  String amount;
  String txnId;
  String reportCount;

  ConfirmationModel({
    this.userId = "",
    this.name = "",
    this.pic = "",
    this.fromId = "",
    this.toId = "",
    this.amount = "",
    this.txnId = "",
    this.reportCount = "",
  });


  factory ConfirmationModel.fromJson(Map<String, dynamic> json) =>
      ConfirmationModel(
        userId: json["id"].toString(),
        name: json["name"].toString(),
        pic: json["pic"].toString(),
        fromId: json["from_user_id"].toString(),
        toId: json["to_user_id"].toString(),
        amount: json["amount"].toString(),
        txnId: json["transaction_id"].toString(),
        reportCount: json["status"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "pic": pic,
        "from_id": fromId,
        "to_id": toId,
        "amount": amount,
        "transaction_id": txnId,
      };
}
