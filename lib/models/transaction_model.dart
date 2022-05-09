import 'dart:convert';

List<TransactionModel> transactionFromJson(String str) =>
    List<TransactionModel>.from(
      json
              .decode(str)
              .map((x) => TransactionModel.fromJson(x as Map<String, dynamic>))
          as Iterable<dynamic>,
    );

String welcomeToJson(List<TransactionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TransactionModel {

  String txnId;
  String id;
  String pic;
  String name;
  String number;
  String fromId;
  String toId;
  String transactionId;
  String operatedBy;
  String limit;
  String date;
  String type;
  String fcmToken;
  String status;
  String reportStatus;
  String reason;
  String rejectReason;
  String amount;
  String deficitTaken;
  String deficitGiven;
  String note;
  String transRead;

  TransactionModel({
    this.txnId = "",
    this.id = "",
    this.pic = "",
    this.name = "",
    this.number = "",
    this.fromId = "",
    this.toId = "",
    this.transactionId = "",
    this.operatedBy = "",
    this.limit = "",
    this.date = "",
    this.type = "",
    this.status = "",
    this.reportStatus = "",
    this.reason = "",
    this.rejectReason = "",
    this.amount = "",
    this.deficitTaken = "",
    this.deficitGiven = "",
    this.fcmToken = "",
    this.note = "",
    this.transRead = "",
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        txnId: json["TxnId"].toString(),
        id: json["id"].toString(),
        pic: json["pic"].toString(),
        name: json["name"].toString(),
        number: json["mobile_number"].toString(),
        fromId: json["from_user_id"].toString(),
        toId: json["to_user_id"].toString(),
        transactionId: json["transaction_id"].toString(),
        operatedBy: json["operated_by"].toString(),
        limit: json["limit_value"].toString(),
        date: json["time_of_txn"].toString(),
        status: json["status"].toString(),
        reportStatus: json["reportStatus"].toString(),
        reason: json["reason"].toString(),
        rejectReason: json["rejectReason"].toString(),
        amount: json["amount"].toString(),
        deficitTaken: json["deficitTaken"].toString(),
        deficitGiven: json["deficitGiven"].toString(),
        fcmToken: json["fcm_token"].toString(),
        note: json["note"].toString(),
        transRead: json["transacRead"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pic": pic,
        "name": name,
        "mobile_number": number,
        "from_user_id": fromId,
        "to_user_id": toId,
        "transaction_id": transactionId,
        "operated_by": operatedBy,
        "limit_value": limit,
        "time_of_txn": date,
        "status": status,
        "reason": reason,
        "rejectReason": rejectReason,
        "amount": amount,
        "deficitTaken": deficitTaken,
        "deficitGiven": deficitGiven,
        "fcmToken": fcmToken,
        "note": note,
        "transacRead" : transRead,
      };
}
