import 'package:json_annotation/json_annotation.dart';

part 'users_models.g.dart';

/// Response from follow/unfollow actions
@JsonSerializable()
class FollowResponse {
  final bool success;
  final String? message;
  final bool? isFollowing;

  const FollowResponse({
    required this.success,
    this.message,
    this.isFollowing,
  });

  factory FollowResponse.fromJson(Map<String, dynamic> json) =>
      _$FollowResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FollowResponseToJson(this);
}

@JsonSerializable()
class FollowStatusResponse {
  final bool isFollowing;
  final bool isFollowedBy;
  final bool isPending;

  const FollowStatusResponse({
    required this.isFollowing,
    required this.isFollowedBy,
    this.isPending = false,
  });

  factory FollowStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$FollowStatusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FollowStatusResponseToJson(this);
}

@JsonSerializable()
class BlockStatusResponse {
  final bool isBlocked;
  final bool isBlockedBy;

  const BlockStatusResponse({
    required this.isBlocked,
    this.isBlockedBy = false,
  });

  factory BlockStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$BlockStatusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BlockStatusResponseToJson(this);
}

@JsonSerializable()
class ReportUserRequest {
  final String reason;
  final String? description;

  const ReportUserRequest({
    required this.reason,
    this.description,
  });

  factory ReportUserRequest.fromJson(Map<String, dynamic> json) =>
      _$ReportUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ReportUserRequestToJson(this);
}
