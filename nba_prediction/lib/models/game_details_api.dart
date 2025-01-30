import 'package:nba_prediction/models/game_details_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GameDetailsApi {
  static Future<GameDetails> fetchGameDetails(String gameId) async {
    final response = await http.get(Uri.parse('http://your-api/games/details/$gameId'));
    if (response.statusCode == 200) {
      return GameDetails.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load game details');
    }
  }
}