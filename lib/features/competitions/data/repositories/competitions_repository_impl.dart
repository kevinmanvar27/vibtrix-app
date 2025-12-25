import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/error_handler.dart';
import '../../../../core/models/base_response.dart';
import '../../../posts/data/models/post_model.dart';
import '../../domain/repositories/competitions_repository.dart';
import '../datasources/competitions_api_service.dart';
import '../models/competition_model.dart';

/// Implementation of CompetitionsRepository
class CompetitionsRepositoryImpl implements CompetitionsRepository {
  final CompetitionsApiService _apiService;

  CompetitionsRepositoryImpl({required CompetitionsApiService apiService})
      : _apiService = apiService;

  @override
  Future<Result<CompetitionModel>> getCompetition(String competitionId) async {
    try {
      final competition = await _apiService.getCompetition(competitionId);
      return Right(competition);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<PaginatedResponse<CompetitionModel>>> getCompetitions({
    CompetitionStatus? status,
    String? cursor,
    int limit = 20,
  }) async {
    try {
      final response = await _apiService.getCompetitions(
        status: status?.name,
        cursor: cursor,
        limit: limit,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<CompetitionModel>> createCompetition(CreateCompetitionRequest request) async {
    try {
      final competition = await _apiService.createCompetition(request);
      return Right(competition);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<CompetitionModel>> updateCompetition(
    String competitionId,
    UpdateCompetitionRequest request,
  ) async {
    try {
      final competition = await _apiService.updateCompetition(competitionId, request);
      return Right(competition);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<void>> deleteCompetition(String competitionId) async {
    try {
      await _apiService.deleteCompetition(competitionId);
      return const Right(null);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<List<CompetitionModel>>> getFeaturedCompetitions({int limit = 10}) async {
    try {
      final competitions = await _apiService.getFeaturedCompetitions(limit: limit);
      return Right(competitions);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<List<CompetitionModel>>> getTrendingCompetitions({int limit = 10}) async {
    try {
      final competitions = await _apiService.getTrendingCompetitions(limit: limit);
      return Right(competitions);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<PaginatedResponse<CompetitionModel>>> searchCompetitions(
    String query, {
    String? cursor,
    int limit = 20,
  }) async {
    try {
      final response = await _apiService.searchCompetitions(
        query,
        cursor: cursor,
        limit: limit,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<ParticipantModel>> joinCompetition(String competitionId) async {
    try {
      final participant = await _apiService.joinCompetition(competitionId);
      return Right(participant);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<void>> leaveCompetition(String competitionId) async {
    try {
      await _apiService.leaveCompetition(competitionId);
      return const Right(null);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<bool>> isParticipating(String competitionId) async {
    try {
      final isParticipating = await _apiService.isParticipating(competitionId);
      return Right(isParticipating);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<PaginatedResponse<ParticipantModel>>> getParticipants(
    String competitionId, {
    String? cursor,
    int limit = 20,
  }) async {
    try {
      final response = await _apiService.getParticipants(
        competitionId,
        cursor: cursor,
        limit: limit,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<PostModel>> submitEntry(String competitionId, String postId) async {
    try {
      final entry = await _apiService.submitEntry(competitionId, postId);
      return Right(entry);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<PaginatedResponse<PostModel>>> getCompetitionEntries(
    String competitionId, {
    String? sortBy,
    String? cursor,
    int limit = 20,
  }) async {
    try {
      final response = await _apiService.getCompetitionEntries(
        competitionId,
        sortBy: sortBy,
        cursor: cursor,
        limit: limit,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<PostModel?>> getMyEntry(String competitionId) async {
    try {
      final entry = await _apiService.getMyEntry(competitionId);
      return Right(entry);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return const Right(null);
      }
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<void>> voteForEntry(String competitionId, String postId) async {
    try {
      await _apiService.voteForPost(competitionId, postId);
      return const Right(null);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<void>> removeVote(String competitionId, String postId) async {
    try {
      await _apiService.removeVote(competitionId, postId);
      return const Right(null);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<bool>> hasVoted(String competitionId, String postId) async {
    try {
      final hasVoted = await _apiService.hasVoted(competitionId, postId);
      return Right(hasVoted);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<List<LeaderboardEntryModel>>> getLeaderboard(
    String competitionId, {
    int limit = 50,
  }) async {
    try {
      final response = await _apiService.getLeaderboard(competitionId, limit: limit);
      return Right(response.items);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<List<LeaderboardEntryModel>>> getWinners(String competitionId) async {
    try {
      final winners = await _apiService.getWinners(competitionId);
      return Right(winners);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<int?>> getMyRank(String competitionId) async {
    try {
      final rank = await _apiService.getMyRank(competitionId);
      return Right(rank);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return const Right(null);
      }
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<PaginatedResponse<CompetitionModel>>> getMyCompetitions({
    CompetitionStatus? status,
    String? cursor,
    int limit = 20,
  }) async {
    try {
      final response = await _apiService.getMyCompetitions(
        status: status?.name,
        cursor: cursor,
        limit: limit,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<PaginatedResponse<CompetitionModel>>> getCreatedCompetitions({
    String? cursor,
    int limit = 20,
  }) async {
    try {
      final response = await _apiService.getCreatedCompetitions(
        cursor: cursor,
        limit: limit,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<List<CompetitionCategoryModel>>> getCategories() async {
    try {
      final categories = await _apiService.getCategories();
      return Right(categories);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }
}
