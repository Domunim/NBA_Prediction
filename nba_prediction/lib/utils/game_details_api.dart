import 'package:flutter/services.dart';
import 'package:nba_prediction/models/game_details_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GameDetailsApi {
  static Future<GameDetails> fetchGameDetails(String gameId) async {
    final response = await http.get(Uri.parse('http:/127.0.0.1/games/details/$gameId')); // TODO - API address
    if (response.statusCode == 200) {
      return GameDetails.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load game details');
    }
  }

  static Future<GameDetails> fetchMockGameDetails(String gameId) async {
  //final jsonString = await rootBundle.loadString('assets/mock_data/game_details_$gameId.json');
  final jsonString = await rootBundle.loadString('assets/mock_data/past_game_details.json');
  final Map<String, dynamic> data = json.decode(jsonString);
  return GameDetails.fromJson(data);
  }

}