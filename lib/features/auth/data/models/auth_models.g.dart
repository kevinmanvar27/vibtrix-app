// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) => LoginRequest(
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  password: json['password'] as String,
  deviceId: json['deviceId'] as String?,
  deviceType: json['deviceType'] as String?,
  fcmToken: json['fcmToken'] as String?,
);

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'phone': instance.phone,
      'password': instance.password,
      'deviceId': instance.deviceId,
      'deviceType': instance.deviceType,
      'fcmToken': instance.fcmToken,
    };

SignupRequest _$SignupRequestFromJson(Map<String, dynamic> json) =>
    SignupRequest(
      username: json['username'] as String,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      password: json['password'] as String,
      name: json['name'] as String?,
      referralCode: json['referralCode'] as String?,
      deviceId: json['deviceId'] as String?,
      deviceType: json['deviceType'] as String?,
      fcmToken: json['fcmToken'] as String?,
    );

Map<String, dynamic> _$SignupRequestToJson(SignupRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'phone': instance.phone,
      'password': instance.password,
      'name': instance.name,
      'referralCode': instance.referralCode,
      'deviceId': instance.deviceId,
      'deviceType': instance.deviceType,
      'fcmToken': instance.fcmToken,
    };

RefreshTokenRequest _$RefreshTokenRequestFromJson(Map<String, dynamic> json) =>
    RefreshTokenRequest(refreshToken: json['refreshToken'] as String);

Map<String, dynamic> _$RefreshTokenRequestToJson(
  RefreshTokenRequest instance,
) => <String, dynamic>{'refreshToken': instance.refreshToken};

ForgotPasswordRequest _$ForgotPasswordRequestFromJson(
  Map<String, dynamic> json,
) => ForgotPasswordRequest(
  email: json['email'] as String?,
  phone: json['phone'] as String?,
);

Map<String, dynamic> _$ForgotPasswordRequestToJson(
  ForgotPasswordRequest instance,
) => <String, dynamic>{'email': instance.email, 'phone': instance.phone};

ResetPasswordRequest _$ResetPasswordRequestFromJson(
  Map<String, dynamic> json,
) => ResetPasswordRequest(
  token: json['token'] as String,
  newPassword: json['newPassword'] as String,
);

Map<String, dynamic> _$ResetPasswordRequestToJson(
  ResetPasswordRequest instance,
) => <String, dynamic>{
  'token': instance.token,
  'newPassword': instance.newPassword,
};

VerifyResetOtpRequest _$VerifyResetOtpRequestFromJson(
  Map<String, dynamic> json,
) => VerifyResetOtpRequest(
  email: json['email'] as String,
  otp: json['otp'] as String,
);

Map<String, dynamic> _$VerifyResetOtpRequestToJson(
  VerifyResetOtpRequest instance,
) => <String, dynamic>{'email': instance.email, 'otp': instance.otp};

VerifyOtpRequest _$VerifyOtpRequestFromJson(Map<String, dynamic> json) =>
    VerifyOtpRequest(
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      otp: json['otp'] as String,
    );

Map<String, dynamic> _$VerifyOtpRequestToJson(VerifyOtpRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'phone': instance.phone,
      'otp': instance.otp,
    };

SendOtpRequest _$SendOtpRequestFromJson(Map<String, dynamic> json) =>
    SendOtpRequest(
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      purpose: json['purpose'] as String,
    );

Map<String, dynamic> _$SendOtpRequestToJson(SendOtpRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'phone': instance.phone,
      'purpose': instance.purpose,
    };

ChangePasswordRequest _$ChangePasswordRequestFromJson(
  Map<String, dynamic> json,
) => ChangePasswordRequest(
  currentPassword: json['currentPassword'] as String,
  newPassword: json['newPassword'] as String,
);

Map<String, dynamic> _$ChangePasswordRequestToJson(
  ChangePasswordRequest instance,
) => <String, dynamic>{
  'currentPassword': instance.currentPassword,
  'newPassword': instance.newPassword,
};

UpdateProfileRequest _$UpdateProfileRequestFromJson(
  Map<String, dynamic> json,
) => UpdateProfileRequest(
  username: json['username'] as String?,
  name: json['name'] as String?,
  bio: json['bio'] as String?,
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  isPrivate: json['isPrivate'] as bool?,
);

