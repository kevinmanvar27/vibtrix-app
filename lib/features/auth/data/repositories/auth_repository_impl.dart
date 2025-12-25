import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/error_handler.dart';
import '../../../../core/storage/secure_storage.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_api_service.dart';
import '../models/auth_models.dart';
import '../models/user_model.dart';

/// Implementation of AuthRepository
class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService _apiService;
  final SecureStorageService _secureStorage;

  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _userKey = 'current_user';

  AuthRepositoryImpl({
    required AuthApiService apiService,
    required SecureStorageService secureStorage,
  })  : _apiService = apiService,
        _secureStorage = secureStorage;

  @override
  Future<Result<AuthResponse>> login(LoginRequest request) async {
    try {
      final response = await _apiService.login(request);
      await _saveTokens(response);
      return Right(response);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<AuthResponse>> signup(SignupRequest request) async {
    try {
      final response = await _apiService.signup(request);
      await _saveTokens(response);
      return Right(response);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<void>> logout() async {
    try {
      await _apiService.logout();
      await clearCredentials();
      return const Right(null);
    } on DioException catch (e) {
      // Still clear credentials even if API call fails
      await clearCredentials();
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      await clearCredentials();
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<TokenResponse>> refreshToken(String refreshToken) async {
    try {
      final response = await _apiService.refreshToken(
        RefreshTokenRequest(refreshToken: refreshToken),
      );
      await _secureStorage.write(_accessTokenKey, response.accessToken);
      if (response.refreshToken != null) {
        await _secureStorage.write(_refreshTokenKey, response.refreshToken!);
      }
      return Right(response);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<void>> sendVerificationOtp(SendOtpRequest request) async {
    try {
      await _apiService.sendVerificationOtp(request);
      return const Right(null);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<void>> verifyEmailOtp(VerifyOtpRequest request) async {
    try {
      await _apiService.verifyEmailOtp(request);
      return const Right(null);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<void>> forgotPassword(ForgotPasswordRequest request) async {
    try {
      await _apiService.forgotPassword(request);
      return const Right(null);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<VerifyResetOtpResponse>> verifyResetOtp(VerifyResetOtpRequest request) async {
    try {
      final response = await _apiService.verifyResetOtp(request);
      return Right(response);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<void>> resetPassword(ResetPasswordRequest request) async {
    try {
      await _apiService.resetPassword(request);
      return const Right(null);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<void>> changePassword(ChangePasswordRequest request) async {
    try {
      await _apiService.changePassword(request);
      return const Right(null);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<UserModel>> getCurrentUser() async {
    try {
      final user = await _apiService.getCurrentUser();
      return Right(user);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<UserModel>> updateProfile(UpdateProfileRequest request) async {
    try {
      final user = await _apiService.updateProfile(request);
      return Right(user);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<UserModel>> updateProfilePicture(List<int> imageBytes, String fileName) async {
    try {
      final user = await _apiService.updateProfilePicture(imageBytes, fileName);
      return Right(user);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<void>> deleteProfilePicture() async {
    try {
      await _apiService.deleteProfilePicture();
      return const Right(null);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<void>> verifyEmail(String token) async {
    try {
      await _apiService.verifyEmail(VerifyEmailRequest(token: token));
      return const Right(null);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<void>> resendVerificationEmail() async {
    try {
      await _apiService.resendVerificationEmail();
      return const Right(null);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<bool>> checkUsernameAvailability(String username) async {
    try {
      final response = await _apiService.checkUsername(username);
      return Right(response.available);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<bool>> checkEmailAvailability(String email) async {
    try {
      final response = await _apiService.checkEmail(email);
      return Right(response.available);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<AuthResponse>> socialLogin(SocialLoginRequest request) async {
    try {
      final response = await _apiService.socialLogin(request);
      await _saveTokens(response);
      return Right(response);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<AuthResponse>> googleMobileLogin(GoogleMobileLoginRequest request) async {
    try {
      final mobileResponse = await _apiService.googleMobileLogin(request);
      final response = mobileResponse.toAuthResponse();
      await _saveTokens(response);
      return Right(response);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<AuthResponse>> appleMobileLogin(AppleMobileLoginRequest request) async {
    try {
      final mobileResponse = await _apiService.appleMobileLogin(request);
      final response = mobileResponse.toAuthResponse();
      await _saveTokens(response);
      return Right(response);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<String?> getStoredToken() async {
    return _secureStorage.read(_accessTokenKey);
  }

  @override
  Future<bool> isAuthenticated() async {
    final token = await getStoredToken();
    return token != null && token.isNotEmpty;
  }

  @override
  Future<void> clearCredentials() async {
    await _secureStorage.delete(_accessTokenKey);
    await _secureStorage.delete(_refreshTokenKey);
    await _secureStorage.delete(_userKey);
  }

  Future<void> _saveTokens(AuthResponse response) async {
    await _secureStorage.write(_accessTokenKey, response.accessToken);
    if (response.refreshToken != null) {
      await _secureStorage.write(_refreshTokenKey, response.refreshToken!);
    }
  }
}
