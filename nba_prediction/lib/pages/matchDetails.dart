import 'package:flutter/material.dart';
import 'package:nba_prediction/models/match_model.dart';
import 'package:nba_prediction/models/team_model.dart';
import 'package:nba_prediction/widgets/appBar.dart';

class MatchDetails extends StatelessWidget {
  final MatchModel match;
  final List<TeamModel> teams;

  const MatchDetails({super.key, required this.match, required this.teams});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20.0),
              
              // Time
              Text(
                "${match.date.hour.toString().padLeft(2, '0')}:${match.date.minute.toString().padLeft(2, '0')}",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  
                  // Home Team
                  Expanded(
                    child: Column(
                      children: [
                        Hero(
                          tag: '${match.homeTeamShortName}-logo',
                          child: Image.asset(
                            'assets/images/${match.homeTeamShortName}.png',
                            width: 100.0,
                            height: 100.0,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          TeamModel.getTeamName(match.homeTeamShortName, teams),
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
        
                  // Odds
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${match.oddsForHomeTeam}% : ${match.oddsForAwayTeam}%",
                          style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
        
                  // Away Team
                  Expanded(
                    child: Column(
                      children: [
                        Hero(
                          tag: '${match.awayTeamShortName}-logo',
                          child: Image.asset(
                            'assets/images/${match.awayTeamShortName}.png',
                            width: 100.0,
                            height: 100.0,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          TeamModel.getTeamName(match.awayTeamShortName, teams),
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
        
              const SizedBox(height: 40.0),
        
              // Additional details
              Text(
                "Match Venue: ${match.homeTeamShortName} Area",
                style: const TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 20.0),
              const Text(
                "TODO - Additional info and previous match lists to be added",
                style: TextStyle(fontSize: 18.0, color: Colors.grey),
              ),
            ],
          ),
        ),
    );
  }
}
