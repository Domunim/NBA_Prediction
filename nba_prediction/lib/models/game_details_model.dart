import 'package:nba_prediction/models/game_stats_model.dart';
import 'package:nba_prediction/models/game_model.dart';
import 'package:nba_prediction/models/previous_game_model.dart';

class GameDetails {
  final Game game;
  final GameStats? stats;
  final List<PreviousGame> previousHomeGames;
  final List<PreviousGame> previousAwayGames;

  GameDetails({
    required this.game,
    this.stats,
    required this.previousHomeGames,
    required this.previousAwayGames,
  });

  factory GameDetails.fromJson(Map<String, dynamic> json) {
    return GameDetails(
      game: Game.fromJson(json['game']),
      stats: json['stats'] != null ? GameStats.fromJson(json['stats']) : null,
      previousHomeGames: (json['previous_home_games'] as List)
          .map((e) => PreviousGame.fromJson(e))
          .toList(),
      previousAwayGames: (json['previous_away_games'] as List)
          .map((e) => PreviousGame.fromJson(e))
          .toList(),
    );
  }
}