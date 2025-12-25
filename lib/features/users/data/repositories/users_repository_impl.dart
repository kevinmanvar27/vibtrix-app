import 'package:dio/dio.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/error_handler.dart';
import '../../../../core/models/base_response.dart';
import '../../../auth/data/models/user_model.dart';
import '../../domain/repositories/users_repository.dart';
import '../datasources/users_api_service.dart';
import '../models/users_models.dart';

/// Implementation of UsersRepository
class UsersRepositoryImpl implements UsersRepository {
  final UsersApiService _apiService;

  UsersRepositoryImpl({required UsersApiService apiService})
      : _apiService = apiService;

  @override
  Future<Result<UserProfileModel>> getUserProfile(String userId) async {
    try {
      final profile = await _apiService.getUserProfile(userId);
      return Right(profile);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<UserProfileModel>> getUserByUsername(String username) async {
    try {
      final profile = await _apiService.getUserByUsername(username);
      return Right(profile);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<void>> followUser(String userId) async {
    try {
      await _apiService.followUser(userId);
      return const Right(null);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<void>> unfollowUser(String userId) async {
    try {
      await _apiService.unfollowUser(userId);
      return const Right(null);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<PaginatedResponse<SimpleUserModel>>> getFollowers(
    String userId, {
    String? cursor,
    int limit = 20,
  }) async {
    try {
      final response = await _apiService.getFollowers(userId, cursor: cursor, limit: limit);
      return Right(response);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<PaginatedResponse<SimpleUserModel>>> getFollowing(
    String userId, {
    String? cursor,
    int limit = 20,
  }) async {
    try {
      final response = await _apiService.getFollowing(userId, cursor: cursor, limit: limit);
      return Right(response);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<bool>> isFollowing(String userId) async {
    try {
      final response = await _apiService.checkFollowStatus(userId);
      return Right(response.isFollowing);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<PaginatedResponse<SimpleUserModel>>> getMutualFollowers(
    String userId, {
    String? cursor,
    int limit = 20,
  }) async {
    try {
      final response = await _apiService.getMutualFollowers(userId, cursor: cursor, limit: limit);
      return Right(response);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<void>> blockUser(String userId) async {
    try {
      await _apiService.blockUser(userId);
      return const Right(null);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<void>> unblockUser(String userId) async {
    try {
      await _apiService.unblockUser(userId);
      return const Right(null);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<PaginatedResponse<SimpleUserModel>>> getBlockedUsers({
    String? cursor,
    int limit = 20,
  }) async {
    try {
      final response = await _apiService.getBlockedUsers(cursor: cursor, limit: limit);
      return Right(response);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<bool>> isBlocked(String userId) async {
    try {
      final response = await _apiService.checkBlockStatus(userId);
      return Right(response.isBlocked);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<void>> reportUser(String userId, String reason, String? description) async {
    try {
      await _apiService.reportUser(
        userId,
        ReportUserRequest(reason: reason, description: description),
      );
      return const Right(null);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<List<SimpleUserModel>>> getSuggestedUsers({int limit = 10}) async {
    try {
      final users = await _apiService.getSuggestedUsers(limit: limit);
      return Right(users);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<PaginatedResponse<SimpleUserModel>>> searchUsers(
    String query, {
    String? cursor,
    int limit = 20,
  }) async {
    try {
      final response = await _apiService.searchUsers(query: query, cursor: cursor, limit: limit);
      return Right(response);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<void>> removeFollower(String userId) async {
    try {
      await _apiService.removeFollower(userId);
      return const Right(null);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<void>> acceptFollowRequest(String userId) async {
    try {
      await _apiService.acceptFollowRequest(userId);
      return const Right(null);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<void>> rejectFollowRequest(String userId) async {
    try {
      await _apiService.rejectFollowRequest(userId);
      return const Right(null);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<PaginatedResponse<SimpleUserModel>>> getPendingFollowRequests({
    String? cursor,
    int limit = 20,
  }) async {
    try {
      final response = await _apiService.getPendingFollowRequests(cursor: cursor, limit: limit);
      return Right(response);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }
}
