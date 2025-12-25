import 'package:json_annotation/json_annotation.dart';
import '../../../auth/data/models/user_model.dart';

part 'competition_model.g.dart';

@JsonSerializable()
class CompetitionModel {
  final String id;
  final String name;
  final String? description;
  final String? thumbnailUrl;
  final String? bannerUrl;
  final CompetitionStatus status;
  final CompetitionType type;
  final int participantsCount;
  final int maxParticipants;
  final int prizePool;
  final String? currency;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime? registrationDeadline;
  final int entryFee;
  final bool isParticipating;
  final bool isFeatured;
  final List<CompetitionRoundModel>? rounds;
  final List<PrizeModel>? prizes;
  final CompetitionRulesModel? rules;
  final SimpleUserModel? creator;
  final DateTime createdAt;

  const CompetitionModel({
    required this.id,
    required this.name,
    this.description,
    this.thumbnailUrl,
    this.bannerUrl,
    required this.status,
    required this.type,
    this.participantsCount = 0,
    this.maxParticipants = 0,
    this.prizePool = 0,
    this.currency,
    required this.startDate,
    required this.endDate,
    this.registrationDeadline,
    this.entryFee = 0,
    this.isParticipating = false,
    this.isFeatured = false,
    this.rounds,
    this.prizes,
    this.rules,
    this.creator,
    required this.createdAt,
  });

  factory CompetitionModel.fromJson(Map<String, dynamic> json) =>
      _$CompetitionModelFromJson(json);

  Map<String, dynamic> toJson() => _$CompetitionModelToJson(this);

  bool get isActive => status == CompetitionStatus.active;
  bool get isUpcoming => status == CompetitionStatus.upcoming;
  bool get isCompleted => status == CompetitionStatus.completed;
  bool get canJoin => 
      (status == CompetitionStatus.upcoming || status == CompetitionStatus.active) &&
      !isParticipating &&
      (maxParticipants == 0 || participantsCount < maxParticipants);

  CompetitionModel copyWith({
    String? id,
    String? name,
    String? description,
    String? thumbnailUrl,
    String? bannerUrl,
    CompetitionStatus? status,
    CompetitionType? type,
    int? participantsCount,
    int? maxParticipants,
    int? prizePool,
    String? currency,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? registrationDeadline,
    int? entryFee,
    bool? isParticipating,
    bool? isFeatured,
    List<CompetitionRoundModel>? rounds,
    List<PrizeModel>? prizes,
    CompetitionRulesModel? rules,
    SimpleUserModel? creator,
    DateTime? createdAt,
  }) {
    return CompetitionModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      bannerUrl: bannerUrl ?? this.bannerUrl,
      status: status ?? this.status,
      type: type ?? this.type,
      participantsCount: participantsCount ?? this.participantsCount,
      maxParticipants: maxParticipants ?? this.maxParticipants,
      prizePool: prizePool ?? this.prizePool,
      currency: currency ?? this.currency,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      registrationDeadline: registrationDeadline ?? this.registrationDeadline,
      entryFee: entryFee ?? this.entryFee,
      isParticipating: isParticipating ?? this.isParticipating,
      isFeatured: isFeatured ?? this.isFeatured,
      rounds: rounds ?? this.rounds,
      prizes: prizes ?? this.prizes,
      rules: rules ?? this.rules,
      creator: creator ?? this.creator,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

enum CompetitionStatus {
  @JsonValue('draft')
  draft,
  @JsonValue('upcoming')
  upcoming,
  @JsonValue('active')
  active,
  @JsonValue('voting')
  voting,
  @JsonValue('completed')
  completed,
  @JsonValue('cancelled')
  cancelled,
}

enum CompetitionType {
  @JsonValue('single_elimination')
  singleElimination,
  @JsonValue('double_elimination')
  doubleElimination,
  @JsonValue('round_robin')
  roundRobin,
  @JsonValue('voting')
  voting,
  @JsonValue('leaderboard')
  leaderboard,
}

@JsonSerializable()
class CompetitionRoundModel {
  final String id;
  final String competitionId;
  final int roundNumber;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final RoundStatus status;
  final int participantsCount;

  const CompetitionRoundModel({
    required this.id,
    required this.competitionId,
    required this.roundNumber,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.status,
    this.participantsCount = 0,
  });

  factory CompetitionRoundModel.fromJson(Map<String, dynamic> json) =>
      _$CompetitionRoundModelFromJson(json);

  Map<String, dynamic> toJson() => _$CompetitionRoundModelToJson(this);
}

enum RoundStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('active')
  active,
  @JsonValue('completed')
  completed,
}

@JsonSerializable()
class PrizeModel {
  final int rank;
  final int amount;
  final String? currency;
  final String? description;
  final String? badgeUrl;

  const PrizeModel({
    required this.rank,
    required this.amount,
    this.currency,
    this.description,
    this.badgeUrl,
  });

