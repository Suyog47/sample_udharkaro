import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:udhaarkaroapp/models/feedback_model.dart';

class FeedbackApiCall {
  String baseUrl = dotenv.env["API_BASE_URL"];
  String secUrl = dotenv.env["API_SEC_URL"];

  Future<dynamic> setFeedback(FeedbackModel fbModel) async {
    final url = Uri.https(
      baseUrl,
      '/$secUrl/Feedback/setFeedback.php',
      {'q': '{https}'},
    );
    try {
      final response = await http.post(url, body: fbModel.toJson());
      if (response.statusCode == 200) {
        return response.body;
      } else {
        print(response.body);
        return "error";
      }
    } catch (e) {
      print('error$e');
      return "error";
    }
  }
}
