import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String id;
  final String username;
  final String? email;
  final String? phone;
  final String? name;
  final String? bio;
  final String? profilePicture;
  final String? coverPicture;
  final bool isVerified;
  final bool isPrivate;
  final int followersCount;
  final int followingCount;
  final int postsCount;
  final int totalLikes;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final UserSettings? settings;

  const UserModel({
    required this.id,
    required this.username,
    this.email,
    this.phone,
    this.name,
    this.bio,
    this.profilePicture,
    this.coverPicture,
    this.isVerified = false,
    this.isPrivate = false,
    this.followersCount = 0,
    this.followingCount = 0,
    this.postsCount = 0,
    this.totalLikes = 0,
    required this.createdAt,
    this.updatedAt,
    this.settings,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserModel copyWith({
    String? id,
    String? username,
    String? email,
    String? phone,
    String? name,
    String? bio,
    String? profilePicture,
    String? coverPicture,
    bool? isVerified,
    bool? isPrivate,
    int? followersCount,
    int? followingCount,
    int? postsCount,
    int? totalLikes,
    DateTime? createdAt,
    DateTime? updatedAt,
    UserSettings? settings,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      profilePicture: profilePicture ?? this.profilePicture,
      coverPicture: coverPicture ?? this.coverPicture,
      isVerified: isVerified ?? this.isVerified,
      isPrivate: isPrivate ?? this.isPrivate,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
      postsCount: postsCount ?? this.postsCount,
      totalLikes: totalLikes ?? this.totalLikes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      settings: settings ?? this.settings,
    );
  }
}

@JsonSerializable()
class UserSettings {
  final bool pushNotifications;
  final bool emailNotifications;
  final bool privateAccount;
  final bool showOnlineStatus;
  final String language;
  final String theme;

  const UserSettings({
    this.pushNotifications = true,
    this.emailNotifications = true,
    this.privateAccount = false,
    this.showOnlineStatus = true,
    this.language = 'en',
    this.theme = 'system',
  });

  factory UserSettings.fromJson(Map<String, dynamic> json) =>
      _$UserSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$UserSettingsToJson(this);
}

@JsonSerializable()
class UserProfileModel extends UserModel {
  final bool? isFollowing;
  final bool? isFollowedBy;
  final bool? isBlocked;
  final bool? hasRequestedFollow;

  const UserProfileModel({
    required super.id,
    required super.username,
    super.email,
    super.phone,
    super.name,
    super.bio,
    super.profilePicture,
    super.coverPicture,
    super.isVerified,
    super.isPrivate,
    super.followersCount,
    super.followingCount,
    super.postsCount,
    super.totalLikes,
    required super.createdAt,
    super.updatedAt,
    super.settings,
    this.isFollowing,
    this.isFollowedBy,
    this.isBlocked,
    this.hasRequestedFollow,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserProfileModelToJson(this);

  @override
  UserProfileModel copyWith({
    String? id,
    String? username,
    String? email,
    String? phone,
    String? name,
    String? bio,
    String? profilePicture,
    String? coverPicture,
    bool? isVerified,
    bool? isPrivate,
    int? followersCount,
    int? followingCount,
    int? postsCount,
    int? totalLikes,
    DateTime? createdAt,
    DateTime? updatedAt,
    UserSettings? settings,
    bool? isFollowing,
    bool? isFollowedBy,
    bool? isBlocked,
    bool? hasRequestedFollow,
  }) {
    return UserProfileModel(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      profilePicture: profilePicture ?? this.profilePicture,
      coverPicture: coverPicture ?? this.coverPicture,
      isVerified: isVerified ?? this.isVerified,
      isPrivate: isPrivate ?? this.isPrivate,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
      postsCount: postsCount ?? this.postsCount,
      totalLikes: totalLikes ?? this.totalLikes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      settings: settings ?? this.settings,
      isFollowing: isFollowing ?? this.isFollowing,
      isFollowedBy: isFollowedBy ?? this.isFollowedBy,
      isBlocked: isBlocked ?? this.isBlocked,
      hasRequestedFollow: hasRequestedFollow ?? this.hasRequestedFollow,
    );
  }
}

@JsonSerializable()
class SimpleUserModel {
  final String id;
  final String username;
  final String? name;
  final String? profilePicture;
  final bool isVerified;

  const SimpleUserModel({
    required this.id,
    required this.username,
    this.name,
    this.profilePicture,
    this.isVerified = false,
  });

  factory SimpleUserModel.fromJson(Map<String, dynamic> json) =>
      _$SimpleUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleUserModelToJson(this);
}