  factory PrizeModel.fromJson(Map<String, dynamic> json) =>
      _$PrizeModelFromJson(json);

  Map<String, dynamic> toJson() => _$PrizeModelToJson(this);
}

@JsonSerializable()
class CompetitionRulesModel {
  final int? minVideoDuration;
  final int? maxVideoDuration;
  final List<String>? allowedFormats;
  final String? theme;
  final List<String>? guidelines;

  const CompetitionRulesModel({
    this.minVideoDuration,
    this.maxVideoDuration,
    this.allowedFormats,
    this.theme,
    this.guidelines,
  });

  factory CompetitionRulesModel.fromJson(Map<String, dynamic> json) =>
      _$CompetitionRulesModelFromJson(json);

  Map<String, dynamic> toJson() => _$CompetitionRulesModelToJson(this);
}

@JsonSerializable()
class ParticipantModel {
  final String id;
  final String competitionId;
  final String userId;
  final SimpleUserModel? user;
  final String? postId;
  final int rank;
  final int votes;
  final int score;
  final ParticipantStatus status;
  final DateTime joinedAt;

  const ParticipantModel({
    required this.id,
    required this.competitionId,
    required this.userId,
    this.user,
    this.postId,
    this.rank = 0,
    this.votes = 0,
    this.score = 0,
    required this.status,
    required this.joinedAt,
  });

  factory ParticipantModel.fromJson(Map<String, dynamic> json) =>
      _$ParticipantModelFromJson(json);

  Map<String, dynamic> toJson() => _$ParticipantModelToJson(this);
}

enum ParticipantStatus {
  @JsonValue('registered')
  registered,
  @JsonValue('active')
  active,
  @JsonValue('eliminated')
  eliminated,
  @JsonValue('winner')
  winner,
  @JsonValue('disqualified')
  disqualified,
}

@JsonSerializable()
class LeaderboardEntryModel {
  final int rank;
  final String odUserId;
  final SimpleUserModel? user;
  final int votes;
  final int score;
  final String? postId;
  final String? thumbnailUrl;

  const LeaderboardEntryModel({
    required this.rank,
    required this.odUserId,
    this.user,
    this.votes = 0,
    this.score = 0,
    this.postId,
    this.thumbnailUrl,
  });

  factory LeaderboardEntryModel.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardEntryModelFromJson(json);

  Map<String, dynamic> toJson() => _$LeaderboardEntryModelToJson(this);
}

// ============ REQUEST MODELS ============

@JsonSerializable()
class CreateCompetitionRequest {
  final String name;
  final String? description;
  final String? thumbnailUrl;
  final String? bannerUrl;
  final CompetitionType type;
  final int? maxParticipants;
  final int? prizePool;
  final String? currency;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime? registrationDeadline;
  final int? entryFee;
  final CompetitionRulesModel? rules;
  final List<PrizeModel>? prizes;

  const CreateCompetitionRequest({
    required this.name,
    this.description,
    this.thumbnailUrl,
    this.bannerUrl,
    required this.type,
    this.maxParticipants,
    this.prizePool,
    this.currency,
    required this.startDate,
    required this.endDate,
    this.registrationDeadline,
    this.entryFee,
    this.rules,
    this.prizes,
  });

  factory CreateCompetitionRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateCompetitionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateCompetitionRequestToJson(this);
}

@JsonSerializable()
class UpdateCompetitionRequest {
  final String? name;
  final String? description;
  final String? thumbnailUrl;
  final String? bannerUrl;
  final int? maxParticipants;
  final int? prizePool;
  final String? currency;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? registrationDeadline;
  final int? entryFee;
  final CompetitionRulesModel? rules;
  final List<PrizeModel>? prizes;

  const UpdateCompetitionRequest({
    this.name,
    this.description,
    this.thumbnailUrl,
    this.bannerUrl,
    this.maxParticipants,
    this.prizePool,
    this.currency,
    this.startDate,
    this.endDate,
    this.registrationDeadline,
    this.entryFee,
    this.rules,
    this.prizes,
  });

  factory UpdateCompetitionRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateCompetitionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateCompetitionRequestToJson(this);
}

@JsonSerializable()
class JoinCompetitionRequest {
  final String? postId;
  final String? paymentId;

  const JoinCompetitionRequest({
    this.postId,
    this.paymentId,
  });

  factory JoinCompetitionRequest.fromJson(Map<String, dynamic> json) =>
      _$JoinCompetitionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$JoinCompetitionRequestToJson(this);
}

@JsonSerializable()
class CompetitionCategoryModel {
  final String id;
  final String name;
  final String? description;
  final String? iconUrl;

  const CompetitionCategoryModel({
    required this.id,
    required this.name,
    this.description,
    this.iconUrl,
  });

  factory CompetitionCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CompetitionCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CompetitionCategoryModelToJson(this);
}
