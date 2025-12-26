// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: json['id'] as String,
  username: json['username'] as String,
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  name: json['name'] as String?,
  bio: json['bio'] as String?,
  profilePicture: json['profilePicture'] as String?,
  coverPicture: json['coverPicture'] as String?,
  isVerified: json['isVerified'] as bool? ?? false,
  isPrivate: json['isPrivate'] as bool? ?? false,
  followersCount: (json['followersCount'] as num?)?.toInt() ?? 0,
  followingCount: (json['followingCount'] as num?)?.toInt() ?? 0,
  postsCount: (json['postsCount'] as num?)?.toInt() ?? 0,
  totalLikes: (json['totalLikes'] as num?)?.toInt() ?? 0,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt:
      json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
  settings:
      json['settings'] == null
          ? null
          : UserSettings.fromJson(json['settings'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'email': instance.email,
  'phone': instance.phone,
  'name': instance.name,
  'bio': instance.bio,
  'profilePicture': instance.profilePicture,
  'coverPicture': instance.coverPicture,
  'isVerified': instance.isVerified,
  'isPrivate': instance.isPrivate,
  'followersCount': instance.followersCount,
  'followingCount': instance.followingCount,
  'postsCount': instance.postsCount,
  'totalLikes': instance.totalLikes,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
  'settings': instance.settings,
};

UserSettings _$UserSettingsFromJson(Map<String, dynamic> json) => UserSettings(
  pushNotifications: json['pushNotifications'] as bool? ?? true,
  emailNotifications: json['emailNotifications'] as bool? ?? true,
  privateAccount: json['privateAccount'] as bool? ?? false,
  showOnlineStatus: json['showOnlineStatus'] as bool? ?? true,
  language: json['language'] as String? ?? 'en',
  theme: json['theme'] as String? ?? 'system',
);

Map<String, dynamic> _$UserSettingsToJson(UserSettings instance) =>
    <String, dynamic>{
      'pushNotifications': instance.pushNotifications,
      'emailNotifications': instance.emailNotifications,
      'privateAccount': instance.privateAccount,
      'showOnlineStatus': instance.showOnlineStatus,
      'language': instance.language,
      'theme': instance.theme,
    };

UserProfileModel _$UserProfileModelFromJson(Map<String, dynamic> json) =>
    UserProfileModel(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      name: json['name'] as String?,
      bio: json['bio'] as String?,
      profilePicture: json['profilePicture'] as String?,
      coverPicture: json['coverPicture'] as String?,
      isVerified: json['isVerified'] as bool? ?? false,
      isPrivate: json['isPrivate'] as bool? ?? false,
      followersCount: (json['followersCount'] as num?)?.toInt() ?? 0,
      followingCount: (json['followingCount'] as num?)?.toInt() ?? 0,
      postsCount: (json['postsCount'] as num?)?.toInt() ?? 0,
      totalLikes: (json['totalLikes'] as num?)?.toInt() ?? 0,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt:
          json['updatedAt'] == null
              ? null
              : DateTime.parse(json['updatedAt'] as String),
      settings:
          json['settings'] == null
              ? null
              : UserSettings.fromJson(json['settings'] as Map<String, dynamic>),
      isFollowing: json['isFollowing'] as bool?,
      isFollowedBy: json['isFollowedBy'] as bool?,
      isBlocked: json['isBlocked'] as bool?,
      hasRequestedFollow: json['hasRequestedFollow'] as bool?,
    );

Map<String, dynamic> _$UserProfileModelToJson(UserProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'phone': instance.phone,
      'name': instance.name,
      'bio': instance.bio,
      'profilePicture': instance.profilePicture,
      'coverPicture': instance.coverPicture,
      'isVerified': instance.isVerified,
      'isPrivate': instance.isPrivate,
      'followersCount': instance.followersCount,
      'followingCount': instance.followingCount,
      'postsCount': instance.postsCount,
      'totalLikes': instance.totalLikes,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'settings': instance.settings,
      'isFollowing': instance.isFollowing,
      'isFollowedBy': instance.isFollowedBy,
      'isBlocked': instance.isBlocked,
      'hasRequestedFollow': instance.hasRequestedFollow,
    };

SimpleUserModel _$SimpleUserModelFromJson(Map<String, dynamic> json) =>
    SimpleUserModel(
      id: json['id'] as String,
      username: json['username'] as String,
      name: json['name'] as String?,
      profilePicture: json['profilePicture'] as String?,
      isVerified: json['isVerified'] as bool? ?? false,
    );

Map<String, dynamic> _$SimpleUserModelToJson(SimpleUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'name': instance.name,
      'profilePicture': instance.profilePicture,
      'isVerified': instance.isVerified,
    };
