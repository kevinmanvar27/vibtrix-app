/// Chat Provider - State management for chat feature
/// Handles conversations, messages, typing indicators, and real-time updates

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/repository_providers.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/models/base_response.dart';
import '../../data/models/chat_model.dart';
import '../../domain/repositories/chat_repository.dart';

// ============================================================================
// Conversations List State
// ============================================================================

class ConversationsState {
  final List<ChatModel> conversations;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? cursor;
  final String? errorMessage;
  final int unreadCount;

  const ConversationsState({
    this.conversations = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.cursor,
    this.errorMessage,
    this.unreadCount = 0,
  });

  ConversationsState copyWith({
    List<ChatModel>? conversations,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    String? cursor,
    String? errorMessage,
    int? unreadCount,
    bool clearError = false,
  }) {
    return ConversationsState(
      conversations: conversations ?? this.conversations,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      cursor: cursor ?? this.cursor,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }
}

// ============================================================================
// Conversations Notifier
// ============================================================================

class ConversationsNotifier extends StateNotifier<ConversationsState> {
  final ChatRepository _repository;

  ConversationsNotifier(this._repository) : super(const ConversationsState());

  /// Load conversations
  Future<void> loadConversations({bool refresh = false}) async {
    if (state.isLoading) return;

    if (refresh) {
      state = state.copyWith(
        isLoading: true,
        conversations: [],
        cursor: null,
        hasMore: true,
        clearError: true,
      );
    } else {
      state = state.copyWith(isLoading: true, clearError: true);
    }

    final result = await _repository.getChats(limit: 20);

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message ?? 'Failed to load conversations',
        );
      },
      (response) {
        state = state.copyWith(
          isLoading: false,
          conversations: response.data,
          cursor: response.nextCursor,
          hasMore: response.hasMore,
        );
        // Load unread count
        _loadUnreadCount();
      },
    );
  }

  /// Load more conversations
  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore || state.cursor == null) return;

    state = state.copyWith(isLoadingMore: true);

    final result = await _repository.getChats(
      cursor: state.cursor,
      limit: 20,
    );

    result.fold(
      (failure) {
        state = state.copyWith(isLoadingMore: false);
      },
      (response) {
        state = state.copyWith(
          isLoadingMore: false,
          conversations: [...state.conversations, ...response.data],
          cursor: response.nextCursor,
          hasMore: response.hasMore,
        );
      },
    );
  }

  /// Load unread count
  Future<void> _loadUnreadCount() async {
    final result = await _repository.getTotalUnreadCount();
    result.fold(
      (failure) {},
      (count) {
        state = state.copyWith(unreadCount: count);
      },
    );
  }

  /// Update conversation in list (after new message)
  void updateConversation(ChatModel updatedChat) {
    final index = state.conversations.indexWhere((c) => c.id == updatedChat.id);
    if (index != -1) {
      final newConversations = [...state.conversations];
      newConversations[index] = updatedChat;
      // Sort by last message time
      newConversations.sort((a, b) {
        final aTime = a.lastMessage?.createdAt ?? a.updatedAt ?? DateTime(2000);
        final bTime = b.lastMessage?.createdAt ?? b.updatedAt ?? DateTime(2000);
        return bTime.compareTo(aTime);
      });
      state = state.copyWith(conversations: newConversations);
    }
  }

  /// Add new conversation to top
  void addConversation(ChatModel chat) {
    state = state.copyWith(conversations: [chat, ...state.conversations]);
  }

  /// Remove conversation
  void removeConversation(String chatId) {
    state = state.copyWith(
      conversations: state.conversations.where((c) => c.id != chatId).toList(),
    );
  }

  /// Mark conversation as read
  Future<void> markAsRead(String chatId) async {
    await _repository.markAllAsRead(chatId);
    
    final index = state.conversations.indexWhere((c) => c.id == chatId);
    if (index != -1) {
      final chat = state.conversations[index];
      final newConversations = [...state.conversations];
      // Create updated chat with zero unread count
      newConversations[index] = ChatModel(
        id: chat.id,
        type: chat.type,
        name: chat.name,
        imageUrl: chat.imageUrl,
        participants: chat.participants,
        lastMessage: chat.lastMessage,
        unreadCount: 0,
        isMuted: chat.isMuted,
        createdAt: chat.createdAt,
        updatedAt: chat.updatedAt,
      );
      state = state.copyWith(conversations: newConversations);
      _loadUnreadCount();
    }
  }
}

// ============================================================================
// Chat Messages State
// ============================================================================

class ChatMessagesState {
  final ChatModel? chat;
  final List<MessageModel> messages;
  final bool isLoading;
  final bool isLoadingMore;
  final bool isSending;
  final bool hasMore;
  final String? cursor;
  final String? errorMessage;
  final Set<String> typingUsers;

  const ChatMessagesState({
    this.chat,
    this.messages = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.isSending = false,
    this.hasMore = true,
    this.cursor,
    this.errorMessage,
    this.typingUsers = const {},
  });

