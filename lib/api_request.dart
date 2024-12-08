import 'dart:convert';

import 'package:http/http.dart';

import 'soccer_match.dart';

class SoccerApi {
  final String apiUrl =
      "https://v3.football.api-sports.io/fixtures?season=2020&league=39";

  static const headers = {
    'x-rapidapi-host': "v3.football.api-sports.io",
    'x-rapidapi-key': "PUT YOUR API KEY HERE OR IT WILL NOT WORK"
  };

  Future<List<SoccerMatch?>> getAllMatches() async {
    try {
      Response res = await get(Uri.parse(apiUrl), headers: headers);
      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);
        List<dynamic> matchesList = body['response'];
        print("Api service: ${body}"); // Debugging
        return matchesList
            .map((dynamic item) => SoccerMatch.fromJson(item))
            .toList();
      } else {
        print("Failed to load matches: ${res.statusCode}");
        return [];
      }
    } catch (e) {
      print("Error fetching matches: $e");
      return [];
    }
  }
}
