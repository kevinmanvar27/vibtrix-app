import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/auth_models.dart';
import '../models/user_model.dart';

part 'auth_api_service.g.dart';

@RestApi()
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String baseUrl}) = _AuthApiService;

  // ============ AUTHENTICATION ============

  @POST('/api/auth/token')
  Future<AuthResponse> login(@Body() LoginRequest request);

  @POST('/api/auth/signup')
  Future<AuthResponse> signup(@Body() SignupRequest request);

  @POST('/api/auth/refresh')
  Future<TokenResponse> refreshToken(@Body() RefreshTokenRequest request);

  @POST('/api/auth/revoke')
  Future<void> logout();

  @POST('/api/auth/send-verification-otp')
  Future<void> sendVerificationOtp(@Body() SendOtpRequest request);

  @POST('/api/auth/verify-email-otp')
  Future<void> verifyEmailOtp(@Body() VerifyOtpRequest request);

  // ============ PASSWORD MANAGEMENT ============

  @POST('/api/auth/forgot-password')
  Future<void> forgotPassword(@Body() ForgotPasswordRequest request);

  @POST('/api/auth/verify-reset-otp')
  Future<VerifyResetOtpResponse> verifyResetOtp(@Body() VerifyResetOtpRequest request);

  @POST('/api/auth/reset-password')
  Future<void> resetPassword(@Body() ResetPasswordRequest request);

  @POST('/api/auth/change-password')
  Future<void> changePassword(@Body() ChangePasswordRequest request);

  // ============ SOCIAL LOGIN ============

  @POST('/api/auth/social')
  Future<AuthResponse> socialLogin(@Body() SocialLoginRequest request);

  @POST('/api/auth/google/mobile')
  Future<MobileAuthResponse> googleMobileLogin(@Body() GoogleMobileLoginRequest request);

  @POST('/api/auth/apple/mobile')
  Future<MobileAuthResponse> appleMobileLogin(@Body() AppleMobileLoginRequest request);

  // ============ USER PROFILE ============

  @GET('/api/users/me')
  Future<UserModel> getCurrentUser();

  @PUT('/api/users/me')
  Future<UserModel> updateProfile(@Body() UpdateProfileRequest request);

  @POST('/api/users/me/profile-picture')
  @MultiPart()
  Future<UserModel> updateProfilePicture(
    @Part(name: 'image') List<int> imageBytes,
    @Part(name: 'filename') String fileName,
  );

  @DELETE('/api/users/me/profile-picture')
  Future<void> deleteProfilePicture();

  @DELETE('/api/users/me')
  Future<void> deleteAccount();

  // ============ EMAIL VERIFICATION ============

  @POST('/api/auth/verify-email')
  Future<void> verifyEmail(@Body() VerifyEmailRequest request);

  @POST('/api/auth/resend-verification')
  Future<void> resendVerificationEmail();

  // ============ AVAILABILITY CHECKS ============

  @GET('/api/auth/check-username/{username}')
  Future<AvailabilityResponse> checkUsername(@Path('username') String username);

  @GET('/api/auth/check-email/{email}')
  Future<AvailabilityResponse> checkEmail(@Path('email') String email);
}