  ChatMessagesState copyWith({
    ChatModel? chat,
    List<MessageModel>? messages,
    bool? isLoading,
    bool? isLoadingMore,
    bool? isSending,
    bool? hasMore,
    String? cursor,
    String? errorMessage,
    Set<String>? typingUsers,
    bool clearError = false,
    bool clearChat = false,
  }) {
    return ChatMessagesState(
      chat: clearChat ? null : (chat ?? this.chat),
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isSending: isSending ?? this.isSending,
      hasMore: hasMore ?? this.hasMore,
      cursor: cursor ?? this.cursor,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      typingUsers: typingUsers ?? this.typingUsers,
    );
  }
}

// ============================================================================
// Chat Messages Notifier
// ============================================================================

class ChatMessagesNotifier extends StateNotifier<ChatMessagesState> {
  final ChatRepository _repository;

  ChatMessagesNotifier(this._repository) : super(const ChatMessagesState());

  /// Load chat and messages
  Future<void> loadChat(String chatId) async {
    state = state.copyWith(isLoading: true, clearError: true, clearChat: true);

    // Load chat details
    final chatResult = await _repository.getChat(chatId);

    chatResult.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message ?? 'Failed to load chat',
        );
      },
      (chat) {
        state = state.copyWith(chat: chat);
        // Load messages
        _loadMessages(chatId);
      },
    );
  }

  /// Load messages
  Future<void> _loadMessages(String chatId) async {
    final result = await _repository.getMessages(chatId, limit: 50);

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message ?? 'Failed to load messages',
        );
      },
      (response) {
        state = state.copyWith(
          isLoading: false,
          messages: response.data,
          cursor: response.nextCursor,
          hasMore: response.hasMore,
        );
      },
    );
  }

  /// Load more messages (older)
  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore || state.cursor == null || state.chat == null) {
      return;
    }

    state = state.copyWith(isLoadingMore: true);

    final result = await _repository.getMessages(
      state.chat!.id,
      cursor: state.cursor,
      limit: 50,
    );

    result.fold(
      (failure) {
        state = state.copyWith(isLoadingMore: false);
      },
      (response) {
        state = state.copyWith(
          isLoadingMore: false,
          messages: [...state.messages, ...response.data],
          cursor: response.nextCursor,
          hasMore: response.hasMore,
        );
      },
    );
  }

  /// Send a message
  Future<bool> sendMessage(String content, {MessageType type = MessageType.text}) async {
    if (state.chat == null) return false;

    state = state.copyWith(isSending: true, clearError: true);

    final request = SendMessageRequest(
      content: content,
      type: type,
    );

    final result = await _repository.sendMessage(state.chat!.id, request);

    return result.fold(
      (failure) {
        state = state.copyWith(
          isSending: false,
          errorMessage: failure.message ?? 'Failed to send message',
        );
        return false;
      },
      (message) {
        // Add message to top of list
        state = state.copyWith(
          isSending: false,
          messages: [message, ...state.messages],
        );
        return true;
      },
    );
  }

  /// Receive a new message (from real-time)
  void receiveMessage(MessageModel message) {
    // Avoid duplicates
    if (state.messages.any((m) => m.id == message.id)) return;

    state = state.copyWith(messages: [message, ...state.messages]);
  }

  /// Delete a message
  Future<bool> deleteMessage(String messageId) async {
    if (state.chat == null) return false;

    final result = await _repository.deleteMessage(state.chat!.id, messageId);

    return result.fold(
      (failure) => false,
      (_) {
        state = state.copyWith(
          messages: state.messages.where((m) => m.id != messageId).toList(),
        );
        return true;
      },
    );
  }

  /// Update typing indicator
  void setTyping(String userId, bool isTyping) {
    final newTypingUsers = Set<String>.from(state.typingUsers);
    if (isTyping) {
      newTypingUsers.add(userId);
    } else {
      newTypingUsers.remove(userId);
    }
    state = state.copyWith(typingUsers: newTypingUsers);
  }

  /// Send typing indicator
  Future<void> sendTypingIndicator() async {
    if (state.chat == null) return;
    await _repository.sendTypingIndicator(state.chat!.id);
  }

  /// Clear state
  void clear() {
    state = const ChatMessagesState();
  }
}

// ============================================================================
// Providers
// ============================================================================

/// Conversations list provider
final conversationsProvider =
    StateNotifierProvider<ConversationsNotifier, ConversationsState>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return ConversationsNotifier(repository);
});

/// Chat messages provider - family for different chat IDs
final chatMessagesProvider =
    StateNotifierProvider.family<ChatMessagesNotifier, ChatMessagesState, String>(
  (ref, chatId) {
    final repository = ref.watch(chatRepositoryProvider);
    final notifier = ChatMessagesNotifier(repository);
    notifier.loadChat(chatId);
    return notifier;
  },
);

/// Unread messages count provider
final unreadMessagesCountProvider = Provider<int>((ref) {
  return ref.watch(conversationsProvider).unreadCount;
});

/// Create or get direct chat provider
final getOrCreateChatProvider =
    FutureProvider.family<ChatModel, String>((ref, userId) async {
  final repository = ref.watch(chatRepositoryProvider);
  final result = await repository.createChat(userId);
  return result.fold(
    (failure) => throw Exception(failure.message),
    (chat) => chat,
  );
});
