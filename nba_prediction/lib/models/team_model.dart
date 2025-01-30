class Team {
  final String teamId;
  final String teamName;
  final String teamTricode;

  Team({
    required this.teamId,
    required this.teamName,
    required this.teamTricode,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      teamId: json['teamId'],
      teamName: json['teamName'],
      teamTricode: json['teamTricode'],
    );
  }
}