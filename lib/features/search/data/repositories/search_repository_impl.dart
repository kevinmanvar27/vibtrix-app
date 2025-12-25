import 'package:dio/dio.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/network/error_handler.dart';
import '../../../../core/models/base_response.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../posts/data/models/post_model.dart';
import '../../domain/repositories/search_repository.dart';
import '../datasources/search_api_service.dart';
import '../models/search_model.dart';

// Re-export API service models used by repository
export '../datasources/search_api_service.dart' show RecentSearchModel, SaveRecentSearchRequest, SearchSuggestionsModel;

/// Implementation of SearchRepository
class SearchRepositoryImpl implements SearchRepository {
  final SearchApiService _apiService;

  SearchRepositoryImpl({required SearchApiService apiService})
      : _apiService = apiService;

  @override
  Future<Result<SearchResultModel>> search(
    String query, {
    String? type,
    String? cursor,
    int limit = 20,
  }) async {
    try {
      final result = await _apiService.search(
        query: query,
        type: type,
        cursor: cursor,
        limit: limit,
      );
      return Right(result);
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
      final response = await _apiService.searchUsers(
        query: query,
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
  Future<Result<PaginatedResponse<PostModel>>> searchPosts(
    String query, {
    String? cursor,
    int limit = 20,
  }) async {
    try {
      final response = await _apiService.searchPosts(
        query: query,
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
  Future<Result<PaginatedResponse<HashtagModel>>> searchHashtags(
    String query, {
    String? cursor,
    int limit = 20,
  }) async {
    try {
      final response = await _apiService.searchHashtags(
        query: query,
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
  Future<Result<TrendingHashtagsModel>> getTrendingHashtags({int limit = 10}) async {
    try {
      final hashtags = await _apiService.getTrendingHashtags(limit: limit);
      return Right(hashtags);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<PaginatedResponse<PostModel>>> getPostsByHashtag(
    String hashtag, {
    String? cursor,
    int limit = 20,
  }) async {
    try {
      final response = await _apiService.getPostsByHashtag(
        hashtag,
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
  Future<Result<List<RecentSearchModel>>> getRecentSearches({int limit = 10}) async {
    try {
      final history = await _apiService.getRecentSearches(limit: limit);
      return Right(history);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<void>> saveRecentSearch(SaveRecentSearchRequest request) async {
    try {
      await _apiService.saveRecentSearch(request);
      return const Right(null);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<void>> deleteRecentSearch(String searchId) async {
    try {
      await _apiService.deleteRecentSearch(searchId);
      return const Right(null);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<void>> clearRecentSearches() async {
    try {
      await _apiService.clearRecentSearches();
      return const Right(null);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<SearchSuggestionsModel>> getSuggestions(
    String query, {
    int limit = 5,
  }) async {
    try {
      final suggestions = await _apiService.getSuggestions(
        query: query,
        limit: limit,
      );
      return Right(suggestions);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }
}
