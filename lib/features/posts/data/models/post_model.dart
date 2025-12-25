import 'package:json_annotation/json_annotation.dart';
import '../../../auth/data/models/user_model.dart';

part 'post_model.g.dart';

@JsonSerializable()
class PostModel {
  final String id;
  final String userId;
  final SimpleUserModel? user;
  final String? caption;
  final PostMediaModel media;
  final int likesCount;
  final int commentsCount;
  final int sharesCount;
  final int viewsCount;
  final bool isLiked;
  final bool isBookmarked;
  final String? competitionId;
  final CompetitionInfoModel? competition;
  final List<String>? hashtags;
  final List<String>? mentions;
  final PostLocationModel? location;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const PostModel({
    required this.id,
    required this.userId,
    this.user,
    this.caption,
    required this.media,
    this.likesCount = 0,
    this.commentsCount = 0,
    this.sharesCount = 0,
    this.viewsCount = 0,
    this.isLiked = false,
    this.isBookmarked = false,
    this.competitionId,
    this.competition,
    this.hashtags,
    this.mentions,
    this.location,
    required this.createdAt,
    this.updatedAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);

  PostModel copyWith({
    String? id,
    String? userId,
    SimpleUserModel? user,
    String? caption,
    PostMediaModel? media,
    int? likesCount,
    int? commentsCount,
    int? sharesCount,
    int? viewsCount,
    bool? isLiked,
    bool? isBookmarked,
    String? competitionId,
    CompetitionInfoModel? competition,
    List<String>? hashtags,
    List<String>? mentions,
    PostLocationModel? location,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PostModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      user: user ?? this.user,
      caption: caption ?? this.caption,
      media: media ?? this.media,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      sharesCount: sharesCount ?? this.sharesCount,
      viewsCount: viewsCount ?? this.viewsCount,
      isLiked: isLiked ?? this.isLiked,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      competitionId: competitionId ?? this.competitionId,
      competition: competition ?? this.competition,
      hashtags: hashtags ?? this.hashtags,
      mentions: mentions ?? this.mentions,
      location: location ?? this.location,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

@JsonSerializable()
class PostMediaModel {
  final String type; // 'video' or 'image'
  final String url;
  final String? thumbnailUrl;
  final int? width;
  final int? height;
  final int? duration; // in seconds for videos
  final List<StickerModel>? stickers;

  const PostMediaModel({
    required this.type,
    required this.url,
    this.thumbnailUrl,
    this.width,
    this.height,
    this.duration,
    this.stickers,
  });

  factory PostMediaModel.fromJson(Map<String, dynamic> json) =>
      _$PostMediaModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostMediaModelToJson(this);

  bool get isVideo => type == 'video';
  bool get isImage => type == 'image';
}

@JsonSerializable()
class StickerModel {
  final String id;
  final String imageUrl;
  final double x;
  final double y;
  final double scale;
  final double rotation;

  const StickerModel({
    required this.id,
    required this.imageUrl,
    required this.x,
    required this.y,
    this.scale = 1.0,
    this.rotation = 0.0,
  });

  factory StickerModel.fromJson(Map<String, dynamic> json) =>
      _$StickerModelFromJson(json);

  Map<String, dynamic> toJson() => _$StickerModelToJson(this);
}

@JsonSerializable()
class PostLocationModel {
  final String? name;
  final double? latitude;
  final double? longitude;

  const PostLocationModel({
    this.name,
    this.latitude,
    this.longitude,
  });

  factory PostLocationModel.fromJson(Map<String, dynamic> json) =>
      _$PostLocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostLocationModelToJson(this);
}

@JsonSerializable()
class CompetitionInfoModel {
  final String id;
  final String name;
  final String? thumbnailUrl;
  final int? rank;
  final int? votes;

  const CompetitionInfoModel({
    required this.id,
    required this.name,
    this.thumbnailUrl,
    this.rank,
    this.votes,
  });

  factory CompetitionInfoModel.fromJson(Map<String, dynamic> json) =>
      _$CompetitionInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$CompetitionInfoModelToJson(this);
}

@JsonSerializable()
class CommentModel {
  final String id;
  final String postId;
  final String userId;
  final SimpleUserModel? user;
  final String content;
  final int likesCount;
  final bool isLiked;
  final String? parentId;
  final int repliesCount;
  final DateTime createdAt;

  const CommentModel({
    required this.id,
    required this.postId,
    required this.userId,
    this.user,
    required this.content,
    this.likesCount = 0,
    this.isLiked = false,
    this.parentId,
    this.repliesCount = 0,
    required this.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentModelToJson(this);

  CommentModel copyWith({
    String? id,
    String? postId,
    String? userId,
    SimpleUserModel? user,
    String? content,
    int? likesCount,
    bool? isLiked,
    String? parentId,
    int? repliesCount,
    DateTime? createdAt,
  }) {
    return CommentModel(
      id: id ?? this.id,
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      user: user ?? this.user,
      content: content ?? this.content,
      likesCount: likesCount ?? this.likesCount,
      isLiked: isLiked ?? this.isLiked,
      parentId: parentId ?? this.parentId,
      repliesCount: repliesCount ?? this.repliesCount,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

// ============ REQUEST MODELS ============

@JsonSerializable()
class CreatePostRequest {
  final String mediaUrl;
  final String mediaType;
  final String? thumbnailUrl;
  final String? caption;
  final String? competitionId;
  final List<StickerModel>? stickers;
  final PostLocationModel? location;

  const CreatePostRequest({
    required this.mediaUrl,
    required this.mediaType,
    this.thumbnailUrl,
    this.caption,
    this.competitionId,
    this.stickers,
    this.location,
  });

  factory CreatePostRequest.fromJson(Map<String, dynamic> json) =>
      _$CreatePostRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePostRequestToJson(this);
}

@JsonSerializable()
class UpdatePostRequest {
  final String? caption;
  final PostLocationModel? location;

  const UpdatePostRequest({
    this.caption,
    this.location,
  });

  factory UpdatePostRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdatePostRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatePostRequestToJson(this);
}

@JsonSerializable()
class AddCommentRequest {
  final String content;
  final String? parentId;

  const AddCommentRequest({
    required this.content,
    this.parentId,
  });

  factory AddCommentRequest.fromJson(Map<String, dynamic> json) =>
      _$AddCommentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddCommentRequestToJson(this);
}

@JsonSerializable()
class ReportPostRequest {
  final String reason;
  final String? description;

  const ReportPostRequest({
    required this.reason,
    this.description,
  });

  factory ReportPostRequest.fromJson(Map<String, dynamic> json) =>
      _$ReportPostRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ReportPostRequestToJson(this);
}
