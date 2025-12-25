import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/models/base_response.dart';
import '../models/notification_model.dart';

part 'notifications_api_service.g.dart';

@RestApi()
abstract class NotificationsApiService {
  factory NotificationsApiService(Dio dio, {String baseUrl}) = _NotificationsApiService;

  // Notification endpoints
  @GET('/notifications')
  Future<PaginatedResponse<NotificationModel>> getNotifications({
    @Query('type') String? type,
    @Query('unread') bool? unreadOnly,
    @Query('cursor') String? cursor,
    @Query('limit') int limit = 20,
  });

  @GET('/notifications/unread-count')
  Future<UnreadCountModel> getUnreadCount();

  @POST('/notifications/{notificationId}/read')
  Future<void> markAsRead(@Path('notificationId') String notificationId);

  @POST('/notifications/read-all')
  Future<void> markAllAsRead();

  @DELETE('/notifications/{notificationId}')
  Future<void> deleteNotification(@Path('notificationId') String notificationId);

  @DELETE('/notifications')
  Future<void> clearAllNotifications();

  // Device token management for push notifications
  @POST('/notifications/devices')
  Future<DeviceTokenModel> registerDevice(@Body() RegisterDeviceRequest request);

  @DELETE('/notifications/devices/{deviceId}')
  Future<void> unregisterDevice(@Path('deviceId') String deviceId);

  @PUT('/notifications/devices/{deviceId}')
  Future<DeviceTokenModel> updateDevice(
    @Path('deviceId') String deviceId,
    @Body() UpdateDeviceRequest request,
  );

  // Notification settings
  @GET('/notifications/settings')
  Future<NotificationSettingsResponse> getNotificationSettings();

  @PUT('/notifications/settings')
  Future<NotificationSettingsResponse> updateNotificationSettings(
    @Body() UpdateNotificationSettingsRequest request,
  );
}

// Additional request/response models
@JsonSerializable()
class UpdateDeviceRequest {
  final String? token;
  final bool? enabled;

  UpdateDeviceRequest({this.token, this.enabled});

  factory UpdateDeviceRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateDeviceRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateDeviceRequestToJson(this);
}

@JsonSerializable()
class NotificationSettingsResponse {
  final bool pushEnabled;
  final bool emailEnabled;
  final bool likesEnabled;
  final bool commentsEnabled;
  final bool followsEnabled;
  final bool mentionsEnabled;
  final bool competitionUpdates;
  final bool chatMessages;

  NotificationSettingsResponse({
    required this.pushEnabled,
    required this.emailEnabled,
    required this.likesEnabled,
    required this.commentsEnabled,
    required this.followsEnabled,
    required this.mentionsEnabled,
    required this.competitionUpdates,
    required this.chatMessages,
  });

  factory NotificationSettingsResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationSettingsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationSettingsResponseToJson(this);
}

@JsonSerializable()
class UpdateNotificationSettingsRequest {
  final bool? pushEnabled;
  final bool? emailEnabled;
  final bool? likesEnabled;
  final bool? commentsEnabled;
  final bool? followsEnabled;
  final bool? mentionsEnabled;
  final bool? competitionUpdates;
  final bool? chatMessages;

  UpdateNotificationSettingsRequest({
    this.pushEnabled,
    this.emailEnabled,
    this.likesEnabled,
    this.commentsEnabled,
    this.followsEnabled,
    this.mentionsEnabled,
    this.competitionUpdates,
    this.chatMessages,
  });

  factory UpdateNotificationSettingsRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateNotificationSettingsRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateNotificationSettingsRequestToJson(this);
}
