/// Competitions state management using Riverpod
/// Handles competition listing, details, participation, voting, and leaderboards

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/repository_providers.dart';
import '../../../../core/models/base_response.dart';
import '../../data/models/competition_model.dart';
import '../../domain/repositories/competitions_repository.dart';

// ============================================================================
// Competitions List State
// ============================================================================

class CompetitionsListState {
  final List<CompetitionModel> competitions;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? cursor;
  final String? errorMessage;
  final CompetitionStatus? filterStatus;

  const CompetitionsListState({
    this.competitions = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.cursor,
    this.errorMessage,
    this.filterStatus,
  });

  CompetitionsListState copyWith({
    List<CompetitionModel>? competitions,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    String? cursor,
    String? errorMessage,
    CompetitionStatus? filterStatus,
    bool clearError = false,
  }) {
    return CompetitionsListState(
      competitions: competitions ?? this.competitions,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      cursor: cursor ?? this.cursor,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      filterStatus: filterStatus ?? this.filterStatus,
    );
  }
}

// ============================================================================
// Competitions List Notifier
// ============================================================================

class CompetitionsListNotifier extends StateNotifier<CompetitionsListState> {
  final CompetitionsRepository _repository;

  CompetitionsListNotifier(this._repository) : super(const CompetitionsListState());

  /// Load competitions
  Future<void> loadCompetitions({
    bool refresh = false,
    CompetitionStatus? status,
  }) async {
    if (state.isLoading) return;

    if (refresh) {
      state = state.copyWith(
        isLoading: true,
        competitions: [],
        cursor: null,
        hasMore: true,
        filterStatus: status,
        clearError: true,
      );
    } else {
      state = state.copyWith(isLoading: true, clearError: true);
    }

    final result = await _repository.getCompetitions(
      status: status ?? state.filterStatus,
      limit: 20,
    );

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message ?? 'Failed to load competitions',
        );
      },
      (response) {
        state = state.copyWith(
          isLoading: false,
          competitions: response.data,
          cursor: response.nextCursor,
          hasMore: response.hasMore,
        );
      },
    );
  }

  /// Load more competitions
  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore || state.cursor == null) return;

    state = state.copyWith(isLoadingMore: true);

    final result = await _repository.getCompetitions(
      status: state.filterStatus,
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
          competitions: [...state.competitions, ...response.data],
          cursor: response.nextCursor,
          hasMore: response.hasMore,
        );
      },
    );
  }

  /// Filter by status
  void setFilter(CompetitionStatus? status) {
    loadCompetitions(refresh: true, status: status);
  }
}

// ============================================================================
// Competition Detail State
// ============================================================================

class CompetitionDetailState {
  final CompetitionModel? competition;
  final List<ParticipantModel> participants;
  final List<LeaderboardEntryModel> leaderboard;
  final bool isLoading;
  final bool isJoining;
  final bool isVoting;
  final String? errorMessage;

  const CompetitionDetailState({
    this.competition,
    this.participants = const [],
    this.leaderboard = const [],
    this.isLoading = false,
    this.isJoining = false,
    this.isVoting = false,
    this.errorMessage,
  });

  CompetitionDetailState copyWith({
    CompetitionModel? competition,
    List<ParticipantModel>? participants,
    List<LeaderboardEntryModel>? leaderboard,
    bool? isLoading,
    bool? isJoining,
    bool? isVoting,
    String? errorMessage,
    bool clearError = false,
    bool clearCompetition = false,
  }) {
    return CompetitionDetailState(
      competition: clearCompetition ? null : (competition ?? this.competition),
      participants: participants ?? this.participants,
      leaderboard: leaderboard ?? this.leaderboard,
      isLoading: isLoading ?? this.isLoading,
      isJoining: isJoining ?? this.isJoining,
      isVoting: isVoting ?? this.isVoting,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

// ============================================================================
// Competition Detail Notifier
// ============================================================================

class CompetitionDetailNotifier extends StateNotifier<CompetitionDetailState> {
  final CompetitionsRepository _repository;

  CompetitionDetailNotifier(this._repository) : super(const CompetitionDetailState());

  /// Load competition details
  Future<void> loadCompetition(String competitionId) async {
    state = state.copyWith(isLoading: true, clearError: true, clearCompetition: true);

    final result = await _repository.getCompetition(competitionId);

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message ?? 'Failed to load competition',
        );
      },
      (competition) {
        state = state.copyWith(isLoading: false, competition: competition);
        // Load participants and leaderboard
        loadParticipants(competitionId);
        loadLeaderboard(competitionId);
      },
    );
  }

  /// Load participants
  Future<void> loadParticipants(String competitionId) async {
    final result = await _repository.getParticipants(competitionId);

    result.fold(
      (failure) {},
      (response) {
        state = state.copyWith(participants: response.data);
      },
    );
  }

