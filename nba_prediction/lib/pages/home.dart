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

  void getData() {
    getTeams();
    getMatches();
  }

  void getTeams() {
    teams = []; // fix
  }

  void getMatches() {
    matches = MatchModel.getMatches();
  }


  @override
  void initState() {
    getData();
  }



  @override
  Widget build(BuildContext context) {
    getData();
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
              itemCount: 10, // demo
              // itemCount: matches.lenght,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: ListTile(
                    title: Text('Card ${index + 1}'), // demo
                    subtitle: Text('Placeholder for match ${index + 1}'), // demo
                  ),
                );
              },
            ),
          );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
        title: Image.asset('assets/images/NBA_predictor_logo.png', 
        fit: BoxFit.fill),
        centerTitle: true,
        //backgroundColor: Colors.blueGrey,
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        // toolbarHeight: 88,
        leading: GestureDetector(
          onTap: () {
            

          },
          child:Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(10),
            child: SvgPicture.asset(
              'assets/icons/dark_light_mode_icon.svg',
              height: 30,
              width: 30,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).secondaryHeaderColor,
              borderRadius: BorderRadius.circular(10)
            ),
          ),
        ),
    );
  }
}