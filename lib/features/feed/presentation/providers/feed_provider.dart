/// Feed state management using Riverpod
/// Handles feed loading, pagination, and post interactions

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/repository_providers.dart';
import '../../../../core/error/failures.dart';
import '../../../posts/data/models/post_model.dart';
import '../../../posts/domain/repositories/posts_repository.dart';

// ============================================================================
// Feed State
// ============================================================================

/// Represents the current feed state
class FeedState {
  final List<PostModel> posts;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? cursor;
  final String? errorMessage;
  final FeedType feedType;

  const FeedState({
    this.posts = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.cursor,
    this.errorMessage,
    this.feedType = FeedType.forYou,
  });

  FeedState copyWith({
    List<PostModel>? posts,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    String? cursor,
    String? errorMessage,
    FeedType? feedType,
    bool clearError = false,
  }) {
    return FeedState(
      posts: posts ?? this.posts,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      cursor: cursor ?? this.cursor,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      feedType: feedType ?? this.feedType,
    );
  }

  factory FeedState.initial() => const FeedState();
}

enum FeedType { forYou, following }

// ============================================================================
// Feed Notifier
// ============================================================================

class FeedNotifier extends StateNotifier<FeedState> {
  final PostsRepository _repository;

  FeedNotifier(this._repository) : super(FeedState.initial()) {
    loadFeed();
  }

  /// Load initial feed
  Future<void> loadFeed({FeedType? feedType}) async {
    final type = feedType ?? state.feedType;
    state = state.copyWith(
      isLoading: true,
      clearError: true,
      feedType: type,
      posts: [],
      cursor: null,
      hasMore: true,
    );

    final result = type == FeedType.forYou
        ? await _repository.getFeed()
        : await _repository.getFollowingFeed();

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: _getErrorMessage(failure),
        );
      },
      (response) {
        state = state.copyWith(
          isLoading: false,
          posts: response.items,
          cursor: response.nextCursor,
          hasMore: response.hasMore,
        );
      },
    );
  }

  /// Load more posts (pagination)
  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore || state.cursor == null) return;

    state = state.copyWith(isLoadingMore: true);

    final result = state.feedType == FeedType.forYou
        ? await _repository.getFeed(cursor: state.cursor)
        : await _repository.getFollowingFeed(cursor: state.cursor);

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoadingMore: false,
          errorMessage: _getErrorMessage(failure),
        );
      },
      (response) {
        state = state.copyWith(
          isLoadingMore: false,
          posts: [...state.posts, ...response.items],
          cursor: response.nextCursor,
          hasMore: response.hasMore,
        );
      },
    );
  }

  /// Refresh feed
  Future<void> refresh() async {
    await loadFeed(feedType: state.feedType);
  }

  /// Switch feed type
  Future<void> switchFeedType(FeedType type) async {
    if (type == state.feedType) return;
    await loadFeed(feedType: type);
  }

  /// Like a post
  Future<void> likePost(String postId) async {
    // Optimistic update
    _updatePostInList(postId, (post) => post.copyWith(
      isLiked: true,
      likesCount: post.likesCount + 1,
    ));

    final result = await _repository.likePost(postId);

    result.fold(
      (failure) {
        // Revert on failure
        _updatePostInList(postId, (post) => post.copyWith(
          isLiked: false,
          likesCount: post.likesCount - 1,
        ));
      },
      (_) {},
    );
  }

  /// Unlike a post
  Future<void> unlikePost(String postId) async {
    // Optimistic update
    _updatePostInList(postId, (post) => post.copyWith(
      isLiked: false,
      likesCount: post.likesCount - 1,
    ));

    final result = await _repository.unlikePost(postId);

    result.fold(
      (failure) {
        // Revert on failure
        _updatePostInList(postId, (post) => post.copyWith(
          isLiked: true,
          likesCount: post.likesCount + 1,
        ));
      },
      (_) {},
    );
  }

  /// Save a post
  Future<void> savePost(String postId) async {
    _updatePostInList(postId, (post) => post.copyWith(isBookmarked: true));

    final result = await _repository.savePost(postId);

    result.fold(
      (failure) {
        _updatePostInList(postId, (post) => post.copyWith(isBookmarked: false));
      },
      (_) {},
    );
  }

  /// Unsave a post
  Future<void> unsavePost(String postId) async {
    _updatePostInList(postId, (post) => post.copyWith(isBookmarked: false));

    final result = await _repository.unsavePost(postId);

    result.fold(
      (failure) {
        _updatePostInList(postId, (post) => post.copyWith(isBookmarked: true));
      },
      (_) {},
    );
  }

  /// Share a post
  Future<void> sharePost(String postId) async {
    await _repository.sharePost(postId);
    _updatePostInList(postId, (post) => post.copyWith(
      sharesCount: post.sharesCount + 1,
    ));
  }

  /// Remove post from feed (after delete or hide)
  void removePost(String postId) {
    state = state.copyWith(
      posts: state.posts.where((p) => p.id != postId).toList(),
    );
  }

  /// Helper to update a post in the list
  void _updatePostInList(String postId, PostModel Function(PostModel) update) {
    state = state.copyWith(
      posts: state.posts.map((post) {
        if (post.id == postId) {
          return update(post);
        }
        return post;
      }).toList(),
    );
  }

  /// Clear error message
  void clearError() {
    state = state.copyWith(clearError: true);
  }

  /// Convert failure to user-friendly message
  String _getErrorMessage(Failure failure) {
    if (failure is NetworkFailure) {
      return 'No internet connection. Please check your network.';
    } else if (failure is ServerFailure) {
      return 'Server error. Please try again later.';
    } else if (failure is AuthFailure) {
      return 'Please log in to view your feed.';
    }
    return failure.message ?? 'Failed to load feed.';
  }
}

