import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:udhaarkaroapp/models/reportlist_model.dart';
import 'package:udhaarkaroapp/models/user_model.dart';
import 'package:udhaarkaroapp/models/userlist_model.dart';

class UserApiCalls {
  String baseUrl = dotenv.env["API_BASE_URL"];
  String secUrl = dotenv.env["API_SEC_URL"];

  Future<dynamic> addUser(UserModel userModel) async {
    final url = Uri.https(
      baseUrl,
      '/$secUrl/Users/signUp.php',
      {'q': '{https}'},
    );
    try {
      final response = await http.post(url, body: userModel.toJson());
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

  Future<dynamic> logIn(UserModel userModel) async {
    final url = Uri.https(
      baseUrl,
      '/$secUrl/Users/login.php',
      {'q': '{https}'},
    );
    try {
      final response = await http.post(url, body: userModel.toJson());
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

  Future<dynamic> update(String name, String num, String email, String category, String main,
      String sub, String at,) async {
    final url = Uri.https(
      baseUrl,
      '/$secUrl/Users/update.php',
      {'q': '{https}'},
    );
    try {
      final response = await http.post(
        url,
        body: {
          "name": name,
          "email": email,
          "mobile_number": num,
          "account_type": category,
          "business_main_category": main,
          "business_sub_category": sub,
          "updated_at": at
        },
      );
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

  Future<dynamic> updateImage(String pic, String number) async {
    final url = Uri.https(
      baseUrl,
      '/$secUrl/Users/updateImage.php',
      {'q': '{https}'},
    );
    try {
      final response =
          await http.post(url, body: {"pic": pic, "mobile_number": number});
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

  Future<dynamic> updatePass(String pass, String mobile) async {
    final url = Uri.https(
      baseUrl,
      '/$secUrl/Users/updatePass.php',
      {'q': '{https}'},
    );
    try {
      final response = await http
          .post(url, body: {"password": pass, "mobile_number": mobile});
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

  Future<dynamic> updateFcm(String token, String mobile) async {
    final url = Uri.https(
      baseUrl,
      '/$secUrl/Users/updateFcmToken.php',
      {'q': '{https}'},
    );
    try {
      final response =
          await http.post(url, body: {"token": token, "mobile_number": mobile});
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

  Future<dynamic> checkUserData(UserModel userModel) async {
    final url = Uri.https(
      baseUrl,
      '/$secUrl/Users/checkUser.php',
      {'q': '{https}'},
    );
    try {
      final response = await http.post(url, body: userModel.toJson());
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

  Future<dynamic> checkAppVersion() async {
    final url = Uri.https(
      baseUrl,
      '/$secUrl/Users/checkVersion.php',
      {'q': '{https}'},
    );
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print(response.body);
        return "error";
      }
    } catch (e) {
      print('error$e');
      return "error";
    }
  }

  Future<dynamic> getUsersList(String id) async {
    final url = Uri.https(
      baseUrl,
      '/$secUrl/Users/getUsers.php',
      {'q': '{https}'},
    );
    try {
      final response = await http.post(url, body: {"id": id});
      if (response.statusCode == 200) {
        if (response.body != "") {
          return userListFromJson(response.body);
        } else {
          return response.body;
        }
      } else {
        print(response.body);
        return "error";
      }
    } catch (e) {
      print("error :: $e");
      return "error";
    }
  }

  Future<dynamic> getUserReportList(String id) async {
    final url = Uri.https(
      baseUrl,
      '/$secUrl/Users/getUserReports.php',
      {'q': '{https}'},
    );
    try {
      final response = await http.post(url, body: {"id": id});
      if (response.statusCode == 200) {
        if (response.body != "") {
          return reportListFromJson(response.body);
        } else {
          return response.body;
        }
      } else {
        print(response.body);
        return "error";
      }
    } catch (e) {
      print("error :: $e");
      return "error";
    }
  }

  Future<dynamic> fetchReportList(String id) async {
    final url = Uri.https(
      baseUrl,
      '/$secUrl/Users/fetchReports.php',
      {'q': '{https}'},
    );
    try {
      final response = await http.post(url, body: {"id": id});
      if (response.statusCode == 200) {
        if (response.body != "") {
          return reportListFromJson(response.body);
        } else {
          return response.body;
        }
      } else {
        print(response.body);
        return "error";
      }
    } catch (e) {
      print("error :: $e");
      return "error";
    }
  }

  Future<dynamic> addReport(String fromId, String toId, String date) async {
    final url = Uri.https(
      baseUrl,
      '/$secUrl/Users/addReport.php',
      {'q': '{https}'},
    );
    try {
      final response = await http.post(
        url,
        body: {
          "fromId": fromId,
          "toId": toId,
          "status": "reported",
          "date": date
        },
      );
      if (response.statusCode == 200) {
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

  Future<dynamic> deleteReport(String fromId, String toId) async {
    final url = Uri.https(
      baseUrl,
      '/$secUrl/Users/deleteReport.php',
      {'q': '{https}'},
    );
    try {
      final response =
          await http.post(url, body: {"fromId": fromId, "toId": toId});
      if (response.statusCode == 200) {
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

  Future<dynamic> setUsersLimit(
    String fromId,
    String toId,
    String amount,
    String date,
    String action,
  ) async {
    final url = Uri.https(
      baseUrl,
      '/$secUrl/Users/setUserLimit.php',
      {'q': '{https}'},
    );
    try {
      final response = await http.post(
        url,
        body: {
          "fromId": fromId,
          "toId": toId,
          "amount": amount,
          "updatedAt": date,
          "action": action
        },
      );
      if (response.statusCode == 200) {
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
