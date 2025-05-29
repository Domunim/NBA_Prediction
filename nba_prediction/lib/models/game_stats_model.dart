class GameStats {
  final int teamPoints;
  final int opponentPoints;
  final double teamFieldGoalPct;
  final double teamFreeThrowPct;
  final double teamThreePointPct;
  final int teamAssists;
  final int teamRebounds;
  final int teamSteals;
  final int teamBlocks;
  final int teamTurnovers;
  final int teamFouls;
  final double opponentFieldGoalPct;
  final double opponentFreeThrowPct;
  final double opponentThreePointPct;
  final int opponentAssists;
  final int opponentRebounds;
  final int opponentSteals;
  final int opponentBlocks;
  final int opponentTurnovers;
  final int opponentFouls;

  GameStats({
    required this.teamPoints,
    required this.opponentPoints,
    required this.teamFieldGoalPct,
    required this.teamFreeThrowPct,
    required this.teamThreePointPct,
    required this.teamAssists,
    required this.teamRebounds,
    required this.teamSteals,
    required this.teamBlocks,
    required this.teamTurnovers,
    required this.teamFouls,
    required this.opponentFieldGoalPct,
    required this.opponentFreeThrowPct,
    required this.opponentThreePointPct,
    required this.opponentAssists,
    required this.opponentRebounds,
    required this.opponentSteals,
    required this.opponentBlocks,
    required this.opponentTurnovers,
    required this.opponentFouls,
  });

  factory GameStats.fromJson(Map<String, dynamic> json) {
    return GameStats(
      // Team stats
      teamPoints: json['teamPoints'] as int? ?? 0,
      teamFieldGoalPct: (json['teamFieldGoalPct'] as num?)?.toDouble() ?? 0.0,
      teamFreeThrowPct: (json['teamFreeThrowPct'] as num?)?.toDouble() ?? 0.0,
      teamThreePointPct: (json['teamThreePointPct'] as num?)?.toDouble() ?? 0.0,
      teamAssists: json['teamAssists'] as int? ?? 0,
      teamRebounds: json['teamRebounds'] as int? ?? 0,
      teamSteals: json['teamSteals'] as int? ?? 0,
      teamBlocks: json['teamBlocks'] as int? ?? 0,
      teamTurnovers: json['teamTurnovers'] as int? ?? 0,
      teamFouls: json['teamFouls'] as int? ?? 0,

      // Opponent stats
      opponentPoints: json['opponentPoints'] as int? ?? 0,
      opponentFieldGoalPct: (json['opponentFieldGoalPct'] as num?)?.toDouble() ?? 0.0,
      opponentFreeThrowPct: (json['opponentFreeThrowPct'] as num?)?.toDouble() ?? 0.0,
      opponentThreePointPct: (json['opponentThreePointPct'] as num?)?.toDouble() ?? 0.0,
      opponentAssists: json['opponentAssists'] as int? ?? 0,
      opponentRebounds: json['opponentRebounds'] as int? ?? 0,
      opponentSteals: json['opponentSteals'] as int? ?? 0,
      opponentBlocks: json['opponentBlocks'] as int? ?? 0,
      opponentTurnovers: json['opponentTurnovers'] as int? ?? 0,
      opponentFouls: json['opponentFouls'] as int? ?? 0,
    );
  }
}