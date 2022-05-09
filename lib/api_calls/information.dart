import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class InformationApiCall {
  String baseUrl = dotenv.env["API_BASE_URL"];
  String secUrl = dotenv.env["API_SEC_URL"];

  Future<dynamic> getInformation(String name) async {
    final url = Uri.https(
      baseUrl,
      '/$secUrl/Information/getInformation.php',
      {'q': '{https}'},
    );
    try {
      final response = await http.post(url, body: {"name": name});
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
