// done

import 'dart:convert';

import 'package:flutter_application_search/model/user.dart';
import 'package:http/http.dart' as http;

class UsersApi {
  static Future<List<User>> getUsers(String query) async {
    final url = Uri.parse('https://api.github.com/users');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List users = json.decode(response.body);

      return users.map((json) => User.fromJson(json)).where((user) {
        final id = user.id.toString();
        final loginLower = user.login.toLowerCase();
        final searchLower = query.toLowerCase();

        return id.contains(searchLower) || loginLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
