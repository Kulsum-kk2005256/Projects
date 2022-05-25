import 'dart:convert' as convert;

import 'package:flutter_application_search/model/repo.dart';
import 'package:http/http.dart' as http;

class RepoApi {
  static Future<List<RepoItem>> getRepo(String query) async {
    var endpointUrl = 'https://api.github.com/search/repositories';
    Map<String, String> queryParams = {'q': '{$query}'};
    String queryString = Uri(queryParameters: queryParams).query;
    var requestUrl =
        '$endpointUrl?$queryString'; // result - https://www.myurl.com/api/v1/user?param1=1&param2=2
    var response = await http.get(Uri.parse(requestUrl));
    if (response.statusCode == 200) {
      final List repo = convert.jsonDecode(response.body)['items'];
      // print('Returned repo is: $repo\nType: ${repo.type}');
      return repo.map((json) => RepoItem.fromJson(json)).where((rep) {
        final id = rep.id.toString();
        final name = rep.name.toString().toLowerCase();
        final searchLower = query.toLowerCase();
        return id.contains(searchLower) || name.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
