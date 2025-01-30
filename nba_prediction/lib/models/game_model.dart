import 'dart:convert';
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
    return Game(
      gameId: json['gameId'],
      gameDateTimeUTC: DateTime.parse(json['gameDateTimeUTC']),
      gameStatusText: json['gameStatusText'],
      homeTeam: Team.fromJson(json['homeTeam']),
      awayTeam: Team.fromJson(json['awayTeam']),
      arenaName: json['arenaName'],
      arenaCity: json['arenaCity'],
      arenaState: json['arenaState'],
      homeTeamPoints: json['homeTeamPoints'],
      awayTeamPoints: json['awayTeamPoints'],
    );
  }

  static Future<List<Game>> fetchGames(String date) async {
    final response = await http.get(Uri.parse('http://........./games/$date')); //TODO - API address
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Game.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load games');
    }
  }
}