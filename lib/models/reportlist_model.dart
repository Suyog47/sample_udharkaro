import 'dart:convert';

List<ReportListModel> reportListFromJson(String str) =>
    List<ReportListModel>.from(json
            .decode(str)
            .map((x) => ReportListModel.fromJson(x as Map<String, dynamic>))
        as Iterable<dynamic>,);

String reportListToJson(List<ReportListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReportListModel {

  String id;
  String pic;
  String name;
  String date;

  ReportListModel({
    this.id = "",
    this.pic = "",
    this.name = "",
    this.date = "",
  });


  factory ReportListModel.fromJson(Map<String, dynamic> json) =>
      ReportListModel(
        id: json["id"].toString(),
        pic: json["pic"].toString(),
        name: json["name"].toString(),
        date: json["date"].toString(),
      );

  Map<String, dynamic> toJson() =>
      {"id": id, "pic": pic, "name": name, "date": date};
}
