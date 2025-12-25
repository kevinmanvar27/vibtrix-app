/// Explore state management using Riverpod
/// Handles discover feed, trending content, categories, and hashtags

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/repository_providers.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/models/base_response.dart';
import '../../../posts/data/models/post_model.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../search/data/models/search_model.dart';
import '../../data/models/explore_model.dart';
import '../../domain/repositories/explore_repository.dart';

// ============================================================================
// Explore State
// ============================================================================

class ExploreState {
  final ExploreFeedModel? exploreFeed;
  final List<PostModel> discoverPosts;
  final List<PostModel> trendingPosts;
  final List<SimpleUserModel> suggestedUsers;
  final List<HashtagModel> trendingHashtags;
  final List<ExploreCategoryModel> categories;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? cursor;
  final String? errorMessage;

  const ExploreState({
    this.exploreFeed,
    this.discoverPosts = const [],
    this.trendingPosts = const [],
    this.suggestedUsers = const [],
    this.trendingHashtags = const [],
    this.categories = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.cursor,
    this.errorMessage,
  });

  ExploreState copyWith({
    ExploreFeedModel? exploreFeed,
    List<PostModel>? discoverPosts,
    List<PostModel>? trendingPosts,
    List<SimpleUserModel>? suggestedUsers,
    List<HashtagModel>? trendingHashtags,
    List<ExploreCategoryModel>? categories,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    String? cursor,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ExploreState(
      exploreFeed: exploreFeed ?? this.exploreFeed,
      discoverPosts: discoverPosts ?? this.discoverPosts,
      trendingPosts: trendingPosts ?? this.trendingPosts,
      suggestedUsers: suggestedUsers ?? this.suggestedUsers,
      trendingHashtags: trendingHashtags ?? this.trendingHashtags,
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      cursor: cursor ?? this.cursor,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

// ============================================================================
// Explore Notifier
// ============================================================================

class ExploreNotifier extends StateNotifier<ExploreState> {
  final ExploreRepository _repository;

  ExploreNotifier(this._repository) : super(const ExploreState()) {
    loadExplore();
  }

  /// Load all explore content
  Future<void> loadExplore() async {
    state = state.copyWith(isLoading: true, clearError: true);

    // Load main explore feed
    final result = await _repository.getExploreFeed();
    
    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message ?? 'Failed to load explore feed',
        );
      },
      (feed) {
        state = state.copyWith(
          isLoading: false,
          exploreFeed: feed,
          trendingPosts: feed.trendingPosts ?? [],
          trendingHashtags: feed.trendingHashtags ?? [],
          suggestedUsers: feed.suggestedUsers ?? [],
          categories: feed.categories ?? [],
        );
      },
    );

    // Also load discover posts separately for pagination
    await _loadDiscoverPosts();
  }

  /// Refresh explore content
  Future<void> refresh() async {
    state = state.copyWith(
      cursor: null,
      hasMore: true,
    );
    await loadExplore();
  }

  /// Load discover posts
  Future<void> _loadDiscoverPosts() async {
    final result = await _repository.getDiscoverPosts();
    result.fold(
      (failure) {},
      (response) {
        state = state.copyWith(
          discoverPosts: response.data,
          hasMore: response.hasMore ?? true,
          cursor: response.nextCursor,
        );
      },
    );
  }

  /// Load more discover posts
  Future<void> loadMoreDiscover() async {
    if (state.isLoadingMore || !state.hasMore || state.cursor == null) return;

    state = state.copyWith(isLoadingMore: true);

    final result = await _repository.getDiscoverPosts(cursor: state.cursor);

    result.fold(
      (failure) {
        state = state.copyWith(isLoadingMore: false);
      },
      (response) {
        state = state.copyWith(
          isLoadingMore: false,
          discoverPosts: [...state.discoverPosts, ...response.data],
          hasMore: response.hasMore ?? false,
          cursor: response.nextCursor,
        );
      },
    );
  }

  /// Load trending posts
  Future<void> loadTrendingPosts() async {
    final result = await _repository.getTrendingPosts();
    result.fold(
      (failure) {},
      (posts) {
        state = state.copyWith(trendingPosts: posts);
      },
    );
  }

  /// Load suggested users
  Future<void> loadSuggestedUsers() async {
    final result = await _repository.getDiscoverUsers();
    result.fold(
      (failure) {},
      (users) {
        state = state.copyWith(suggestedUsers: users);
      },
    );
  }

  /// Load trending hashtags
  Future<void> loadTrendingHashtags() async {
    final result = await _repository.getTrendingHashtags();
    result.fold(
      (failure) {},
      (hashtags) {
        state = state.copyWith(trendingHashtags: hashtags);
      },
    );
  }

  /// Load categories
  Future<void> loadCategories() async {
    final result = await _repository.getCategories();
    result.fold(
      (failure) {},
      (categories) {
        state = state.copyWith(categories: categories);
      },
    );
  }

  /// Follow suggested user and remove from suggestions
  /// Note: Actual follow API call should be made via users repository
  void followSuggestedUser(String userId) {
    // Remove user from suggestions after following
    removeSuggestedUser(userId);
  }

  /// Remove suggested user from list
  void removeSuggestedUser(String userId) {
    final users = state.suggestedUsers.where((u) => u.id != userId).toList();
    state = state.copyWith(suggestedUsers: users);
  }
}

// ============================================================================
// Category Posts State
// ============================================================================

class CategoryPostsState {
  final ExploreCategoryModel? category;
  final List<PostModel> posts;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? cursor;
  final String? errorMessage;

