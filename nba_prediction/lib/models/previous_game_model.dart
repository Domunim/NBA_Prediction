class PreviousGame {
  final String gameId;
  final DateTime gameDate;
  final String teamTricode;
  final String teamName;
  final int teamPoints;
  final String opponentTricode;
  final String opponentName;
  final int opponentPoints;
  final String gameLocation;

  PreviousGame({
    required this.gameId,
    required this.gameDate,
    required this.teamTricode,
    required this.teamName,
    required this.teamPoints,
    required this.opponentTricode,
    required this.opponentName,
    required this.opponentPoints,
    required this.gameLocation,
  });

  factory PreviousGame.fromJson(Map<String, dynamic> json) {
    return PreviousGame(
      gameId: json['gameId'],
      gameDate: DateTime.parse(json['gameDate']),
      teamTricode: json['teamTricode'],
      teamName: json['teamName'],
      teamPoints: json['teamPoints'],
      opponentTricode: json['opponentTricode'],
      opponentName: json['opponentName'],
      opponentPoints: json['opponentPoints'],
      gameLocation: json['gameLocation'],
    );
  }

  bool get isHome => gameLocation.toLowerCase() == 'h' || gameLocation.toLowerCase() == 'home';
}