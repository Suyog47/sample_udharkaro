import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:udhaarkaroapp/models/category_model.dart';

class CategoryApiCall {
  String baseUrl = dotenv.env["API_BASE_URL"];
  String secUrl = dotenv.env["API_SEC_URL"];

  Future<dynamic> getCategory() async {
    final url = Uri.https(
      baseUrl,
      '/$secUrl/Category/getCategory.php',
      {'q': '{https}'},
    );
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          return categoryFromJson(response.body);
        }
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
