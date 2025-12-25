import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/models/base_response.dart';
import '../../../posts/data/models/post_model.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../competitions/data/models/competition_model.dart';
import '../../../search/data/models/search_model.dart';
import '../models/explore_model.dart';

part 'explore_api_service.g.dart';

@RestApi()
abstract class ExploreApiService {
  factory ExploreApiService(Dio dio, {String baseUrl}) = _ExploreApiService;

  // Main explore feed - aggregated content
  @GET('/explore')
  Future<ApiResponse<ExploreFeedModel>> getExploreFeed();

  // Discover posts (grid view)
  @GET('/explore/posts')
  Future<ApiResponse<PaginatedResponse<PostModel>>> getDiscoverPosts({
    @Query('category') String? category,
    @Query('cursor') String? cursor,
    @Query('limit') int limit = 20,
  });

  // Discover users
  @GET('/explore/users')
  Future<ApiResponse<List<SimpleUserModel>>> getDiscoverUsers({
    @Query('limit') int limit = 10,
  });

  // Discover competitions
  @GET('/explore/competitions')
  Future<ApiResponse<List<CompetitionModel>>> getDiscoverCompetitions({
    @Query('limit') int limit = 10,
  });

  // Trending posts
  @GET('/explore/trending/posts')
  Future<ApiResponse<List<PostModel>>> getTrendingPosts({
    @Query('period') String? period, // 'day', 'week', 'month'
    @Query('limit') int limit = 20,
  });

  // Trending hashtags
  @GET('/explore/trending/hashtags')
  Future<ApiResponse<List<HashtagModel>>> getTrendingHashtags({
    @Query('limit') int limit = 10,
  });

  // Trending creators
  @GET('/explore/trending/creators')
  Future<ApiResponse<List<SimpleUserModel>>> getTrendingCreators({
    @Query('limit') int limit = 10,
  });

  // Categories
  @GET('/explore/categories')
  Future<ApiResponse<List<ExploreCategoryModel>>> getCategories();

  // Posts by category
  @GET('/explore/categories/{categoryId}/posts')
  Future<ApiResponse<PaginatedResponse<PostModel>>> getPostsByCategory(
    @Path('categoryId') String categoryId, {
    @Query('cursor') String? cursor,
    @Query('limit') int limit = 20,
  });

  // Hashtag detail
  @GET('/explore/hashtags/{hashtag}')
  Future<ApiResponse<HashtagDetailModel>> getHashtagDetail(
    @Path('hashtag') String hashtag,
  );

  // Posts by hashtag
  @GET('/explore/hashtags/{hashtag}/posts')
  Future<ApiResponse<PaginatedResponse<PostModel>>> getPostsByHashtag(
    @Path('hashtag') String hashtag, {
    @Query('cursor') String? cursor,
    @Query('limit') int limit = 20,
  });

  // For You personalized feed
  @GET('/explore/for-you')
  Future<ApiResponse<PaginatedResponse<PostModel>>> getForYouFeed({
    @Query('cursor') String? cursor,
    @Query('limit') int limit = 20,
  });

  // Featured content (banners, promoted content)
  @GET('/explore/featured')
  Future<ApiResponse<List<FeaturedContentModel>>> getFeaturedContent();

  // Featured creators
  @GET('/explore/featured/creators')
  Future<ApiResponse<List<SimpleUserModel>>> getFeaturedCreators({
    @Query('limit') int limit = 10,
  });

  // Suggested users to follow
  @GET('/explore/suggested-users')
  Future<ApiResponse<List<SimpleUserModel>>> getSuggestedUsers({
    @Query('limit') int limit = 10,
  });
}
