import 'package:dio/dio.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/network/error_handler.dart';
import '../../../../core/models/base_response.dart';
import '../../domain/repositories/notifications_repository.dart';
import '../datasources/notifications_api_service.dart';
import '../models/notification_model.dart';

/// Implementation of NotificationsRepository
class NotificationsRepositoryImpl implements NotificationsRepository {
  final NotificationsApiService _apiService;

  NotificationsRepositoryImpl({required NotificationsApiService apiService})
      : _apiService = apiService;

  @override
  Future<Result<PaginatedResponse<NotificationModel>>> getNotifications({
    NotificationType? type,
    bool? unreadOnly,
    String? cursor,
    int limit = 20,
  }) async {
    try {
      final response = await _apiService.getNotifications(
        type: type?.name,
        unreadOnly: unreadOnly,
        cursor: cursor,
        limit: limit,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<void>> deleteNotification(String notificationId) async {
    try {
      await _apiService.deleteNotification(notificationId);
      return const Right(null);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<void>> clearAllNotifications() async {
    try {
      await _apiService.clearAllNotifications();
      return const Right(null);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<void>> markAsRead(String notificationId) async {
    try {
      await _apiService.markAsRead(notificationId);
      return const Right(null);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<void>> markAllAsRead() async {
    try {
      await _apiService.markAllAsRead();
      return const Right(null);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<UnreadCountModel>> getUnreadCount() async {
    try {
      final count = await _apiService.getUnreadCount();
      return Right(count);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<DeviceTokenModel>> registerDevice(RegisterDeviceRequest request) async {
    try {
      final token = await _apiService.registerDevice(request);
      return Right(token);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<void>> unregisterDevice(String deviceId) async {
    try {
      await _apiService.unregisterDevice(deviceId);
      return const Right(null);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<DeviceTokenModel>> updateDevice(
    String deviceId,
    UpdateDeviceRequest request,
  ) async {
    try {
      final token = await _apiService.updateDevice(deviceId, request);
      return Right(token);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<NotificationSettingsResponse>> getNotificationSettings() async {
    try {
      final settings = await _apiService.getNotificationSettings();
      return Right(settings);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<NotificationSettingsResponse>> updateNotificationSettings(
    UpdateNotificationSettingsRequest request,
  ) async {
    try {
      final settings = await _apiService.updateNotificationSettings(request);
      return Right(settings);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }
}
