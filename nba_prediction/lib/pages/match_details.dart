import 'package:flutter/material.dart';
import 'package:nba_prediction/utils/game_details_api.dart';
import 'package:nba_prediction/models/game_details_model.dart';
import 'package:nba_prediction/models/game_model.dart';
import 'package:nba_prediction/models/game_stats_model.dart';
import 'package:nba_prediction/models/team_model.dart';
import 'package:nba_prediction/widgets/app_bar.dart';
import 'package:nba_prediction/widgets/previous_games_list.dart';

class MatchDetailsPage extends StatelessWidget {
  final String gameId;

  const MatchDetailsPage({super.key, required this.gameId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: FutureBuilder<GameDetails>(
        //future: GameDetailsApi.fetchGameDetails(gameId), // Real API call
        future: GameDetailsApi.fetchMockGameDetails(gameId), // Mock data
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final gameDetails = snapshot.data!;
          final game = gameDetails.game;
          final stats = gameDetails.stats;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildGameHeader(game),
                const SizedBox(height: 24),
                _buildTeamsSection(game),
                const SizedBox(height: 32),
                _buildVenueSection(game),
                const SizedBox(height: 32),
                if (stats != null) _buildStatsSection(stats),
                const SizedBox(height: 32),
                _buildPreviousGamesSection(gameDetails),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildGameHeader(Game game) {
    return Column(
      children: [
        Text(
          game.gameStatusText,
          style: TextStyle(
            fontSize: 18,
            color: _getStatusColor(game),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          game.gameDateTimeUTC.toString().substring(11, 16),
          style: const TextStyle(fontSize: 20, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildTeamsSection(Game game) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildTeamColumn(game.homeTeam, true, game),
        _buildMiddleSection(game),
        _buildTeamColumn(game.awayTeam, false, game),
      ],
    );
  }

  Widget _buildTeamColumn(Team team, bool isHome, Game game) {
    return Expanded(
      child: Column(
        children: [
          Hero(
            tag: '${team.teamId}-logo',
            child: Image.asset(
              'assets/images/${team.teamTricode}.png',
              width: 100,
              height: 100,
              errorBuilder: (_, __, ___) => const Icon(Icons.sports_basketball, size: 60),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            team.teamTricode,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            team.teamName,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          if (game.gameStatusText == 'Final') ...[
            const SizedBox(height: 8),
            Text(
              isHome ? '${game.homeTeamPoints}' : '${game.awayTeamPoints}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMiddleSection(Game game) {
    return Column(
      children: [
        if (game.gameStatusText != 'Final')
          const Text('VS', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        if (game.gameStatusText == 'Final')
          const Text('Final Score', style: TextStyle(fontSize: 16, color: Colors.green)),
        if (game.gameStatusText == 'Preview') ...[
          const SizedBox(height: 8),
          Text(
            '${game.homeTeamPoints}%',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Text('VS', style: TextStyle(fontSize: 18)),
          Text(
            '${game.awayTeamPoints}%',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ],
    );
  }

  Widget _buildVenueSection(Game game) {
    return Column(
      children: [
        const Text(
          'Venue',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          game.arenaName,
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          '${game.arenaCity}, ${game.arenaState}',
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildStatsSection(GameStats stats) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Game Statistics',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 3,
          children: [
            _buildStatItem('Points', '${stats.teamPoints} - ${stats.opponentPoints}'),
            _buildStatItem('Field Goal %', '${stats.teamFieldGoalPct}% - ${stats.opponentFieldGoalPct}%'),
            _buildStatItem('Rebounds', '${stats.teamRebounds} - ${stats.opponentRebounds}'),
            _buildStatItem('Assists', '${stats.teamAssists} - ${stats.opponentAssists}'),
          ],
        ),
      ],
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.grey),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildPreviousGamesSection(GameDetails gameDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Previous Matches',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        PreviousGamesList(
          games: gameDetails.previousHomeGames,
          teamName: gameDetails.game.homeTeam.teamTricode,
        ),
        const SizedBox(height: 24),
        PreviousGamesList(
          games: gameDetails.previousAwayGames,
          teamName: gameDetails.game.awayTeam.teamTricode,
        ),
      ],
    );
  }

  Color _getStatusColor(Game game) {
    switch (game.gameStatusText) {
      case 'Final':
        return Colors.green;
      case 'Live':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }
}