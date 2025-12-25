import 'package:json_annotation/json_annotation.dart';
import '../../../auth/data/models/user_model.dart';

part 'chat_model.g.dart';

@JsonSerializable()
class ChatModel {
  final String id;
  final ChatType type;
  final String? name;
  final String? imageUrl;
  final List<ChatParticipantModel> participants;
  final MessageModel? lastMessage;
  final int unreadCount;
  final bool isMuted;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const ChatModel({
    required this.id,
    required this.type,
    this.name,
    this.imageUrl,
    required this.participants,
    this.lastMessage,
    this.unreadCount = 0,
    this.isMuted = false,
    required this.createdAt,
    this.updatedAt,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatModelToJson(this);

  /// Get the other participant in a direct chat
  ChatParticipantModel? getOtherParticipant(String currentUserId) {
    if (type != ChatType.direct) return null;
    return participants.firstWhere(
      (p) => p.userId != currentUserId,
      orElse: () => participants.first,
    );
  }

  /// Get display name for the chat
  String getDisplayName(String currentUserId) {
    if (type == ChatType.group) {
      return name ?? 'Group Chat';
    }
    final other = getOtherParticipant(currentUserId);
    return other?.user?.name ?? other?.user?.username ?? 'Unknown';
  }

  /// Get display image for the chat
  String? getDisplayImage(String currentUserId) {
    if (type == ChatType.group) {
      return imageUrl;
    }
    final other = getOtherParticipant(currentUserId);
    return other?.user?.profilePicture;
  }
}

enum ChatType {
  @JsonValue('direct')
  direct,
  @JsonValue('group')
  group,
}

@JsonSerializable()
class ChatParticipantModel {
  final String id;
  final String chatId;
  final String userId;
  final SimpleUserModel? user;
  final ParticipantRole role;
  final DateTime joinedAt;
  final DateTime? lastReadAt;

  const ChatParticipantModel({
    required this.id,
    required this.chatId,
    required this.userId,
    this.user,
    this.role = ParticipantRole.member,
    required this.joinedAt,
    this.lastReadAt,
  });

  factory ChatParticipantModel.fromJson(Map<String, dynamic> json) =>
      _$ChatParticipantModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatParticipantModelToJson(this);
}

enum ParticipantRole {
  @JsonValue('admin')
  admin,
  @JsonValue('member')
  member,
}

@JsonSerializable()
class MessageModel {
  final String id;
  final String chatId;
  final String senderId;
  final SimpleUserModel? sender;
  final MessageType type;
  final String? content;
  final MessageMediaModel? media;
  final String? replyToId;
  final MessageModel? replyTo;
  final MessageStatus status;
  final DateTime createdAt;
  final DateTime? readAt;
  final DateTime? deletedAt;

  const MessageModel({
    required this.id,
    required this.chatId,
    required this.senderId,
    this.sender,
    required this.type,
    this.content,
    this.media,
    this.replyToId,
    this.replyTo,
    this.status = MessageStatus.sent,
    required this.createdAt,
    this.readAt,
    this.deletedAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);

  bool get isDeleted => deletedAt != null;
}

enum MessageType {
  @JsonValue('text')
  text,
  @JsonValue('image')
  image,
  @JsonValue('video')
  video,
  @JsonValue('audio')
  audio,
  @JsonValue('file')
  file,
  @JsonValue('post')
  post,
  @JsonValue('competition')
  competition,
  @JsonValue('system')
  system,
}

enum MessageStatus {
  @JsonValue('sending')
  sending,
  @JsonValue('sent')
  sent,
  @JsonValue('delivered')
  delivered,
  @JsonValue('read')
  read,
  @JsonValue('failed')
  failed,
}

@JsonSerializable()
class MessageMediaModel {
  final String url;
  final String? thumbnailUrl;
  final String? mimeType;
  final int? size;
  final int? width;
  final int? height;
  final int? duration;
  final String? fileName;

  const MessageMediaModel({
    required this.url,
    this.thumbnailUrl,
    this.mimeType,
    this.size,
    this.width,
    this.height,
    this.duration,
    this.fileName,
  });

  factory MessageMediaModel.fromJson(Map<String, dynamic> json) =>
      _$MessageMediaModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageMediaModelToJson(this);
}

// ============ REQUEST MODELS ============

@JsonSerializable()
class CreateChatRequest {
  final List<String> participantIds;
  final String? name;
  final String? imageUrl;

  const CreateChatRequest({
    required this.participantIds,
    this.name,
    this.imageUrl,
  });

  factory CreateChatRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateChatRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateChatRequestToJson(this);
}

@JsonSerializable()
class SendMessageRequest {
  final MessageType type;
  final String? content;
  final String? mediaUrl;
  final String? thumbnailUrl;
  final String? mimeType;
  final int? size;
  final String? fileName;
  final String? replyToId;

  const SendMessageRequest({
    required this.type,
    this.content,
    this.mediaUrl,
    this.thumbnailUrl,
    this.mimeType,
    this.size,
    this.fileName,
    this.replyToId,
  });

  factory SendMessageRequest.fromJson(Map<String, dynamic> json) =>
      _$SendMessageRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SendMessageRequestToJson(this);
}

@JsonSerializable()
class CreateGroupChatRequest {
  final List<String> participantIds;
  final String name;
  final String? imageUrl;

  const CreateGroupChatRequest({
    required this.participantIds,
    required this.name,
    this.imageUrl,
  });

  factory CreateGroupChatRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateGroupChatRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateGroupChatRequestToJson(this);
}

@JsonSerializable()
class UpdateGroupRequest {
  final String? name;
  final String? imageUrl;

  const UpdateGroupRequest({
    this.name,
    this.imageUrl,
  });

  factory UpdateGroupRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateGroupRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateGroupRequestToJson(this);
}

@JsonSerializable()
class MuteChatRequest {
  final int? durationMinutes;

  const MuteChatRequest({
    this.durationMinutes,
  });

  factory MuteChatRequest.fromJson(Map<String, dynamic> json) =>
      _$MuteChatRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MuteChatRequestToJson(this);
}

@JsonSerializable()
class MutedStatusResponse {
  final bool isMuted;
  final DateTime? mutedUntil;

  const MutedStatusResponse({
    required this.isMuted,
    this.mutedUntil,
  });

  factory MutedStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$MutedStatusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MutedStatusResponseToJson(this);
}

@JsonSerializable()
class AddReactionRequest {
  final String emoji;

  const AddReactionRequest({
    required this.emoji,
  });

  factory AddReactionRequest.fromJson(Map<String, dynamic> json) =>
      _$AddReactionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddReactionRequestToJson(this);
}

@JsonSerializable()
class UnreadCountResponse {
  final int count;

  const UnreadCountResponse({
    required this.count,
  });

  factory UnreadCountResponse.fromJson(Map<String, dynamic> json) =>
      _$UnreadCountResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UnreadCountResponseToJson(this);
}

@JsonSerializable()
class AddParticipantRequest {
  final String userId;

  const AddParticipantRequest({
    required this.userId,
  });

  factory AddParticipantRequest.fromJson(Map<String, dynamic> json) =>
      _$AddParticipantRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddParticipantRequestToJson(this);
}
