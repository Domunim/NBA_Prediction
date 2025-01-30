import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nba_prediction/models/game_model.dart';
import 'package:nba_prediction/models/team_model.dart';
import 'package:nba_prediction/pages/match_details.dart';
import 'package:nba_prediction/widgets/app_bar.dart';
import 'package:nba_prediction/widgets/date_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Game> games = [];
  DateTime selectedDate = DateTime.now();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _dateBarKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCenter();
    });
    _loadGames();
  }

  void _onDateSelected(DateTime newDate) {
    setState(() {
      selectedDate = newDate;
      _loadGames();
    });
  }

  Future<void> _loadGames() async {
    try {
      final fetchedGames = await Game.fetchGames(selectedDate.toIso8601String().split('T')[0]);
      setState(() => games = fetchedGames);
    } catch (e) {
      print('Error loading games: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load games: ${e.toString()}')),
      );
    }
  }

  void _scrollToCenter() {
    final context = _dateBarKey.currentContext;
    if (context == null) return;

    final box = context.findRenderObject() as RenderBox;
    final viewport = RenderAbstractViewport.of(box);
    final offset = viewport.getOffsetToReveal(box, 0.5).offset;
    
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: appBar(context),
      body: Column(
        children: [
          DateBar(
            key: _dateBarKey,
            selectedDate: selectedDate,
            onDateSelected: _onDateSelected,
            scrollController: _scrollController,
          ),
          Expanded(
            child: games.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: games.length,
                    itemBuilder: (context, index) => GameCard(game: games[index]),
                  ),
          ),
        ],
      ),
    );
  }
}

class GameCard extends StatelessWidget {
  final Game game;

  const GameCard({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MatchDetailsPage(gameId: game.gameId),
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildGameStatus(),
              const SizedBox(height: 12),
              _buildTeamsRow(),
              if (game.gameStatusText == 'Final') _buildFinalScore(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameStatus() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.circle,
          color: _getStatusColor(),
          size: 12,
        ),
        const SizedBox(width: 8),
        Text(
          game.gameStatusText,
          style: TextStyle(
            color: _getStatusColor(),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildTeamsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildTeamColumn(game.homeTeam, true),
        _buildOddsSection(),
        _buildTeamColumn(game.awayTeam, false),
      ],
    );
  }

  Widget _buildTeamColumn(Team team, bool isHome) {
    return Column(
      children: [
        Hero(
          tag: '${team.teamId}-logo',
          child: Image.asset(
            'assets/images/${team.teamTricode}.png',
            width: 64,
            height: 64,
            errorBuilder: (_, __, ___) => const Icon(Icons.sports_basketball),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          team.teamTricode,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          team.teamName,
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildOddsSection() {
    return Column(
      children: [
        Text(
          game.gameDateTimeUTC.toString().substring(11, 16),
          style: const TextStyle(color: Colors.blueGrey),
        ),
        const SizedBox(height: 8),
        if (game.gameStatusText != 'Final')
          const Text('VS', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        if (game.gameStatusText == 'Final') ..._buildScoreSection(),
      ],
    );
  }

  List<Widget> _buildScoreSection() {
    return [
      Text(
        '${game.homeTeamPoints ?? '-'}',
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      const Text('VS', style: TextStyle(fontSize: 18)),
      Text(
        '${game.awayTeamPoints ?? '-'}',
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    ];
  }

  Widget _buildFinalScore() {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Text(
        'Final Score',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.grey[600],
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  Color _getStatusColor() {
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