import 'dart:convert';

import 'package:http_curd_operation/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:http_curd_operation/widgets/snackbar.dart';

class HttpsMethods {
  //! HTTP GET() Method.
 static Future<List<Users>> get() async {
    try {
      final url = Uri.parse(
        "https://6686c5ca83c983911b039327.mockapi.io/api/users",
      );
      final res = await http.get(url);
      final List<Users> users = usersFromJson(res.body);
      return users;
    } catch (error) {
      throw error.toString();
    }
  }

  //! HTTP POST() Method.
 static Future<void> post({required userModel, required context}) async {
    try {
      final body = jsonEncode(userModel);

      final url = Uri.https("6686c5ca83c983911b039327.mockapi.io", "api/users");

      final headers = {
        'Content-Type': 'application/json',
      };

      final res = await http.post(url, headers: headers, body: body);

      if (res.statusCode == 201) {
        if (context.mounted) {
          showSnackBar("New User Created Succesfully", context);
        }
      } else {
        if (context.mounted) {
          showSnackBar("Something Went Wrong", context);
        }
      }
    } catch (error) {
      throw error.toString();
    }
  }

  //! HTTP PUT() Method.
 static Future<void> put({required userModel, required id , required context}) async {
    try {
      final body = jsonEncode(userModel);

      final url =
          Uri.https("6686c5ca83c983911b039327.mockapi.io", "api/users/$id");

      final headers = {
        'Content-Type': 'application/json',
      };

      final res = await http.put(
        url,
        headers: headers,
        body: body,
      );

      if (res.statusCode == 200) {
        if (context.mounted) {
          showSnackBar("User no : $id Updated Succesfully", context);
        }
      } else {
        if (context.mounted) {
          showSnackBar("Something Went Wrong", context);
        }
      }
    } catch (error) {
      throw error.toString();
    }
  }

  //! HTTP DELETE() Method.
 static Future<void> delete({required id , required context}) async {
    try {
      final url =
          Uri.https("6686c5ca83c983911b039327.mockapi.io", "api/users/$id");

      final res = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (res.statusCode == 200) {
        if (context.mounted) {
          showSnackBar("User no : $id Deleted Succesfully", context);
        }
      } else {
        if (context.mounted) {
          showSnackBar("Something Went Wrong", context);
        }
      }
    } catch (error) {
      throw error.toString();
    }
  }
}