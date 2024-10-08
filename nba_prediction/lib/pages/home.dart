import 'package:flutter/material.dart';
import 'package:nba_prediction/models/match_model.dart';
import 'package:nba_prediction/models/team_model.dart';
import 'package:nba_prediction/pages/matchDetails.dart';
import 'package:nba_prediction/widgets/appBar.dart';
import 'package:nba_prediction/widgets/dateBar.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MatchModel> matches = [];
  List<TeamModel> teams = [];
  DateTime selectedDate = DateTime.now();
  final ScrollController _scrollController = ScrollController();

  void getTeamsAndMatches() {
    matches = MatchModel.getMatches();
    teams = TeamModel.getTeams();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCenter();
    });
    
    getTeamsAndMatches();
  }

  void _onDateSelected(DateTime newDate) {
    setState(() {
      selectedDate = newDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    getTeamsAndMatches();
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: appBar(context),
      body: Column(children: [
          dateBar(selectedDate, _onDateSelected),
          matchList(),
        ],
      ),
    );
  }

  Expanded matchList() {
    return Expanded(
      child: ListView.builder(
        itemCount: matches.length,
        itemBuilder: (context, index) {
          final match = matches[index];

          return matchCard(match);
        },
      ),
    );
  }


GestureDetector matchCard(MatchModel match) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MatchDetails(match: match, teams: teams),
        ),
      );
    },
    child: gameCard(match)
  );
}


Card gameCard(MatchModel match) {
  return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Time Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  match.date.hour.toString().padLeft(2, '0') + ":" + match.date.minute.toString().padLeft(2, '0'),
                  style: TextStyle(fontSize: 16.0, color: Colors.blueGrey),
                ),
              ],
            ),
            SizedBox(height: 8.0),

            // Teams and odds
            Row(
              children: [

                // Home team
                Expanded(
                  child: Column(
                    children: [
                      Hero(
                        tag: '${match.homeTeamShortName}-logo',
                        child: Image.asset(
                          'assets/images/${match.homeTeamShortName}.png',
                          width: 60.0,
                          height: 60.0,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        TeamModel.getTeamName(match.homeTeamShortName, teams),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                // Odds
                Expanded(
                  child: Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.black),
                          children: [
                            TextSpan(text: '${match.oddsForHomeTeam}'),
                            TextSpan(
                              text: '%',
                              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal),
                            ),
                            TextSpan(text: ' : ${match.oddsForAwayTeam}'),
                            TextSpan(
                              text: '%',
                              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Away team
                Expanded(
                  child: Column(
                    children: [
                      Hero(
                        tag: '${match.awayTeamShortName}-logo',
                        child: Image.asset(
                          'assets/images/${match.awayTeamShortName}.png',
                          width: 60.0,
                          height: 60.0,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        TeamModel.getTeamName(match.awayTeamShortName, teams),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  void _scrollToCenter() {
    final double scrollPosition = _scrollController.position.maxScrollExtent / 2;
    _scrollController.animateTo(
      scrollPosition,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}