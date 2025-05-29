class Team {
  final int teamId;
  final String teamName;
  final String teamCity;
  final String teamTricode;
  final String teamSlug;
  final int wins;
  final int losses;
  final int score;
  final int seed;
  final double? winProbability; // Only in upcoming games

  Team({
    required this.teamId,
    required this.teamName,
    required this.teamCity,
    required this.teamTricode,
    required this.teamSlug,
    required this.wins,
    required this.losses,
    required this.score,
    required this.seed,
    this.winProbability,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      teamId: json['teamId'],
      teamName: json['teamName'],
      teamCity: json['teamCity'],
      teamTricode: json['teamTricode'],
      teamSlug: json['teamSlug'],
      wins: json['wins'],
      losses: json['losses'],
      score: json['score'],
      seed: json['seed'],
      winProbability: (json['winProbability'] != null)
        ? (json['winProbability'] as num).toDouble()
        : null,
    );
  }
}