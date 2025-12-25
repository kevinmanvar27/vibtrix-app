import '../../../../core/utils/either.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/models/base_response.dart';
import '../../../posts/data/models/post_model.dart';
import '../../data/models/competition_model.dart';

/// Abstract repository for competition operations
abstract class CompetitionsRepository {
  // Competition CRUD
  Future<Result<CompetitionModel>> getCompetition(String competitionId);
  Future<Result<PaginatedResponse<CompetitionModel>>> getCompetitions({
    CompetitionStatus? status,
    String? cursor,
    int limit = 20,
  });
  Future<Result<CompetitionModel>> createCompetition(CreateCompetitionRequest request);
  Future<Result<CompetitionModel>> updateCompetition(String competitionId, UpdateCompetitionRequest request);
  Future<Result<void>> deleteCompetition(String competitionId);
  
  // Competition discovery
  Future<Result<List<CompetitionModel>>> getFeaturedCompetitions({int limit = 10});
  Future<Result<List<CompetitionModel>>> getTrendingCompetitions({int limit = 10});
  Future<Result<PaginatedResponse<CompetitionModel>>> searchCompetitions(
    String query, {
    String? cursor,
    int limit = 20,
  });
  
  // Participation
  Future<Result<ParticipantModel>> joinCompetition(String competitionId);
  Future<Result<void>> leaveCompetition(String competitionId);
  Future<Result<bool>> isParticipating(String competitionId);
  Future<Result<PaginatedResponse<ParticipantModel>>> getParticipants(
    String competitionId, {
    String? cursor,
    int limit = 20,
  });
  
  // Submissions
  Future<Result<PostModel>> submitEntry(String competitionId, String postId);
  Future<Result<PaginatedResponse<PostModel>>> getCompetitionEntries(
    String competitionId, {
    String? sortBy,
    String? cursor,
    int limit = 20,
  });
  Future<Result<PostModel?>> getMyEntry(String competitionId);
  
  // Voting
  Future<Result<void>> voteForEntry(String competitionId, String postId);
  Future<Result<void>> removeVote(String competitionId, String postId);
  Future<Result<bool>> hasVoted(String competitionId, String postId);
  
  // Leaderboard & Results
  Future<Result<List<LeaderboardEntryModel>>> getLeaderboard(
    String competitionId, {
    int limit = 50,
  });
  Future<Result<List<LeaderboardEntryModel>>> getWinners(String competitionId);
  Future<Result<int?>> getMyRank(String competitionId);
  
  // User's competitions
  Future<Result<PaginatedResponse<CompetitionModel>>> getMyCompetitions({
    CompetitionStatus? status,
    String? cursor,
    int limit = 20,
  });
  Future<Result<PaginatedResponse<CompetitionModel>>> getCreatedCompetitions({
    String? cursor,
    int limit = 20,
  });
  
  // Competition categories
  Future<Result<List<CompetitionCategoryModel>>> getCategories();
}
