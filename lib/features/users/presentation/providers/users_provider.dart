/// Users state management using Riverpod
/// Handles user profiles, following, followers, and recommendations

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/repository_providers.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/models/base_response.dart';
import '../../../auth/data/models/user_model.dart';
import '../../domain/repositories/users_repository.dart';

// ============================================================================
// User Profile State
// ============================================================================

class UserProfileState {
  final UserProfileModel? user;
  final bool isLoading;
  final bool isFollowing;
  final String? errorMessage;

  const UserProfileState({
    this.user,
    this.isLoading = false,
    this.isFollowing = false,
    this.errorMessage,
  });

  UserProfileState copyWith({
    UserProfileModel? user,
    bool? isLoading,
    bool? isFollowing,
    String? errorMessage,
    bool clearError = false,
    bool clearUser = false,
  }) {
    return UserProfileState(
      user: clearUser ? null : (user ?? this.user),
      isLoading: isLoading ?? this.isLoading,
      isFollowing: isFollowing ?? this.isFollowing,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

// ============================================================================
// User Profile Notifier
// ============================================================================

class UserProfileNotifier extends StateNotifier<UserProfileState> {
  final UsersRepository _repository;

  UserProfileNotifier(this._repository) : super(const UserProfileState());

  /// Load user profile
  Future<void> loadUser(String userId) async {
    state = state.copyWith(isLoading: true, clearError: true, clearUser: true);

    final result = await _repository.getUserProfile(userId);

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message ?? 'Failed to load profile',
        );
      },
      (user) {
        state = state.copyWith(isLoading: false, user: user);
      },
    );
  }

  /// Toggle follow/unfollow
  Future<void> toggleFollow() async {
    if (state.user == null) return;

    final user = state.user!;
    final newIsFollowing = !(user.isFollowing ?? false);

    // Optimistic update
    state = state.copyWith(
      isFollowing: true,
      user: user.copyWith(
        isFollowing: newIsFollowing,
        followersCount: user.followersCount + (newIsFollowing ? 1 : -1),
      ),
    );

    final result = newIsFollowing
        ? await _repository.followUser(user.id)
        : await _repository.unfollowUser(user.id);

    result.fold(
      (failure) {
        // Revert on failure
        state = state.copyWith(isFollowing: false, user: user);
      },
      (_) {
        state = state.copyWith(isFollowing: false);
      },
    );
  }

  /// Block user
  Future<bool> blockUser() async {
    if (state.user == null) return false;

    final result = await _repository.blockUser(state.user!.id);

    return result.fold(
      (failure) => false,
      (_) {
        // Reload user profile to get updated isBlocked status
        loadUser(state.user!.id);
        return true;
      },
    );
  }

  /// Unblock user
  Future<bool> unblockUser() async {
    if (state.user == null) return false;

    final result = await _repository.unblockUser(state.user!.id);

    return result.fold(
      (failure) => false,
      (_) {
        // Reload user profile to get updated isBlocked status
        loadUser(state.user!.id);
        return true;
      },
    );
  }

  /// Clear state
  void clear() {
    state = const UserProfileState();
  }
}

// ============================================================================
// Followers/Following List State
// ============================================================================

class UserListState {
  final List<SimpleUserModel> users;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? cursor;
  final String? errorMessage;

  const UserListState({
    this.users = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.cursor,
    this.errorMessage,
  });

  UserListState copyWith({
    List<SimpleUserModel>? users,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    String? cursor,
    String? errorMessage,
    bool clearError = false,
  }) {
    return UserListState(
      users: users ?? this.users,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      cursor: cursor ?? this.cursor,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

// ============================================================================
// Providers
// ============================================================================

/// User profile provider - family for different user IDs
final userProfileProvider =
    StateNotifierProvider.family<UserProfileNotifier, UserProfileState, String>(
  (ref, userId) {
    final repository = ref.watch(usersRepositoryProvider);
    final notifier = UserProfileNotifier(repository);
    notifier.loadUser(userId);
    return notifier;
  },
);

/// User by username provider
final userByUsernameProvider =
    FutureProvider.family<UserProfileModel, String>((ref, username) async {
  final repository = ref.watch(usersRepositoryProvider);
  final result = await repository.getUserByUsername(username);
  return result.fold(
    (failure) => throw Exception(failure.message),
    (user) => user,
  );
});

/// Followers provider
final followersProvider =
    FutureProvider.family<PaginatedResponse<SimpleUserModel>, String>((ref, userId) async {
  final repository = ref.watch(usersRepositoryProvider);
  final result = await repository.getFollowers(userId);
  return result.fold(
    (failure) => throw Exception(failure.message),
    (response) => response,
  );
});

/// Following provider
final followingProvider =
    FutureProvider.family<PaginatedResponse<SimpleUserModel>, String>((ref, userId) async {
  final repository = ref.watch(usersRepositoryProvider);
  final result = await repository.getFollowing(userId);
  return result.fold(
    (failure) => throw Exception(failure.message),
    (response) => response,
  );
});

/// Suggested users provider
final suggestedUsersProvider = FutureProvider<List<SimpleUserModel>>((ref) async {
  final repository = ref.watch(usersRepositoryProvider);
  final result = await repository.getSuggestedUsers();
  return result.fold(
    (failure) => throw Exception(failure.message),
    (users) => users,
  );
});

/// Blocked users provider
final blockedUsersProvider = FutureProvider<List<SimpleUserModel>>((ref) async {
  final repository = ref.watch(usersRepositoryProvider);
  final result = await repository.getBlockedUsers();
  return result.fold(
    (failure) => throw Exception(failure.message),
    (response) => response.data,
  );
});

/// Mutual followers provider
final mutualFollowersProvider =
    FutureProvider.family<List<SimpleUserModel>, String>((ref, userId) async {
  final repository = ref.watch(usersRepositoryProvider);
  final result = await repository.getMutualFollowers(userId);
  return result.fold(
    (failure) => throw Exception(failure.message),
    (response) => response.data,
  );
});
