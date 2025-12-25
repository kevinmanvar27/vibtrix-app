import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/models/base_response.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../posts/data/models/post_model.dart';
import '../models/users_models.dart';

part 'users_api_service.g.dart';

@RestApi()
abstract class UsersApiService {
  factory UsersApiService(Dio dio, {String baseUrl}) = _UsersApiService;

  @GET('/users/{userId}')
  Future<UserProfileModel> getUserProfile(@Path('userId') String userId);

  @GET('/users/username/{username}')
  Future<UserProfileModel> getUserByUsername(@Path('username') String username);

  @GET('/users/suggested')
  Future<List<SimpleUserModel>> getSuggestedUsers({
    @Query('limit') int limit = 10,
  });

  @GET('/users/search')
  Future<PaginatedResponse<SimpleUserModel>> searchUsers({
    @Query('query') required String query,
    @Query('cursor') String? cursor,
    @Query('limit') int limit = 20,
  });

  @GET('/users/{userId}/posts')
  Future<PaginatedResponse<PostModel>> getUserPosts(
    @Path('userId') String userId, {
    @Query('cursor') String? cursor,
    @Query('limit') int limit = 20,
  });

  // Follow System
  @POST('/users/{userId}/followers')
  Future<FollowResponse> followUser(@Path('userId') String userId);

  @DELETE('/users/{userId}/followers')
  Future<void> unfollowUser(@Path('userId') String userId);

  @GET('/users/{userId}/followers/list')
  Future<PaginatedResponse<SimpleUserModel>> getFollowers(
    @Path('userId') String userId, {
    @Query('cursor') String? cursor,
    @Query('limit') int limit = 20,
  });

  @GET('/users/{userId}/following/list')
  Future<PaginatedResponse<SimpleUserModel>> getFollowing(
    @Path('userId') String userId, {
    @Query('cursor') String? cursor,
    @Query('limit') int limit = 20,
  });

  @GET('/users/{userId}/mutual-followers')
  Future<PaginatedResponse<SimpleUserModel>> getMutualFollowers(
    @Path('userId') String userId, {
    @Query('cursor') String? cursor,
    @Query('limit') int limit = 20,
  });

  @GET('/users/{userId}/follow-status')
  Future<FollowStatusResponse> checkFollowStatus(@Path('userId') String userId);

  // Follow Requests (for private accounts)
  @POST('/users/{userId}/follow-request')
  Future<void> sendFollowRequest(@Path('userId') String userId);

  @POST('/users/{userId}/follow-request/accept')
  Future<void> acceptFollowRequest(@Path('userId') String userId);

  @POST('/users/{userId}/follow-request/reject')
  Future<void> rejectFollowRequest(@Path('userId') String userId);

  @DELETE('/users/{userId}/follow-request')
  Future<void> cancelFollowRequest(@Path('userId') String userId);

  @GET('/users/follow-requests')
  Future<PaginatedResponse<SimpleUserModel>> getPendingFollowRequests({
    @Query('cursor') String? cursor,
    @Query('limit') int limit = 20,
  });

  @DELETE('/users/{userId}/follower')
  Future<void> removeFollower(@Path('userId') String userId);

  // Block
  @POST('/users/{userId}/block')
  Future<void> blockUser(@Path('userId') String userId);

  @DELETE('/users/{userId}/block')
  Future<void> unblockUser(@Path('userId') String userId);

  @GET('/users/blocked')
  Future<PaginatedResponse<SimpleUserModel>> getBlockedUsers({
    @Query('cursor') String? cursor,
    @Query('limit') int limit = 20,
  });

  @GET('/users/{userId}/block-status')
  Future<BlockStatusResponse> checkBlockStatus(@Path('userId') String userId);

  // Report
  @POST('/users/{userId}/report')
  Future<void> reportUser(
    @Path('userId') String userId,
    @Body() ReportUserRequest data,
  );
}
