import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/models/base_response.dart';
import '../../../posts/data/models/post_model.dart';
import '../models/competition_model.dart';

part 'competitions_api_service.g.dart';

@RestApi()
abstract class CompetitionsApiService {
  factory CompetitionsApiService(Dio dio, {String baseUrl}) = _CompetitionsApiService;

  @GET('/competitions')
  Future<PaginatedResponse<CompetitionModel>> getCompetitions({
    @Query('status') String? status,
    @Query('type') String? type,
    @Query('featured') bool? featured,
    @Query('cursor') String? cursor,
    @Query('limit') int limit = 20,
  });

  @GET('/competitions/{competitionId}')
  Future<CompetitionModel> getCompetition(@Path('competitionId') String competitionId);

  @POST('/competitions')
  Future<CompetitionModel> createCompetition(@Body() CreateCompetitionRequest request);

  @PUT('/competitions/{competitionId}')
  Future<CompetitionModel> updateCompetition(
    @Path('competitionId') String competitionId,
    @Body() UpdateCompetitionRequest request,
  );

  @DELETE('/competitions/{competitionId}')
  Future<void> deleteCompetition(@Path('competitionId') String competitionId);

  @GET('/competitions/featured')
  Future<List<CompetitionModel>> getFeaturedCompetitions({
    @Query('limit') int limit = 10,
  });

  @GET('/competitions/trending')
  Future<List<CompetitionModel>> getTrendingCompetitions({
    @Query('limit') int limit = 10,
  });

  @GET('/competitions/search')
  Future<PaginatedResponse<CompetitionModel>> searchCompetitions(
    @Query('q') String query, {
    @Query('cursor') String? cursor,
    @Query('limit') int limit = 20,
  });

  @POST('/competitions/{competitionId}/participate')
  Future<ParticipantModel> joinCompetition(@Path('competitionId') String competitionId);

  @DELETE('/competitions/{competitionId}/participate')
  Future<void> leaveCompetition(@Path('competitionId') String competitionId);

  @GET('/competitions/{competitionId}/participants')
  Future<PaginatedResponse<ParticipantModel>> getParticipants(
    @Path('competitionId') String competitionId, {
    @Query('cursor') String? cursor,
    @Query('limit') int limit = 20,
  });

  @GET('/competitions/{competitionId}/rounds')
  Future<List<CompetitionRoundModel>> getRounds(@Path('competitionId') String competitionId);

  @GET('/competitions/{competitionId}/leaderboard')
  Future<PaginatedResponse<LeaderboardEntryModel>> getLeaderboard(
    @Path('competitionId') String competitionId, {
    @Query('roundId') String? roundId,
    @Query('cursor') String? cursor,
    @Query('limit') int limit = 50,
  });

  @GET('/competitions/my')
  Future<PaginatedResponse<CompetitionModel>> getMyCompetitions({
    @Query('status') String? status,
    @Query('cursor') String? cursor,
    @Query('limit') int limit = 20,
  });

  @POST('/competitions/{competitionId}/vote/{postId}')
  Future<void> voteForPost(
    @Path('competitionId') String competitionId,
    @Path('postId') String postId,
  );

  @DELETE('/competitions/{competitionId}/vote/{postId}')
  Future<void> removeVote(
    @Path('competitionId') String competitionId,
    @Path('postId') String postId,
  );

  @GET('/competitions/{competitionId}/winners')
  Future<List<LeaderboardEntryModel>> getWinners(
    @Path('competitionId') String competitionId,
  );

  @GET('/competitions/{competitionId}/entries')
  Future<PaginatedResponse<PostModel>> getCompetitionEntries(
    @Path('competitionId') String competitionId, {
    @Query('sortBy') String? sortBy,
    @Query('cursor') String? cursor,
    @Query('limit') int limit = 20,
  });

  @POST('/competitions/{competitionId}/entries/{postId}')
  Future<PostModel> submitEntry(
    @Path('competitionId') String competitionId,
    @Path('postId') String postId,
  );

  @GET('/competitions/{competitionId}/my-entry')
  Future<PostModel?> getMyEntry(@Path('competitionId') String competitionId);

  @GET('/competitions/{competitionId}/participating')
  Future<bool> isParticipating(@Path('competitionId') String competitionId);

  @GET('/competitions/{competitionId}/voted/{postId}')
  Future<bool> hasVoted(
    @Path('competitionId') String competitionId,
    @Path('postId') String postId,
  );

  @GET('/competitions/{competitionId}/my-rank')
  Future<int?> getMyRank(@Path('competitionId') String competitionId);

  @GET('/competitions/created')
  Future<PaginatedResponse<CompetitionModel>> getCreatedCompetitions({
    @Query('cursor') String? cursor,
    @Query('limit') int limit = 20,
  });

  @GET('/competitions/categories')
  Future<List<CompetitionCategoryModel>> getCategories();
}