  const CategoryPostsState({
    this.category,
    this.posts = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.cursor,
    this.errorMessage,
  });

  CategoryPostsState copyWith({
    ExploreCategoryModel? category,
    List<PostModel>? posts,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    String? cursor,
    String? errorMessage,
    bool clearError = false,
  }) {
    return CategoryPostsState(
      category: category ?? this.category,
      posts: posts ?? this.posts,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      cursor: cursor ?? this.cursor,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

// ============================================================================
// Category Posts Notifier
// ============================================================================

class CategoryPostsNotifier extends StateNotifier<CategoryPostsState> {
  final ExploreRepository _repository;
  final String categoryId;

  CategoryPostsNotifier(this._repository, this.categoryId)
      : super(const CategoryPostsState()) {
    loadCategory();
  }

  /// Load category posts
  Future<void> loadCategory() async {
    state = state.copyWith(isLoading: true, clearError: true);

    // Load posts
    final postsResult = await _repository.getPostsByCategory(categoryId);
    postsResult.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message ?? 'Failed to load posts',
        );
      },
      (response) {
        state = state.copyWith(
          isLoading: false,
          posts: response.data,
          hasMore: response.hasMore ?? false,
          cursor: response.nextCursor,
        );
      },
    );
  }

  /// Load more posts
  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore || state.cursor == null) return;

    state = state.copyWith(isLoadingMore: true);

    final result = await _repository.getPostsByCategory(
      categoryId,
      cursor: state.cursor,
    );

    result.fold(
      (failure) {
        state = state.copyWith(isLoadingMore: false);
      },
      (response) {
        state = state.copyWith(
          isLoadingMore: false,
          posts: [...state.posts, ...response.data],
          hasMore: response.hasMore ?? false,
          cursor: response.nextCursor,
        );
      },
    );
  }

  /// Refresh posts
  Future<void> refresh() async {
    state = state.copyWith(cursor: null, hasMore: true);
    await loadCategory();
  }
}

// ============================================================================
// Hashtag Detail State
// ============================================================================

class HashtagDetailState {
  final HashtagDetailModel? hashtag;
  final List<PostModel> posts;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? cursor;
  final String? errorMessage;

  const HashtagDetailState({
    this.hashtag,
    this.posts = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.cursor,
    this.errorMessage,
  });

  HashtagDetailState copyWith({
    HashtagDetailModel? hashtag,
    List<PostModel>? posts,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    String? cursor,
    String? errorMessage,
    bool clearError = false,
  }) {
    return HashtagDetailState(
      hashtag: hashtag ?? this.hashtag,
      posts: posts ?? this.posts,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      cursor: cursor ?? this.cursor,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

// ============================================================================
// Hashtag Detail Notifier
// ============================================================================

class HashtagDetailNotifier extends StateNotifier<HashtagDetailState> {
  final ExploreRepository _repository;
  final String hashtag;

  HashtagDetailNotifier(this._repository, this.hashtag)
      : super(const HashtagDetailState()) {
    loadHashtag();
  }

  /// Load hashtag detail and posts
  Future<void> loadHashtag() async {
    state = state.copyWith(isLoading: true, clearError: true);

    // Load hashtag details
    final detailResult = await _repository.getHashtagDetail(hashtag);
    detailResult.fold(
      (failure) {},
      (detail) {
        state = state.copyWith(hashtag: detail);
      },
    );

    // Load posts
    final postsResult = await _repository.getPostsByHashtag(hashtag);
    postsResult.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message ?? 'Failed to load posts',
        );
      },
      (response) {
        state = state.copyWith(
          isLoading: false,
          posts: response.data,
          hasMore: response.hasMore ?? false,
          cursor: response.nextCursor,
        );
      },
    );
  }