// ============================================================================
// Providers
// ============================================================================

/// Main feed state provider
final feedProvider = StateNotifierProvider<FeedNotifier, FeedState>((ref) {
  final repository = ref.watch(postsRepositoryProvider);
  return FeedNotifier(repository);
});

/// Current feed type provider (convenience)
final feedTypeProvider = Provider<FeedType>((ref) {
  return ref.watch(feedProvider).feedType;
});

/// Feed loading provider (convenience)
final feedLoadingProvider = Provider<bool>((ref) {
  return ref.watch(feedProvider).isLoading;
});

/// Feed error provider (convenience)
final feedErrorProvider = Provider<String?>((ref) {
  return ref.watch(feedProvider).errorMessage;
});

/// Feed posts provider (convenience)
final feedPostsProvider = Provider<List<PostModel>>((ref) {
  return ref.watch(feedProvider).posts;
});

/// Single post provider by ID
final postByIdProvider = Provider.family<PostModel?, String>((ref, postId) {
  final posts = ref.watch(feedProvider).posts;
  try {
    return posts.firstWhere((p) => p.id == postId);
  } catch (_) {
    return null;
  }
});

/// Trending posts provider
final trendingPostsProvider = FutureProvider.family<List<PostModel>, String?>((ref, period) async {
  final repository = ref.watch(postsRepositoryProvider);
  final result = await repository.getTrendingPosts(period: period);
  return result.fold(
    (failure) => throw Exception(failure.message),
    (response) => response.items,
  );
});

/// Saved posts provider
final savedPostsProvider = FutureProvider<List<PostModel>>((ref) async {
  final repository = ref.watch(postsRepositoryProvider);
  final result = await repository.getSavedPosts();
  return result.fold(
    (failure) => throw Exception(failure.message),
    (response) => response.items,
  );
});

/// User posts provider
final userPostsProvider = FutureProvider.family<List<PostModel>, String>((ref, userId) async {
  final repository = ref.watch(postsRepositoryProvider);
  final result = await repository.getUserPosts(userId);
  return result.fold(
    (failure) => throw Exception(failure.message),
    (response) => response.items,
  );
});
