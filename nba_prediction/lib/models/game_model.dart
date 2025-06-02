import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:nba_prediction/models/team_model.dart';

class Game {
  final String gameId;
  final DateTime gameDateTimeUTC;
  final String gameStatusText;
  final Team homeTeam;
  final Team awayTeam;
  final String arenaName;
  final String arenaCity;
  final String arenaState;
  final int? homeTeamPoints; // Present if game is Final or has predictions
  final int? awayTeamPoints;

  Game({
    required this.gameId,
    required this.gameDateTimeUTC,
    required this.gameStatusText,
    required this.homeTeam,
    required this.awayTeam,
    required this.arenaName,
    required this.arenaCity,
    required this.arenaState,
    this.homeTeamPoints,
    this.awayTeamPoints,
  });

factory Game.fromJson(Map<String, dynamic> json) {
  final homeTeamJson = json['homeTeam'];
  final awayTeamJson = json['awayTeam'];

  return Game(
    gameId: json['gameId'],
    gameDateTimeUTC: DateTime.parse(json['gameDateTimeUTC']),
    gameStatusText: json['gameStatusText'],
    homeTeam: Team.fromJson(homeTeamJson),
    awayTeam: Team.fromJson(awayTeamJson),
    arenaName: json['arenaName'],
    arenaCity: json['arenaCity'],
    arenaState: json['arenaState'],
    homeTeamPoints: homeTeamJson['score'],
    awayTeamPoints: awayTeamJson['score'],
  );
}

  static Future<List<Game>> fetchGames(String date) async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8001/games/$date')); //TODO - API address
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Game.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load games');
    }
  }

  static Future<List<Game>> fetchMockGames(String date) async {
    final parsedDate = DateTime.parse(date);
    final today = DateTime.now();

    List<dynamic> jsonData;
/*
    if (parsedDate.isBefore(DateTime(today.year, today.month, today.day))) {
      // Past games
      final jsonString = await rootBundle.loadString('assets/mock_data/past_games.json');
      jsonData = json.decode(jsonString);
    } else {
      // Incoming games
      final jsonString = await rootBundle.loadString('assets/mock_data/incoming_games.json');
      jsonData = json.decode(jsonString);
    }
*/
    final jsonString = await rootBundle.loadString('assets/mock_data/games_$date.json');
    jsonData = json.decode(jsonString);

    return jsonData.map<Game>((json) => Game.fromJson(json)).toList();
  }
}