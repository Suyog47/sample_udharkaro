import 'dart:convert';

List<FeedbackModel> welcomeFromJson(String str) => List<FeedbackModel>.from(json
        .decode(str)
        .map((x) => FeedbackModel.fromJson(x as Map<String, dynamic>))
    as Iterable<dynamic>,);

String welcomeToJson(List<FeedbackModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FeedbackModel {

  String userId;
  String feedback;
  String rating;
  String recommendation;
  String createdAt;

  FeedbackModel({
    this.userId = "",
    this.feedback = "",
    this.rating = "",
    this.recommendation = "",
    this.createdAt = "",
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) => FeedbackModel(
        userId: json["userId"].toString(),
        feedback: json["feedback"].toString(),
        rating: json["rating"].toString(),
        recommendation: json["recommendation"].toString(),
        createdAt: json["created_at"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "feedback": feedback,
        "rating": rating,
        "recommendation": recommendation,
        "created_at": createdAt,
      };
}
