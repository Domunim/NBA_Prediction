import 'dart:collection';

class TeamModel {
  String name;
  String shortName;
  int conferencePlace;
  String record;
  HashMap lastGames;


  TeamModel({
    required this.name,
    required this.shortName,
    required this.conferencePlace,
    required this.record,
    required this.lastGames,
  });

    static List<TeamModel> getTeams() {
      List<TeamModel> teams = [];

      // method to get list of teams from the API
      
      teams.add(
        TeamModel(
          name: "Memphis Grizzlies",
          shortName: "MEM",
          conferencePlace: 2,
          record: "50-32",
          lastGames: new HashMap<String, String>(), // dodać czy H czy A
        )
      );
      
      teams.add(
        TeamModel(
          name: "Minnesota Timberwolves",
          shortName: "MIN",
          conferencePlace: 3,
          record: "47-35",
          lastGames: new HashMap<String, String>(), // dodać czy H czy A
        )
      );
            
      teams.add(
        TeamModel(
          name: "Brooklyn Nets",
          shortName: "BKN",
          conferencePlace: 4,
          record: "42-40",
          lastGames: new HashMap<String, String>(), // dodać czy H czy A
        )
      );
      
      teams.add(
        TeamModel(
          name: "Golden State Warriors",
          shortName: "GSW",
          conferencePlace: 1,
          record: "73-9",
          lastGames: new HashMap<String, String>(), // dodać czy H czy A
        )
      );
      
      teams.add(
        TeamModel(
          name: "Chicago Bulls",
          shortName: "CHI",
          conferencePlace: 8,
          record: "14-68",
          lastGames: new HashMap<String, String>(), // dodać czy H czy A
        )
      );
      
      teams.add(
        TeamModel(
          name: "Los Angeles Lakers",
          shortName: "LAL",
          conferencePlace: 5,
          record: "51-31",
          lastGames: new HashMap<String, String>(), // dodać czy H czy A
        )
      );
      
      teams.add(
        TeamModel(
          name: "Denver Nuggets",
          shortName: "DEN",
          conferencePlace: 2,
          record: "68-16",
          lastGames: new HashMap<String, String>(), // dodać czy H czy A
        )
      );
      
      teams.add(
        TeamModel(
          name: "Dallas Mavericks",
          shortName: "DAL",
          conferencePlace: 6,
          record: "53-29",
          lastGames: new HashMap<String, String>(), // dodać czy H czy A
        )
      );   

      teams.add(
        TeamModel(
          name: "Los Angeles Clippers",
          shortName: "LAC",
          conferencePlace: 3,
          record: "49-33",
          lastGames: new HashMap<String, String>(), // dodać czy H czy A
        )
      );   

      teams.add(
        TeamModel(
          name: "Washington Wizards",
          shortName: "WAS",
          conferencePlace: 7,
          record: "29-53",
          lastGames: new HashMap<String, String>(), // dodać czy H czy A
        )
      );

      return teams;
  }

  static String getTeamName(String shortName, List<TeamModel> teamsList) {
      return teamsList.where((TeamModel t) => t.shortName == shortName).first.name;
  }
}