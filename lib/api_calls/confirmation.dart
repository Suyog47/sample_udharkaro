import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:udhaarkaroapp/models/confirmation_model.dart';

class ConfirmationApiCall {
  String baseUrl = dotenv.env["API_BASE_URL"];
  String secUrl = dotenv.env["API_SEC_URL"];

  // Future<dynamic> getConfirmationStats(String txnId) async {
  //   final url = Uri.https(
  //     baseUrl,
  //     '/$secUrl/Transactions/getConfirmationStatus.php',
  //     {'q': '{https}'},
  //   );
  //
  //   try {
  //     final response = await http.post(
  //       url,
  //       body: {
  //         "txn_id": txnId,
  //       },
  //     );
  //     if (response.statusCode == 200) {
  //       return jsonDecode(response.body);
  //     } else {
  //       print(response.body);
  //       return "error";
  //     }
  //   } catch (e) {
  //     print("error :: $e");
  //     return "error";
  //   }
  // }

  Future<dynamic> updateTransactionStats(
    String status,
    String reason,
    String txnId,
  ) async {
    final url = Uri.https(
      baseUrl,
      '/$secUrl/Transactions/updateTransactionStatus.php',
      {'q': '{https}'},
    );

    try {
      final response = await http.post(
        url,
        body: {
          "status": status,
          "reason": reason,
          "txn_id": txnId,
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

//   Future<dynamic> getConfirmationList(String id) async {
//     final url = Uri.https(
//       baseUrl,
//       '/$secUrl/Transactions/getConfirmationsList.php',
//       {'q': '{https}'},
//     );
//     try {
//       final response = await http.post(url, body: {"id": id});
//       if (response.statusCode == 200) {
//         if (response.body != "") {
//           return confirmationFromJson(response.body);
//         } else {
//           return response.body;
//         }
//       } else {
//         print(response.body);
//         return "error";
//       }
//     } catch (e) {
//       print('error$e');
//       return "error";
//     }
//   }
 }
