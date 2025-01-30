import 'package:flutter/material.dart';
import 'package:nba_prediction/models/previous_game_model.dart';

class PreviousGamesList extends StatelessWidget {
  final List<PreviousGame> games;
  final String teamName;

  const PreviousGamesList({
    super.key,
    required this.games,
    required this.teamName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '$teamName Last 5 Games:',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        ...games.map((game) => _buildGameItem(game)),
      ],
    );
  }

  Widget _buildGameItem(PreviousGame game) {
    return ListTile(
      leading: Text(game.gameDate.toString().substring(5, 10)),
      title: Row(
        children: [
          Text(game.teamTricode),
          const SizedBox(width: 8),
          Text('${game.teamPoints}'),
          const Text(' - '),
          Text('${game.opponentPoints}'),
          const SizedBox(width: 8),
          Text(game.opponentTricode),
        ],
      ),
      trailing: Icon(
        game.isHome ? Icons.home : Icons.airplanemode_active,
        color: game.isHome ? Colors.blue : Colors.grey,
      ),
    );
  }
}