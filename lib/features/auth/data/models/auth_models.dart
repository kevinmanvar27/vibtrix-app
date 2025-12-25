import 'package:json_annotation/json_annotation.dart';
import 'user_model.dart';

part 'auth_models.g.dart';

// ============ REQUEST MODELS ============

@JsonSerializable()
class LoginRequest {
  final String? email;
  final String? phone;
  final String password;
  final String? deviceId;
  final String? deviceType;
  final String? fcmToken;

  const LoginRequest({
    this.email,
    this.phone,
    required this.password,
    this.deviceId,
    this.deviceType,
    this.fcmToken,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}

@JsonSerializable()
class SignupRequest {
  final String username;
  final String? email;
  final String? phone;
  final String password;
  final String? name;
  final String? referralCode;
  final String? deviceId;
  final String? deviceType;
  final String? fcmToken;

  const SignupRequest({
    required this.username,
    this.email,
    this.phone,
    required this.password,
    this.name,
    this.referralCode,
    this.deviceId,
    this.deviceType,
    this.fcmToken,
  });

  factory SignupRequest.fromJson(Map<String, dynamic> json) =>
      _$SignupRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignupRequestToJson(this);
}

@JsonSerializable()
class RefreshTokenRequest {
  final String refreshToken;

  const RefreshTokenRequest({required this.refreshToken});

  factory RefreshTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshTokenRequestToJson(this);
}

@JsonSerializable()
class ForgotPasswordRequest {
  final String? email;
  final String? phone;

  const ForgotPasswordRequest({this.email, this.phone});

  factory ForgotPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotPasswordRequestToJson(this);
}

@JsonSerializable()
class ResetPasswordRequest {
  final String token;
  final String newPassword;

  const ResetPasswordRequest({
    required this.token,
    required this.newPassword,
  });

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordRequestToJson(this);
}

/// Request model for verifying password reset OTP
/// Used with /api/auth/verify-reset-otp endpoint
@JsonSerializable()
class VerifyResetOtpRequest {
  final String email;
  final String otp;

  const VerifyResetOtpRequest({
    required this.email,
    required this.otp,
  });

  factory VerifyResetOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyResetOtpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyResetOtpRequestToJson(this);
}

@JsonSerializable()
class VerifyOtpRequest {
  final String? email;
  final String? phone;
  final String otp;

  const VerifyOtpRequest({
    this.email,
    this.phone,
    required this.otp,
  });

  factory VerifyOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyOtpRequestToJson(this);
}

@JsonSerializable()
class SendOtpRequest {
  final String? email;
  final String? phone;
  final String purpose; // 'login', 'signup', 'reset_password', 'verify'

  const SendOtpRequest({
    this.email,
    this.phone,
    required this.purpose,
  });

  factory SendOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$SendOtpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SendOtpRequestToJson(this);
}

@JsonSerializable()
class ChangePasswordRequest {
  final String currentPassword;
  final String newPassword;

  const ChangePasswordRequest({
    required this.currentPassword,
    required this.newPassword,
  });

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePasswordRequestToJson(this);
}

@JsonSerializable()
class UpdateProfileRequest {
  final String? username;
  final String? name;
  final String? bio;
  final String? email;
  final String? phone;
  final bool? isPrivate;

  const UpdateProfileRequest({
    this.username,
    this.name,
    this.bio,
    this.email,
    this.phone,
    this.isPrivate,
  });

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfileRequestToJson(this);
}

@JsonSerializable()
class VerifyEmailRequest {
  final String token;

  const VerifyEmailRequest({required this.token});

  factory VerifyEmailRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyEmailRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyEmailRequestToJson(this);
}

@JsonSerializable()
class SocialLoginRequest {
  final String provider; // 'google', 'apple', 'facebook'
  final String accessToken;
  final String? idToken;
  final String? deviceId;
  final String? deviceType;
  final String? fcmToken;

  const SocialLoginRequest({
    required this.provider,
    required this.accessToken,
    this.idToken,
    this.deviceId,
    this.deviceType,
    this.fcmToken,
  });

  factory SocialLoginRequest.fromJson(Map<String, dynamic> json) =>
      _$SocialLoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SocialLoginRequestToJson(this);
}

/// Request model for Google mobile authentication
/// Matches backend endpoint: POST /api/auth/google/mobile
@JsonSerializable()
class GoogleMobileLoginRequest {
  final String idToken;
  final String? accessToken;

  const GoogleMobileLoginRequest({
    required this.idToken,
    this.accessToken,
  });

  factory GoogleMobileLoginRequest.fromJson(Map<String, dynamic> json) =>
      _$GoogleMobileLoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleMobileLoginRequestToJson(this);
}

/// Request model for Apple mobile authentication
/// Matches backend endpoint: POST /api/auth/apple/mobile
@JsonSerializable()
class AppleMobileLoginRequest {
  final String idToken;
  final String? authorizationCode;
  final String? firstName;
  final String? lastName;

  const AppleMobileLoginRequest({
    required this.idToken,
    this.authorizationCode,
    this.firstName,
    this.lastName,
  });

  factory AppleMobileLoginRequest.fromJson(Map<String, dynamic> json) =>
      _$AppleMobileLoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AppleMobileLoginRequestToJson(this);
}

// ============ RESPONSE MODELS ============

@JsonSerializable()
class AuthResponse {
  final String accessToken;
  final String? refreshToken;
  final int? expiresIn;
  final UserModel user;

  const AuthResponse({
    required this.accessToken,
    this.refreshToken,
    this.expiresIn,
    required this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}

/// User model for mobile auth response
/// Matches the simplified user object returned by /api/auth/google/mobile
@JsonSerializable()
class MobileAuthUser {
  final String id;
  final String username;
  final String? displayName;
  final String? avatarUrl;

  const MobileAuthUser({
    required this.id,
    required this.username,
    this.displayName,
    this.avatarUrl,
  });

  factory MobileAuthUser.fromJson(Map<String, dynamic> json) =>
      _$MobileAuthUserFromJson(json);

  Map<String, dynamic> toJson() => _$MobileAuthUserToJson(this);

  /// Convert to full UserModel for app state
  UserModel toUserModel() {
    return UserModel(
      id: id,
      username: username,
      name: displayName,
      profilePicture: avatarUrl,
      createdAt: DateTime.now(), // Backend doesn't return this for mobile auth
    );
  }
}

/// Response model for mobile authentication endpoints
/// Matches backend response: { user, accessToken, refreshToken }
@JsonSerializable()
class MobileAuthResponse {
  final String accessToken;
  final String refreshToken;
  final MobileAuthUser user;

  const MobileAuthResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory MobileAuthResponse.fromJson(Map<String, dynamic> json) =>
      _$MobileAuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MobileAuthResponseToJson(this);

  /// Convert to standard AuthResponse for compatibility
  AuthResponse toAuthResponse() {
    return AuthResponse(
      accessToken: accessToken,
      refreshToken: refreshToken,
      user: user.toUserModel(),
    );
  }
}

@JsonSerializable()
class TokenResponse {
  final String accessToken;
  final String? refreshToken;
  final int? expiresIn;

  const TokenResponse({
    required this.accessToken,
    this.refreshToken,
    this.expiresIn,
  });

  factory TokenResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TokenResponseToJson(this);
}

@JsonSerializable()
class AvailabilityResponse {
  final bool available;
  final String? message;

  const AvailabilityResponse({
    required this.available,
    this.message,
  });

  factory AvailabilityResponse.fromJson(Map<String, dynamic> json) =>
      _$AvailabilityResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AvailabilityResponseToJson(this);
}

/// Response model for verify reset OTP
/// Returns the reset token to use for password reset
@JsonSerializable()
class VerifyResetOtpResponse {
  final String token;
  final String? message;

  const VerifyResetOtpResponse({
    required this.token,
    this.message,
  });

  factory VerifyResetOtpResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyResetOtpResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyResetOtpResponseToJson(this);
}
