// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'competition_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompetitionModel _$CompetitionModelFromJson(
  Map<String, dynamic> json,
) => CompetitionModel(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  thumbnailUrl: json['thumbnailUrl'] as String?,
  bannerUrl: json['bannerUrl'] as String?,
  status: $enumDecode(_$CompetitionStatusEnumMap, json['status']),
  type: $enumDecode(_$CompetitionTypeEnumMap, json['type']),
  participantsCount: (json['participantsCount'] as num?)?.toInt() ?? 0,
  maxParticipants: (json['maxParticipants'] as num?)?.toInt() ?? 0,
  prizePool: (json['prizePool'] as num?)?.toInt() ?? 0,
  currency: json['currency'] as String?,
  startDate: DateTime.parse(json['startDate'] as String),
  endDate: DateTime.parse(json['endDate'] as String),
  registrationDeadline:
      json['registrationDeadline'] == null
          ? null
          : DateTime.parse(json['registrationDeadline'] as String),
  entryFee: (json['entryFee'] as num?)?.toInt() ?? 0,
  isParticipating: json['isParticipating'] as bool? ?? false,
  isFeatured: json['isFeatured'] as bool? ?? false,
  rounds:
      (json['rounds'] as List<dynamic>?)
          ?.map(
            (e) => CompetitionRoundModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
  prizes:
      (json['prizes'] as List<dynamic>?)
          ?.map((e) => PrizeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  rules:
      json['rules'] == null
          ? null
          : CompetitionRulesModel.fromJson(
            json['rules'] as Map<String, dynamic>,
          ),
  creator:
      json['creator'] == null
          ? null
          : SimpleUserModel.fromJson(json['creator'] as Map<String, dynamic>),
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$CompetitionModelToJson(CompetitionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'thumbnailUrl': instance.thumbnailUrl,
      'bannerUrl': instance.bannerUrl,
      'status': _$CompetitionStatusEnumMap[instance.status]!,
      'type': _$CompetitionTypeEnumMap[instance.type]!,
      'participantsCount': instance.participantsCount,
      'maxParticipants': instance.maxParticipants,
      'prizePool': instance.prizePool,
      'currency': instance.currency,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'registrationDeadline': instance.registrationDeadline?.toIso8601String(),
      'entryFee': instance.entryFee,
      'isParticipating': instance.isParticipating,
      'isFeatured': instance.isFeatured,
      'rounds': instance.rounds,
      'prizes': instance.prizes,
      'rules': instance.rules,
      'creator': instance.creator,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$CompetitionStatusEnumMap = {
  CompetitionStatus.draft: 'draft',
  CompetitionStatus.upcoming: 'upcoming',
  CompetitionStatus.active: 'active',
  CompetitionStatus.voting: 'voting',
  CompetitionStatus.completed: 'completed',
  CompetitionStatus.cancelled: 'cancelled',
};

const _$CompetitionTypeEnumMap = {
  CompetitionType.singleElimination: 'single_elimination',
  CompetitionType.doubleElimination: 'double_elimination',
  CompetitionType.roundRobin: 'round_robin',
  CompetitionType.voting: 'voting',
  CompetitionType.leaderboard: 'leaderboard',
};

CompetitionRoundModel _$CompetitionRoundModelFromJson(
  Map<String, dynamic> json,
) => CompetitionRoundModel(
  id: json['id'] as String,
  competitionId: json['competitionId'] as String,
  roundNumber: (json['roundNumber'] as num).toInt(),
  name: json['name'] as String,
  startDate: DateTime.parse(json['startDate'] as String),
  endDate: DateTime.parse(json['endDate'] as String),
  status: $enumDecode(_$RoundStatusEnumMap, json['status']),
  participantsCount: (json['participantsCount'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$CompetitionRoundModelToJson(
  CompetitionRoundModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'competitionId': instance.competitionId,
  'roundNumber': instance.roundNumber,
  'name': instance.name,
  'startDate': instance.startDate.toIso8601String(),
  'endDate': instance.endDate.toIso8601String(),
  'status': _$RoundStatusEnumMap[instance.status]!,
  'participantsCount': instance.participantsCount,
};

const _$RoundStatusEnumMap = {
  RoundStatus.pending: 'pending',
  RoundStatus.active: 'active',
  RoundStatus.completed: 'completed',
};

PrizeModel _$PrizeModelFromJson(Map<String, dynamic> json) => PrizeModel(
  rank: (json['rank'] as num).toInt(),
  amount: (json['amount'] as num).toInt(),
  currency: json['currency'] as String?,
  description: json['description'] as String?,
  badgeUrl: json['badgeUrl'] as String?,
);

Map<String, dynamic> _$PrizeModelToJson(PrizeModel instance) =>
    <String, dynamic>{
      'rank': instance.rank,
      'amount': instance.amount,
      'currency': instance.currency,
      'description': instance.description,
      'badgeUrl': instance.badgeUrl,
    };

CompetitionRulesModel _$CompetitionRulesModelFromJson(
  Map<String, dynamic> json,
) => CompetitionRulesModel(
  minVideoDuration: (json['minVideoDuration'] as num?)?.toInt(),
  maxVideoDuration: (json['maxVideoDuration'] as num?)?.toInt(),
  allowedFormats:
      (json['allowedFormats'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
  theme: json['theme'] as String?,
  guidelines:
      (json['guidelines'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$CompetitionRulesModelToJson(
  CompetitionRulesModel instance,
) => <String, dynamic>{
  'minVideoDuration': instance.minVideoDuration,
  'maxVideoDuration': instance.maxVideoDuration,
  'allowedFormats': instance.allowedFormats,
  'theme': instance.theme,
  'guidelines': instance.guidelines,
};

ParticipantModel _$ParticipantModelFromJson(Map<String, dynamic> json) =>
    ParticipantModel(
      id: json['id'] as String,
      competitionId: json['competitionId'] as String,
      userId: json['userId'] as String,
      user:
          json['user'] == null
              ? null
              : SimpleUserModel.fromJson(json['user'] as Map<String, dynamic>),
      postId: json['postId'] as String?,
      rank: (json['rank'] as num?)?.toInt() ?? 0,
      votes: (json['votes'] as num?)?.toInt() ?? 0,
      score: (json['score'] as num?)?.toInt() ?? 0,
      status: $enumDecode(_$ParticipantStatusEnumMap, json['status']),
      joinedAt: DateTime.parse(json['joinedAt'] as String),
    );

Map<String, dynamic> _$ParticipantModelToJson(ParticipantModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'competitionId': instance.competitionId,
      'userId': instance.userId,
      'user': instance.user,
      'postId': instance.postId,
      'rank': instance.rank,
      'votes': instance.votes,
      'score': instance.score,
      'status': _$ParticipantStatusEnumMap[instance.status]!,
      'joinedAt': instance.joinedAt.toIso8601String(),
    };

const _$ParticipantStatusEnumMap = {
  ParticipantStatus.registered: 'registered',
  ParticipantStatus.active: 'active',
  ParticipantStatus.eliminated: 'eliminated',
  ParticipantStatus.winner: 'winner',
  ParticipantStatus.disqualified: 'disqualified',
};

LeaderboardEntryModel _$LeaderboardEntryModelFromJson(
  Map<String, dynamic> json,
) => LeaderboardEntryModel(
  rank: (json['rank'] as num).toInt(),
  odUserId: json['odUserId'] as String,
  user:
      json['user'] == null
          ? null
          : SimpleUserModel.fromJson(json['user'] as Map<String, dynamic>),
  votes: (json['votes'] as num?)?.toInt() ?? 0,
  score: (json['score'] as num?)?.toInt() ?? 0,
  postId: json['postId'] as String?,
  thumbnailUrl: json['thumbnailUrl'] as String?,
);

Map<String, dynamic> _$LeaderboardEntryModelToJson(
  LeaderboardEntryModel instance,
) => <String, dynamic>{
  'rank': instance.rank,
  'odUserId': instance.odUserId,
  'user': instance.user,
  'votes': instance.votes,
  'score': instance.score,
  'postId': instance.postId,
  'thumbnailUrl': instance.thumbnailUrl,
};

CreateCompetitionRequest _$CreateCompetitionRequestFromJson(
  Map<String, dynamic> json,
) => CreateCompetitionRequest(
  name: json['name'] as String,
  description: json['description'] as String?,
  thumbnailUrl: json['thumbnailUrl'] as String?,
  bannerUrl: json['bannerUrl'] as String?,
  type: $enumDecode(_$CompetitionTypeEnumMap, json['type']),
  maxParticipants: (json['maxParticipants'] as num?)?.toInt(),
  prizePool: (json['prizePool'] as num?)?.toInt(),
  currency: json['currency'] as String?,
  startDate: DateTime.parse(json['startDate'] as String),
  endDate: DateTime.parse(json['endDate'] as String),
  registrationDeadline:
      json['registrationDeadline'] == null
          ? null
          : DateTime.parse(json['registrationDeadline'] as String),
  entryFee: (json['entryFee'] as num?)?.toInt(),
  rules:
      json['rules'] == null
          ? null
          : CompetitionRulesModel.fromJson(
            json['rules'] as Map<String, dynamic>,
          ),
  prizes:
      (json['prizes'] as List<dynamic>?)
          ?.map((e) => PrizeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$CreateCompetitionRequestToJson(
  CreateCompetitionRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
  'thumbnailUrl': instance.thumbnailUrl,
  'bannerUrl': instance.bannerUrl,
  'type': _$CompetitionTypeEnumMap[instance.type]!,
  'maxParticipants': instance.maxParticipants,
  'prizePool': instance.prizePool,
  'currency': instance.currency,
  'startDate': instance.startDate.toIso8601String(),
  'endDate': instance.endDate.toIso8601String(),
  'registrationDeadline': instance.registrationDeadline?.toIso8601String(),
  'entryFee': instance.entryFee,
  'rules': instance.rules,
  'prizes': instance.prizes,
};

UpdateCompetitionRequest _$UpdateCompetitionRequestFromJson(
  Map<String, dynamic> json,
) => UpdateCompetitionRequest(
  name: json['name'] as String?,
  description: json['description'] as String?,
  thumbnailUrl: json['thumbnailUrl'] as String?,
  bannerUrl: json['bannerUrl'] as String?,
  maxParticipants: (json['maxParticipants'] as num?)?.toInt(),
  prizePool: (json['prizePool'] as num?)?.toInt(),
  currency: json['currency'] as String?,
  startDate:
      json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
  endDate:
      json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
  registrationDeadline:
      json['registrationDeadline'] == null
          ? null
          : DateTime.parse(json['registrationDeadline'] as String),
  entryFee: (json['entryFee'] as num?)?.toInt(),
  rules:
      json['rules'] == null
          ? null
          : CompetitionRulesModel.fromJson(
            json['rules'] as Map<String, dynamic>,
          ),
  prizes:
      (json['prizes'] as List<dynamic>?)
          ?.map((e) => PrizeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$UpdateCompetitionRequestToJson(
  UpdateCompetitionRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
  'thumbnailUrl': instance.thumbnailUrl,
  'bannerUrl': instance.bannerUrl,
  'maxParticipants': instance.maxParticipants,
  'prizePool': instance.prizePool,
  'currency': instance.currency,
  'startDate': instance.startDate?.toIso8601String(),
  'endDate': instance.endDate?.toIso8601String(),
  'registrationDeadline': instance.registrationDeadline?.toIso8601String(),
  'entryFee': instance.entryFee,
  'rules': instance.rules,
  'prizes': instance.prizes,
};

JoinCompetitionRequest _$JoinCompetitionRequestFromJson(
  Map<String, dynamic> json,
) => JoinCompetitionRequest(
  postId: json['postId'] as String?,
  paymentId: json['paymentId'] as String?,
);

Map<String, dynamic> _$JoinCompetitionRequestToJson(
  JoinCompetitionRequest instance,
) => <String, dynamic>{
  'postId': instance.postId,
  'paymentId': instance.paymentId,
};

CompetitionCategoryModel _$CompetitionCategoryModelFromJson(
  Map<String, dynamic> json,
) => CompetitionCategoryModel(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  iconUrl: json['iconUrl'] as String?,
);

Map<String, dynamic> _$CompetitionCategoryModelToJson(
  CompetitionCategoryModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'iconUrl': instance.iconUrl,
};
