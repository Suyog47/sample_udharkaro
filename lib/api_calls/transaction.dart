import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:udhaarkaroapp/models/transaction_model.dart';

class TransactionApiCall {
  String baseUrl = dotenv.env["API_BASE_URL"];
  String secUrl = dotenv.env["API_SEC_URL"];

  Future<dynamic> addUser(dynamic data) async {
    final url = Uri.https(
      baseUrl,
      '/$secUrl/Transactions/addUser.php',
      {'q': '{https}'},
    );
    try {
      final response = await http.post(url, body: data);
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

  Future<dynamic> addTxn(TransactionModel txnModel) async {
    final url = Uri.https(
      baseUrl,
      '/$secUrl/Transactions/addTransaction.php',
      {'q': '{https}'},
    );
    try {
      final response = await http.post(url, body: txnModel.toJson());
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

  Future<dynamic> checkUserWithLimit(String id, String number) async {
    final url = Uri.https(
      baseUrl,
      '/$secUrl/Transactions/checkUserWithLimit.php',
      {'q': '{https}'},
    );
    try {
      final response =
          await http.post(url, body: {"id": id, "mobile_number": number});
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

  Future<dynamic> checkUserNumber(String number) async {
    final url = Uri.https(
      baseUrl,
      '/$secUrl/Users/checkUser.php',
      {'q': '{https}'},
    );
    try {
      final response =
          await http.post(url, body: {"mobile_number": number});
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

  Future<dynamic> getAllTxn(String id) async {
    final url = Uri.https(
      baseUrl,
      '/$secUrl/Transactions/getAllTransactions.php',
      {'q': '{https}'},
    );

    try {
      final response = await http.post(url, body: {"id": id});
      if (response.statusCode == 200) {
        if (response.body != "") {
          return transactionFromJson(response.body);
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

  Future<dynamic> getTakenTxn(String id) async {
    final url = Uri.https(
      baseUrl,
      '/$secUrl/Transactions/getTakenAmount.php',
      {'q': '{https}'},
    );

    try {
      final response = await http.post(url, body: {"id": id});
      if (response.statusCode == 200) {
        if (response.body != "") {
          return transactionFromJson(response.body);
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

  Future<dynamic> getGivenTxn(String id) async {
    final url = Uri.https(
      baseUrl,
        '/$secUrl/Transactions/getGivenAmount.php',
      {'q': '{https}'},
    );

    try {
      final response = await http.post(url, body: {"id": id});
      if (response.statusCode == 200) {
        if (response.body != "") {
          return transactionFromJson(response.body);
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

  Future<dynamic> getUserTransactions(String myid, String yourid) async {
    final url = Uri.https(
      baseUrl,
      '/$secUrl/Transactions/usersTransactions.php',
      {'q': '{https}'},
    );

    try {
      final response =
          await http.post(url, body: {"myid": myid, "yourid": yourid});
      if (response.statusCode == 200) {
        if (response.body != "") {
          return transactionFromJson(response.body);
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

  Future<dynamic> updateTransactionRead(
      String status,
      String txnId,
      String reason,
      String msg,
      ) async {
    final url = Uri.https(
    baseUrl,
    '/$secUrl/Transactions/updateTransactionRead.php',
    {'q': '{https}'},
    );

    try {
      final response = await http.post(
        url,
        body: {
          "status": status,
          "txn_id": txnId,
          "reason": reason,
          "reject_reason": msg,
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

