import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class SMS {
  String baseUrl = dotenv.env["API_BASE_URL"];

  Future sendSms(String number, String code, String type) async {
    final url = Uri.https(
      baseUrl,
      '/udhaarkaro/Sms/sms.php',
      {'q': '{https}'},
    );

    try {
      final response = await http
          .post(url, body: {"code": code, "number": number, "type": type});
      if (response.statusCode == 200) {
        print(response.body);
        return response.body;
      } else {
        print(response.body);
        return "error";
      }
    } catch (e) {
      print("error :: $e");
      return "error";
    }
  }
}
