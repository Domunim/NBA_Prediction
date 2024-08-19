import 'dart:collection';

class TeamModel {
  String name;
  String shortName;
  String logoPath;
  int conferencePlace;
  String record;
  HashMap lastGames;


  TeamModel({
    required this.name,
    required this.shortName,
    required this.logoPath,
    required this.conferencePlace,
    required this.record,
    required this.lastGames,
  });

    List<TeamModel> getTeams() {
      List<TeamModel> teams = [];

      // method to get list of teams from the API
      
      teams.add(
        TeamModel(
          name: "Mietkow Tractors",
          shortName: "MEM",
          logoPath: "assets/images/${shortName}.png",
          conferencePlace: 2,
          record: "73-9",
          lastGames: new HashMap<String, String>(), // dodać czy H czy A
        )
      );

      return teams;
  }

}