  /// Load leaderboard
  Future<void> loadLeaderboard(String competitionId) async {
    final result = await _repository.getLeaderboard(competitionId);

    result.fold(
      (failure) {},
      (leaderboard) {
        // getLeaderboard returns List<LeaderboardEntryModel> directly, not PaginatedResponse
        state = state.copyWith(leaderboard: leaderboard);
      },
    );
  }

  /// Join competition
  Future<bool> joinCompetition(String competitionId) async {
    state = state.copyWith(isJoining: true, clearError: true);

    final result = await _repository.joinCompetition(competitionId);

    return result.fold(
      (failure) {
        state = state.copyWith(
          isJoining: false,
          errorMessage: failure.message ?? 'Failed to join competition',
        );
        return false;
      },
      (participant) {
        // Update competition state
        if (state.competition != null) {
          state = state.copyWith(
            isJoining: false,
            competition: state.competition!.copyWith(
              isParticipating: true,
              participantsCount: state.competition!.participantsCount + 1,
            ),
            participants: [participant, ...state.participants],
          );
        }
        return true;
      },
    );
  }

  /// Leave competition
  Future<bool> leaveCompetition(String competitionId) async {
    state = state.copyWith(isJoining: true, clearError: true);

    final result = await _repository.leaveCompetition(competitionId);

    return result.fold(
      (failure) {
        state = state.copyWith(
          isJoining: false,
          errorMessage: failure.message ?? 'Failed to leave competition',
        );
        return false;
      },
      (_) {
        if (state.competition != null) {
          state = state.copyWith(
            isJoining: false,
            competition: state.competition!.copyWith(
              isParticipating: false,
              participantsCount: state.competition!.participantsCount > 0 
                  ? state.competition!.participantsCount - 1 
                  : 0,
            ),
          );
        }
        return true;
      },
    );
  }

  /// Vote for a participant's entry
  Future<bool> voteForEntry(String competitionId, String postId) async {
    state = state.copyWith(isVoting: true, clearError: true);

    final result = await _repository.voteForEntry(competitionId, postId);

    return result.fold(
      (failure) {
        state = state.copyWith(
          isVoting: false,
          errorMessage: failure.message ?? 'Failed to vote',
        );
        return false;
      },
      (_) {
        state = state.copyWith(isVoting: false);
        // Refresh leaderboard after voting
        loadLeaderboard(competitionId);
        return true;
      },
    );
  }

  /// Clear state
  void clear() {
    state = const CompetitionDetailState();
  }
}

// ============================================================================
// Providers
// ============================================================================

/// Competitions list provider
final competitionsListProvider =
    StateNotifierProvider<CompetitionsListNotifier, CompetitionsListState>((ref) {
  final repository = ref.watch(competitionsRepositoryProvider);
  return CompetitionsListNotifier(repository);
});

/// Competition detail provider - family for different competition IDs
final competitionDetailProvider = StateNotifierProvider.family<
    CompetitionDetailNotifier, CompetitionDetailState, String>(
  (ref, competitionId) {
    final repository = ref.watch(competitionsRepositoryProvider);
    final notifier = CompetitionDetailNotifier(repository);
    notifier.loadCompetition(competitionId);
    return notifier;
  },
);

/// Active competitions provider
final activeCompetitionsProvider = FutureProvider<List<CompetitionModel>>((ref) async {
  final repository = ref.watch(competitionsRepositoryProvider);
  final result = await repository.getCompetitions(status: CompetitionStatus.active);
  return result.fold(
    (failure) => throw Exception(failure.message),
    (response) => response.data,
  );
});

/// My competitions provider
final myCompetitionsProvider = FutureProvider<List<CompetitionModel>>((ref) async {
  final repository = ref.watch(competitionsRepositoryProvider);
  final result = await repository.getMyCompetitions();
  return result.fold(
    (failure) => throw Exception(failure.message),
    (response) => response.data,
  );
});

/// Featured competitions provider
final featuredCompetitionsProvider = FutureProvider<List<CompetitionModel>>((ref) async {
  final repository = ref.watch(competitionsRepositoryProvider);
  final result = await repository.getFeaturedCompetitions();
  return result.fold(
    (failure) => throw Exception(failure.message),
    (competitions) => competitions,
  );
});

/// Competition leaderboard provider
final competitionLeaderboardProvider =
    FutureProvider.family<List<LeaderboardEntryModel>, String>((ref, competitionId) async {
  final repository = ref.watch(competitionsRepositoryProvider);
  final result = await repository.getLeaderboard(competitionId);
  return result.fold(
    (failure) => throw Exception(failure.message),
    (leaderboard) => leaderboard,
  );
});