Map<String, dynamic> _$UpdateProfileRequestToJson(
  UpdateProfileRequest instance,
) => <String, dynamic>{
  'username': instance.username,
  'name': instance.name,
  'bio': instance.bio,
  'email': instance.email,
  'phone': instance.phone,
  'isPrivate': instance.isPrivate,
};

VerifyEmailRequest _$VerifyEmailRequestFromJson(Map<String, dynamic> json) =>
    VerifyEmailRequest(token: json['token'] as String);

Map<String, dynamic> _$VerifyEmailRequestToJson(VerifyEmailRequest instance) =>
    <String, dynamic>{'token': instance.token};

SocialLoginRequest _$SocialLoginRequestFromJson(Map<String, dynamic> json) =>
    SocialLoginRequest(
      provider: json['provider'] as String,
      accessToken: json['accessToken'] as String,
      idToken: json['idToken'] as String?,
      deviceId: json['deviceId'] as String?,
      deviceType: json['deviceType'] as String?,
      fcmToken: json['fcmToken'] as String?,
    );

Map<String, dynamic> _$SocialLoginRequestToJson(SocialLoginRequest instance) =>
    <String, dynamic>{
      'provider': instance.provider,
      'accessToken': instance.accessToken,
      'idToken': instance.idToken,
      'deviceId': instance.deviceId,
      'deviceType': instance.deviceType,
      'fcmToken': instance.fcmToken,
    };

GoogleMobileLoginRequest _$GoogleMobileLoginRequestFromJson(
  Map<String, dynamic> json,
) => GoogleMobileLoginRequest(
  idToken: json['idToken'] as String,
  accessToken: json['accessToken'] as String?,
);

Map<String, dynamic> _$GoogleMobileLoginRequestToJson(
  GoogleMobileLoginRequest instance,
) => <String, dynamic>{
  'idToken': instance.idToken,
  'accessToken': instance.accessToken,
};

AppleMobileLoginRequest _$AppleMobileLoginRequestFromJson(
  Map<String, dynamic> json,
) => AppleMobileLoginRequest(
  idToken: json['idToken'] as String,
  authorizationCode: json['authorizationCode'] as String?,
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
);

Map<String, dynamic> _$AppleMobileLoginRequestToJson(
  AppleMobileLoginRequest instance,
) => <String, dynamic>{
  'idToken': instance.idToken,
  'authorizationCode': instance.authorizationCode,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
};

AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) => AuthResponse(
  accessToken: json['accessToken'] as String,
  refreshToken: json['refreshToken'] as String?,
  expiresIn: (json['expiresIn'] as num?)?.toInt(),
  user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AuthResponseToJson(AuthResponse instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'expiresIn': instance.expiresIn,
      'user': instance.user,
    };

MobileAuthUser _$MobileAuthUserFromJson(Map<String, dynamic> json) =>
    MobileAuthUser(
      id: json['id'] as String,
      username: json['username'] as String,
      displayName: json['displayName'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
    );

Map<String, dynamic> _$MobileAuthUserToJson(MobileAuthUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'displayName': instance.displayName,
      'avatarUrl': instance.avatarUrl,
    };

MobileAuthResponse _$MobileAuthResponseFromJson(Map<String, dynamic> json) =>
    MobileAuthResponse(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      user: MobileAuthUser.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MobileAuthResponseToJson(MobileAuthResponse instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'user': instance.user,
    };

TokenResponse _$TokenResponseFromJson(Map<String, dynamic> json) =>
    TokenResponse(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String?,
      expiresIn: (json['expiresIn'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TokenResponseToJson(TokenResponse instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'expiresIn': instance.expiresIn,
    };

AvailabilityResponse _$AvailabilityResponseFromJson(
  Map<String, dynamic> json,
) => AvailabilityResponse(
  available: json['available'] as bool,
  message: json['message'] as String?,
);

Map<String, dynamic> _$AvailabilityResponseToJson(
  AvailabilityResponse instance,
) => <String, dynamic>{
  'available': instance.available,
  'message': instance.message,
};

VerifyResetOtpResponse _$VerifyResetOtpResponseFromJson(
  Map<String, dynamic> json,
) => VerifyResetOtpResponse(
  token: json['token'] as String,
  message: json['message'] as String?,
);

Map<String, dynamic> _$VerifyResetOtpResponseToJson(
  VerifyResetOtpResponse instance,
) => <String, dynamic>{'token': instance.token, 'message': instance.message};
