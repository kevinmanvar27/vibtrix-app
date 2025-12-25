import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/models/base_response.dart';
import '../../../auth/data/models/user_model.dart';
import '../models/post_model.dart';

part 'posts_api_service.g.dart';

@RestApi()
abstract class PostsApiService {
  factory PostsApiService(Dio dio, {String baseUrl}) = _PostsApiService;

  // ============ FEED ENDPOINTS ============

  @GET('/posts/for-you')
  Future<PaginatedResponse<PostModel>> getFeed({
    @Query('cursor') String? cursor,
    @Query('limit') int limit = 20,
  });

  @GET('/posts/following')
  Future<PaginatedResponse<PostModel>> getFollowingFeed({
    @Query('cursor') String? cursor,
    @Query('limit') int limit = 20,
  });

  @GET('/posts/trending')
  Future<PaginatedResponse<PostModel>> getTrendingPosts({
    @Query('period') String? period,
    @Query('cursor') String? cursor,
    @Query('limit') int limit = 20,
  });

  // ============ POST CRUD ============

  @POST('/posts')
  Future<PostModel> createPost(@Body() CreatePostRequest request);

  @GET('/posts/{postId}')
  Future<PostModel> getPost(@Path('postId') String postId);

  @PUT('/posts/{postId}')
  Future<PostModel> updatePost(
    @Path('postId') String postId,
    @Body() UpdatePostRequest request,
  );

  @DELETE('/posts/{postId}')
  Future<void> deletePost(@Path('postId') String postId);

  // ============ USER POSTS ============

  @GET('/users/{userId}/posts')
  Future<PaginatedResponse<PostModel>> getUserPosts(
    @Path('userId') String userId, {
    @Query('cursor') String? cursor,
    @Query('limit') int limit = 20,
  });

  // ============ POST INTERACTIONS ============

  @POST('/posts/{postId}/like')
  Future<void> likePost(@Path('postId') String postId);

  @DELETE('/posts/{postId}/like')
  Future<void> unlikePost(@Path('postId') String postId);

  @POST('/posts/{postId}/save')
  Future<void> savePost(@Path('postId') String postId);

  @DELETE('/posts/{postId}/save')
  Future<void> unsavePost(@Path('postId') String postId);

  @GET('/posts/saved')
  Future<PaginatedResponse<PostModel>> getSavedPosts({
    @Query('cursor') String? cursor,
    @Query('limit') int limit = 20,
  });

  @POST('/posts/{postId}/share')
  Future<void> sharePost(@Path('postId') String postId);

  @POST('/posts/{postId}/view')
  Future<void> recordView(@Path('postId') String postId);

  @GET('/posts/{postId}/likes')
  Future<PaginatedResponse<SimpleUserModel>> getPostLikes(
    @Path('postId') String postId, {
    @Query('cursor') String? cursor,
    @Query('limit') int limit = 20,
  });

  // ============ COMMENTS ============

  @GET('/posts/{postId}/comments')
  Future<PaginatedResponse<CommentModel>> getComments(
    @Path('postId') String postId, {
    @Query('cursor') String? cursor,
    @Query('limit') int limit = 20,
  });

  @POST('/posts/{postId}/comments')
  Future<CommentModel> addComment(
    @Path('postId') String postId,
    @Body() AddCommentRequest request,
  );

  @DELETE('/posts/{postId}/comments/{commentId}')
  Future<void> deleteComment(
    @Path('postId') String postId,
    @Path('commentId') String commentId,
  );

  @POST('/posts/{postId}/comments/{commentId}/like')
  Future<void> likeComment(
    @Path('postId') String postId,
    @Path('commentId') String commentId,
  );

  @DELETE('/posts/{postId}/comments/{commentId}/like')
  Future<void> unlikeComment(
    @Path('postId') String postId,
    @Path('commentId') String commentId,
  );

  @GET('/posts/{postId}/comments/{commentId}/replies')
  Future<PaginatedResponse<CommentModel>> getCommentReplies(
    @Path('postId') String postId,
    @Path('commentId') String commentId, {
    @Query('cursor') String? cursor,
    @Query('limit') int limit = 20,
  });

  @POST('/posts/{postId}/comments/{commentId}/replies')
  Future<CommentModel> replyToComment(
    @Path('postId') String postId,
    @Path('commentId') String commentId,
    @Body() AddCommentRequest request,
  );

  // ============ REPORTS ============

  @POST('/posts/{postId}/report')
  Future<void> reportPost(
    @Path('postId') String postId,
    @Body() ReportPostRequest request,
  );
}
