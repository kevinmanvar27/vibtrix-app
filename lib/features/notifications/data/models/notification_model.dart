import 'package:json_annotation/json_annotation.dart';
import '../../../auth/data/models/user_model.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel {
  final String id;
  final String userId;
  final NotificationType type;
  final String title;
  final String? body;
  final String? imageUrl;
  final NotificationDataModel? data;
  final SimpleUserModel? actor;
  final bool isRead;
  final DateTime createdAt;
  final DateTime? readAt;

  const NotificationModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.title,
    this.body,
    this.imageUrl,
    this.data,
    this.actor,
    this.isRead = false,
    required this.createdAt,
    this.readAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  NotificationModel copyWith({
    String? id,
    String? userId,
    NotificationType? type,
    String? title,
    String? body,
    String? imageUrl,
    NotificationDataModel? data,
    SimpleUserModel? actor,
    bool? isRead,
    DateTime? createdAt,
    DateTime? readAt,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      title: title ?? this.title,
      body: body ?? this.body,
      imageUrl: imageUrl ?? this.imageUrl,
      data: data ?? this.data,
      actor: actor ?? this.actor,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
      readAt: readAt ?? this.readAt,
    );
  }
}

enum NotificationType {
  @JsonValue('like')
  like,
  @JsonValue('comment')
  comment,
  @JsonValue('follow')
  follow,
  @JsonValue('follow_request')
  followRequest,
  @JsonValue('follow_accepted')
  followAccepted,
  @JsonValue('mention')
  mention,
  @JsonValue('competition_start')
  competitionStart,
  @JsonValue('competition_end')
  competitionEnd,
  @JsonValue('competition_result')
  competitionResult,
  @JsonValue('competition_reminder')
  competitionReminder,
  @JsonValue('new_message')
  newMessage,
  @JsonValue('payment')
  payment,
  @JsonValue('system')
  system,
}

@JsonSerializable()
class NotificationDataModel {
  final String? postId;
  final String? commentId;
  final String? competitionId;
  final String? chatId;
  final String? userId;
  final String? transactionId;
  final Map<String, dynamic>? extra;

  const NotificationDataModel({
    this.postId,
    this.commentId,
    this.competitionId,
    this.chatId,
    this.userId,
    this.transactionId,
    this.extra,
  });

  factory NotificationDataModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationDataModelToJson(this);
}

@JsonSerializable()
class UnreadCountModel {
  final int total;
  final int likes;
  final int comments;
  final int follows;
  final int competitions;
  final int messages;
  final int system;

  const UnreadCountModel({
    this.total = 0,
    this.likes = 0,
    this.comments = 0,
    this.follows = 0,
    this.competitions = 0,
    this.messages = 0,
    this.system = 0,
  });

  factory UnreadCountModel.fromJson(Map<String, dynamic> json) =>
      _$UnreadCountModelFromJson(json);

  Map<String, dynamic> toJson() => _$UnreadCountModelToJson(this);
}

@JsonSerializable()
class DeviceTokenModel {
  final String id;
  final String userId;
  final String token;
  final String platform;
  final String? deviceId;
  final String? deviceName;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? lastUsedAt;

  const DeviceTokenModel({
    required this.id,
    required this.userId,
    required this.token,
    required this.platform,
    this.deviceId,
    this.deviceName,
    this.isActive = true,
    required this.createdAt,
    this.lastUsedAt,
  });

  factory DeviceTokenModel.fromJson(Map<String, dynamic> json) =>
      _$DeviceTokenModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceTokenModelToJson(this);
}

// ============ REQUEST MODELS ============

@JsonSerializable()
class RegisterDeviceRequest {
  final String token;
  final String platform;
  final String? deviceId;
  final String? deviceName;

  const RegisterDeviceRequest({
    required this.token,
    required this.platform,
    this.deviceId,
    this.deviceName,
  });

  factory RegisterDeviceRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterDeviceRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterDeviceRequestToJson(this);
}

@JsonSerializable()
class MarkNotificationsReadRequest {
  final List<String>? notificationIds;
  final bool markAll;

  const MarkNotificationsReadRequest({
    this.notificationIds,
    this.markAll = false,
  });

  factory MarkNotificationsReadRequest.fromJson(Map<String, dynamic> json) =>
      _$MarkNotificationsReadRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MarkNotificationsReadRequestToJson(this);
}
