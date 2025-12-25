import '../../../../core/utils/either.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/models/base_response.dart';
import '../../../../core/network/error_handler.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../posts/data/models/post_model.dart';
import '../../../competitions/data/models/competition_model.dart';
import '../../../search/data/models/search_model.dart';
import '../../domain/repositories/explore_repository.dart';
import '../datasources/explore_api_service.dart';
import '../models/explore_model.dart';

/// Concrete implementation of ExploreRepository
class ExploreRepositoryImpl implements ExploreRepository {
  final ExploreApiService _apiService;

  ExploreRepositoryImpl(this._apiService);

  @override
  Future<Result<ExploreFeedModel>> getExploreFeed() async {
    return _apiService.getExploreFeed().safeApiCall(
      transform: (response) => response.data!,
    );
  }

  @override
  Future<Result<PaginatedResponse<PostModel>>> getDiscoverPosts({
    String? category,
    String? cursor,
    int limit = 20,
  }) async {
    return _apiService.getDiscoverPosts(
      category: category,
      cursor: cursor,
      limit: limit,
    ).safeApiCall(
      transform: (response) => response.data!,
    );
  }

  @override
  Future<Result<List<SimpleUserModel>>> getDiscoverUsers({int limit = 10}) async {
    return _apiService.getDiscoverUsers(limit: limit).safeApiCall(
      transform: (response) => response.data ?? [],
    );
  }

  @override
  Future<Result<List<CompetitionModel>>> getDiscoverCompetitions({int limit = 10}) async {
    return _apiService.getDiscoverCompetitions(limit: limit).safeApiCall(
      transform: (response) => response.data ?? [],
    );
  }

  @override
  Future<Result<List<PostModel>>> getTrendingPosts({int limit = 20}) async {
    return _apiService.getTrendingPosts(limit: limit).safeApiCall(
      transform: (response) => response.data ?? [],
    );
  }

  @override
  Future<Result<List<HashtagModel>>> getTrendingHashtags({int limit = 10}) async {
    return _apiService.getTrendingHashtags(limit: limit).safeApiCall(
      transform: (response) => response.data ?? [],
    );
  }

  @override
  Future<Result<List<SimpleUserModel>>> getTrendingCreators({int limit = 10}) async {
    return _apiService.getTrendingCreators(limit: limit).safeApiCall(
      transform: (response) => response.data ?? [],
    );
  }

  @override
  Future<Result<List<ExploreCategoryModel>>> getCategories() async {
    return _apiService.getCategories().safeApiCall(
      transform: (response) => response.data ?? [],
    );
  }

  @override
  Future<Result<PaginatedResponse<PostModel>>> getPostsByCategory(
    String categoryId, {
    String? cursor,
    int limit = 20,
  }) async {
    return _apiService.getPostsByCategory(
      categoryId,
      cursor: cursor,
      limit: limit,
    ).safeApiCall(
      transform: (response) => response.data!,
    );
  }

  @override
  Future<Result<HashtagDetailModel>> getHashtagDetail(String hashtag) async {
    return _apiService.getHashtagDetail(hashtag).safeApiCall(
      transform: (response) => response.data!,
    );
  }

  @override
  Future<Result<PaginatedResponse<PostModel>>> getPostsByHashtag(
    String hashtag, {
    String? cursor,
    int limit = 20,
  }) async {
    return _apiService.getPostsByHashtag(
      hashtag,
      cursor: cursor,
      limit: limit,
    ).safeApiCall(
      transform: (response) => response.data!,
    );
  }

  @override
  Future<Result<PaginatedResponse<PostModel>>> getForYouFeed({
    String? cursor,
    int limit = 20,
  }) async {
    return _apiService.getForYouFeed(cursor: cursor, limit: limit).safeApiCall(
      transform: (response) => response.data!,
    );
  }

  @override
  Future<Result<List<FeaturedContentModel>>> getFeaturedContent() async {
    return _apiService.getFeaturedContent().safeApiCall(
      transform: (response) => response.data ?? [],
    );
  }

  @override
  Future<Result<List<SimpleUserModel>>> getFeaturedCreators({int limit = 10}) async {
    return _apiService.getFeaturedCreators(limit: limit).safeApiCall(
      transform: (response) => response.data ?? [],
    );
  }
}
