// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FollowResponse _$FollowResponseFromJson(Map<String, dynamic> json) =>
    FollowResponse(
      success: json['success'] as bool,
      message: json['message'] as String?,
      isFollowing: json['isFollowing'] as bool?,
    );

Map<String, dynamic> _$FollowResponseToJson(FollowResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'isFollowing': instance.isFollowing,
    };

FollowStatusResponse _$FollowStatusResponseFromJson(
  Map<String, dynamic> json,
) => FollowStatusResponse(
  isFollowing: json['isFollowing'] as bool,
  isFollowedBy: json['isFollowedBy'] as bool,
  isPending: json['isPending'] as bool? ?? false,
);

Map<String, dynamic> _$FollowStatusResponseToJson(
  FollowStatusResponse instance,
) => <String, dynamic>{
  'isFollowing': instance.isFollowing,
  'isFollowedBy': instance.isFollowedBy,
  'isPending': instance.isPending,
};

BlockStatusResponse _$BlockStatusResponseFromJson(Map<String, dynamic> json) =>
    BlockStatusResponse(
      isBlocked: json['isBlocked'] as bool,
      isBlockedBy: json['isBlockedBy'] as bool? ?? false,
    );

Map<String, dynamic> _$BlockStatusResponseToJson(
  BlockStatusResponse instance,
) => <String, dynamic>{
  'isBlocked': instance.isBlocked,
  'isBlockedBy': instance.isBlockedBy,
};

ReportUserRequest _$ReportUserRequestFromJson(Map<String, dynamic> json) =>
    ReportUserRequest(
      reason: json['reason'] as String,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$ReportUserRequestToJson(ReportUserRequest instance) =>
    <String, dynamic>{
      'reason': instance.reason,
      'description': instance.description,
    };