  /// Load more posts
  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore || state.cursor == null) return;

    state = state.copyWith(isLoadingMore: true);

    final result = await _repository.getPostsByHashtag(
      hashtag,
      cursor: state.cursor,
    );

    result.fold(
      (failure) {
        state = state.copyWith(isLoadingMore: false);
      },
      (response) {
        state = state.copyWith(
          isLoadingMore: false,
          posts: [...state.posts, ...response.data],
          hasMore: response.hasMore ?? false,
          cursor: response.nextCursor,
        );
      },
    );
  }

  /// Refresh
  Future<void> refresh() async {
    state = state.copyWith(cursor: null, hasMore: true);
    await loadHashtag();
  }
}

// ============================================================================
// Providers
// ============================================================================

/// Main explore provider
final exploreProvider =
    StateNotifierProvider<ExploreNotifier, ExploreState>((ref) {
  final repository = ref.watch(exploreRepositoryProvider);
  return ExploreNotifier(repository);
});

/// Discover posts provider (convenience)
final discoverPostsProvider = Provider<List<PostModel>>((ref) {
  final explore = ref.watch(exploreProvider);
  return explore.discoverPosts;
});

/// Trending posts provider (convenience)
final trendingPostsProvider = Provider<List<PostModel>>((ref) {
  final explore = ref.watch(exploreProvider);
  return explore.trendingPosts;
});

/// Suggested users provider (from explore)
final exploreSuggestedUsersProvider = Provider<List<SimpleUserModel>>((ref) {
  final explore = ref.watch(exploreProvider);
  return explore.suggestedUsers;
});

/// Trending hashtags provider
final trendingHashtagsProvider = Provider<List<HashtagModel>>((ref) {
  final explore = ref.watch(exploreProvider);
  return explore.trendingHashtags;
});

/// Categories provider
final categoriesProvider = Provider<List<ExploreCategoryModel>>((ref) {
  final explore = ref.watch(exploreProvider);
  return explore.categories;
});

/// Category posts provider - family for different categories
final categoryPostsProvider = StateNotifierProvider.family<
    CategoryPostsNotifier, CategoryPostsState, String>(
  (ref, categoryId) {
    final repository = ref.watch(exploreRepositoryProvider);
    return CategoryPostsNotifier(repository, categoryId);
  },
);

/// Hashtag detail provider - family for different hashtags
final hashtagDetailProvider = StateNotifierProvider.family<
    HashtagDetailNotifier, HashtagDetailState, String>(
  (ref, hashtag) {
    final repository = ref.watch(exploreRepositoryProvider);
    return HashtagDetailNotifier(repository, hashtag);
  },
);

/// For You feed provider (personalized)
final forYouFeedProvider =
    FutureProvider<PaginatedResponse<PostModel>>((ref) async {
  final repository = ref.watch(exploreRepositoryProvider);
  final result = await repository.getForYouFeed();
  return result.fold(
    (failure) => throw Exception(failure.message),
    (response) => response,
  );
});

/// Featured content provider
final featuredContentProvider =
    FutureProvider<List<FeaturedContentModel>>((ref) async {
  final repository = ref.watch(exploreRepositoryProvider);
  final result = await repository.getFeaturedContent();
  return result.fold(
    (failure) => throw Exception(failure.message),
    (content) => content,
  );
});

/// Featured creators provider
final featuredCreatorsProvider =
    FutureProvider<List<SimpleUserModel>>((ref) async {
  final repository = ref.watch(exploreRepositoryProvider);
  final result = await repository.getFeaturedCreators();
  return result.fold(
    (failure) => throw Exception(failure.message),
    (creators) => creators,
  );
});
