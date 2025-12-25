/// Notifications state management using Riverpod
/// Handles notification listing, marking as read, and badge counts

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/repository_providers.dart';
import '../../../../core/error/failures.dart';
import '../../data/models/notification_model.dart';
import '../../domain/repositories/notifications_repository.dart';

// ============================================================================
// Notifications State
// ============================================================================

class NotificationsState {
  final List<NotificationModel> notifications;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? cursor;
  final String? errorMessage;
  final int unreadCount;
  final NotificationType? filterType;

  const NotificationsState({
    this.notifications = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.cursor,
    this.errorMessage,
    this.unreadCount = 0,
    this.filterType,
  });

  NotificationsState copyWith({
    List<NotificationModel>? notifications,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    String? cursor,
    String? errorMessage,
    int? unreadCount,
    NotificationType? filterType,
    bool clearError = false,
    bool clearFilter = false,
  }) {
    return NotificationsState(
      notifications: notifications ?? this.notifications,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      cursor: cursor ?? this.cursor,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      unreadCount: unreadCount ?? this.unreadCount,
      filterType: clearFilter ? null : (filterType ?? this.filterType),
    );
  }
}

// ============================================================================
// Notifications Notifier
// ============================================================================

class NotificationsNotifier extends StateNotifier<NotificationsState> {
  final NotificationsRepository _repository;

  NotificationsNotifier(this._repository) : super(const NotificationsState());

  /// Load notifications
  Future<void> loadNotifications({
    bool refresh = false,
    NotificationType? type,
  }) async {
    if (state.isLoading) return;

    if (refresh) {
      state = state.copyWith(
        isLoading: true,
        notifications: [],
        cursor: null,
        hasMore: true,
        filterType: type,
        clearError: true,
      );
    } else {
      state = state.copyWith(isLoading: true, clearError: true);
    }

    final result = await _repository.getNotifications(
      type: type ?? state.filterType,
      limit: 20,
    );

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message ?? 'Failed to load notifications',
        );
      },
      (response) {
        state = state.copyWith(
          isLoading: false,
          notifications: response.data,
          cursor: response.nextCursor,
          hasMore: response.hasMore,
        );
        // Load unread count
        _loadUnreadCount();
      },
    );
  }

  /// Load more notifications
  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore || state.cursor == null) return;

    state = state.copyWith(isLoadingMore: true);

    final result = await _repository.getNotifications(
      type: state.filterType,
      cursor: state.cursor,
      limit: 20,
    );

    result.fold(
      (failure) {
        state = state.copyWith(isLoadingMore: false);
      },
      (response) {
        state = state.copyWith(
          isLoadingMore: false,
          notifications: [...state.notifications, ...response.data],
          cursor: response.nextCursor,
          hasMore: response.hasMore,
        );
      },
    );
  }

  /// Load unread count
  Future<void> _loadUnreadCount() async {
    final result = await _repository.getUnreadCount();
    result.fold(
      (failure) {},
      (unreadCountModel) {
        state = state.copyWith(unreadCount: unreadCountModel.total);
      },
    );
  }

  /// Refresh unread count
  Future<void> refreshUnreadCount() async {
    await _loadUnreadCount();
  }

  /// Mark notification as read
  Future<void> markAsRead(String notificationId) async {
    final result = await _repository.markAsRead(notificationId);

    result.fold(
      (failure) {},
      (_) {
        final index = state.notifications.indexWhere((n) => n.id == notificationId);
        if (index != -1) {
          final notification = state.notifications[index];
          if (!notification.isRead) {
            final newNotifications = [...state.notifications];
            newNotifications[index] = notification.copyWith(isRead: true);
            state = state.copyWith(
              notifications: newNotifications,
              unreadCount: state.unreadCount > 0 ? state.unreadCount - 1 : 0,
            );
          }
        }
      },
    );
  }

  /// Mark all as read
  Future<void> markAllAsRead() async {
    final result = await _repository.markAllAsRead();

    result.fold(
      (failure) {},
      (_) {
        final newNotifications = state.notifications
            .map((n) => n.copyWith(isRead: true))
            .toList();
        state = state.copyWith(
          notifications: newNotifications,
          unreadCount: 0,
        );
      },
    );
  }

  /// Delete notification
  Future<void> deleteNotification(String notificationId) async {
    final result = await _repository.deleteNotification(notificationId);

    result.fold(
      (failure) {},
      (_) {
        final notification = state.notifications.firstWhere(
          (n) => n.id == notificationId,
          orElse: () => NotificationModel(
            id: '',
            userId: '',
            type: NotificationType.like,
            title: '',
            createdAt: DateTime.now(),
          ),
        );
        state = state.copyWith(
          notifications: state.notifications.where((n) => n.id != notificationId).toList(),
          unreadCount: (!notification.isRead && state.unreadCount > 0)
              ? state.unreadCount - 1
              : state.unreadCount,
        );
      },
    );
  }

  /// Clear all notifications
  Future<void> clearAll() async {
    final result = await _repository.clearAllNotifications();

    result.fold(
      (failure) {},
      (_) {
        state = state.copyWith(
          notifications: [],
          unreadCount: 0,
        );
      },
    );
  }

  /// Set filter type
  void setFilter(NotificationType? type) {
    loadNotifications(refresh: true, type: type);
  }

  /// Clear filter
  void clearFilter() {
    state = state.copyWith(clearFilter: true);
    loadNotifications(refresh: true);
  }

  /// Add new notification (from push/real-time)
  void addNotification(NotificationModel notification) {
    state = state.copyWith(
      notifications: [notification, ...state.notifications],
      unreadCount: state.unreadCount + 1,
    );
  }
}

// ============================================================================
// Providers
// ============================================================================

/// Notifications provider
final notificationsProvider =
    StateNotifierProvider<NotificationsNotifier, NotificationsState>((ref) {
  final repository = ref.watch(notificationsRepositoryProvider);
  return NotificationsNotifier(repository);
});

/// Unread notifications count provider
final unreadNotificationsCountProvider = Provider<int>((ref) {
  return ref.watch(notificationsProvider).unreadCount;
});

/// Total badge count provider (notifications + messages)
final totalBadgeCountProvider = Provider<int>((ref) {
  final notificationCount = ref.watch(unreadNotificationsCountProvider);
  // Could add message count here too
  return notificationCount;
});
