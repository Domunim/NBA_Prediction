import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nba_prediction/models/match_model.dart';
import 'package:nba_prediction/models/team_model.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MatchModel> matches = [];
  List<TeamModel> teams = [];
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


  @override
  Widget build(BuildContext context) {
    getTeamsAndMatches();
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: appBar(context),
      body: Column(children: [
          dateBar(),
          matchList(),
        ],
      ),
    );
  }

  Container dateBar() {
    return Container(
      height: 60.0,
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(7, (index) {
              DateTime date = DateTime.now().add(Duration(days: index - 3));
              String label = index == 3 ? "Today" : "${date.day}.${date.month}";
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Chip(
                  label: Text(label),
                  ),
                );
              }),
            ),
          ),
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

  Card matchCard(MatchModel match) {
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
                          Image.asset(
                            'assets/images/${match.homeTeamShortName}.png',
                            width: 60.0,
                            height: 60.0,
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
                          Image.asset(
                            'assets/images/${match.awayTeamShortName}.png',
                            width: 60.0,
                            height: 60.0,
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

  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      // Remove `leading` to avoid any element on the left side
      title: Image.asset(
        'assets/images/NBA_predictor_logo.png',
        fit: BoxFit.contain,
        height: 100,
      ),
      centerTitle: true,
      actions: [
        GestureDetector(
          onTap: () {
            // Dark mode TODO
          },
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(10),
            child: SvgPicture.asset(
              'assets/icons/dark_light_mode_icon.svg',
              height: 30,
              width: 30,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).secondaryHeaderColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
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