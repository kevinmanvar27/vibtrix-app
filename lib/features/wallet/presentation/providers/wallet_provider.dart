/// Wallet state management using Riverpod
/// Handles balance, transactions, deposits, withdrawals, and payments

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/repository_providers.dart';
import '../../../../core/error/failures.dart';
import '../../data/models/wallet_model.dart';
import '../../domain/repositories/wallet_repository.dart';

// ============================================================================
// Wallet State
// ============================================================================

class WalletState {
  final WalletModel? wallet;
  final List<TransactionModel> transactions;
  final bool isLoading;
  final bool isLoadingTransactions;
  final bool isLoadingMore;
  final bool hasMore;
  final String? cursor;
  final String? errorMessage;
  final TransactionType? filterType;

  const WalletState({
    this.wallet,
    this.transactions = const [],
    this.isLoading = false,
    this.isLoadingTransactions = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.cursor,
    this.errorMessage,
    this.filterType,
  });

  WalletState copyWith({
    WalletModel? wallet,
    List<TransactionModel>? transactions,
    bool? isLoading,
    bool? isLoadingTransactions,
    bool? isLoadingMore,
    bool? hasMore,
    String? cursor,
    String? errorMessage,
    TransactionType? filterType,
    bool clearError = false,
    bool clearFilter = false,
  }) {
    return WalletState(
      wallet: wallet ?? this.wallet,
      transactions: transactions ?? this.transactions,
      isLoading: isLoading ?? this.isLoading,
      isLoadingTransactions: isLoadingTransactions ?? this.isLoadingTransactions,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      cursor: cursor ?? this.cursor,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      filterType: clearFilter ? null : (filterType ?? this.filterType),
    );
  }

  /// Get balance in Rupees (wallet stores in Paise)
  double get balanceInRupees => (wallet?.balance ?? 0) / 100;
}

// ============================================================================
// Wallet Notifier
// ============================================================================

class WalletNotifier extends StateNotifier<WalletState> {
  final WalletRepository _repository;

  WalletNotifier(this._repository) : super(const WalletState());

  /// Load wallet details
  Future<void> loadWallet() async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _repository.getWallet();

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message ?? 'Failed to load wallet',
        );
      },
      (wallet) {
        state = state.copyWith(isLoading: false, wallet: wallet);
        // Load transactions
        loadTransactions(refresh: true);
      },
    );
  }

  /// Load transactions
  Future<void> loadTransactions({
    bool refresh = false,
    TransactionType? type,
  }) async {
    if (state.isLoadingTransactions) return;

    if (refresh) {
      state = state.copyWith(
        isLoadingTransactions: true,
        transactions: [],
        cursor: null,
        hasMore: true,
        filterType: type,
        clearError: true,
      );
    } else {
      state = state.copyWith(isLoadingTransactions: true, clearError: true);
    }

    final result = await _repository.getTransactions(
      type: type ?? state.filterType,
      limit: 20,
    );

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoadingTransactions: false,
          errorMessage: failure.message ?? 'Failed to load transactions',
        );
      },
      (response) {
        state = state.copyWith(
          isLoadingTransactions: false,
          transactions: response.data,
          cursor: response.nextCursor,
          hasMore: response.hasMore,
        );
      },
    );
  }

  /// Load more transactions
  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore || state.cursor == null) return;

    state = state.copyWith(isLoadingMore: true);

    final result = await _repository.getTransactions(
      type: state.filterType,
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
          transactions: [...state.transactions, ...response.data],
          cursor: response.nextCursor,
          hasMore: response.hasMore,
        );
      },
    );
  }

  /// Refresh wallet balance
  Future<void> refreshBalance() async {
    final result = await _repository.getBalance();
    result.fold(
      (failure) {},
      (balance) {
        if (state.wallet != null) {
          state = state.copyWith(
            wallet: state.wallet!.copyWith(balance: balance),
          );
        }
      },
    );
  }

  /// Set filter type
  void setFilter(TransactionType? type) {
    loadTransactions(refresh: true, type: type);
  }

  /// Clear filter
  void clearFilter() {
    state = state.copyWith(clearFilter: true);
    loadTransactions(refresh: true);
  }
}

// ============================================================================
// Payment State
// ============================================================================

class PaymentState {
  final bool isProcessing;
  final String? errorMessage;
  final TransactionModel? lastTransaction;
  final String? paymentUrl; // For external payment gateways

  const PaymentState({
    this.isProcessing = false,
    this.errorMessage,
    this.lastTransaction,
    this.paymentUrl,
  });

  PaymentState copyWith({
    bool? isProcessing,
    String? errorMessage,
    TransactionModel? lastTransaction,
    String? paymentUrl,
    bool clearError = false,
    bool clearPaymentUrl = false,
  }) {
    return PaymentState(
      isProcessing: isProcessing ?? this.isProcessing,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      lastTransaction: lastTransaction ?? this.lastTransaction,
      paymentUrl: clearPaymentUrl ? null : (paymentUrl ?? this.paymentUrl),
    );
  }
}

// ============================================================================
// Payment Notifier
// ============================================================================

class PaymentNotifier extends StateNotifier<PaymentState> {
  final WalletRepository _repository;

  PaymentNotifier(this._repository) : super(const PaymentState());

  /// Create payment order to add money
  Future<PaymentOrderModel?> createPaymentOrder(int amountInPaise) async {
    state = state.copyWith(isProcessing: true, clearError: true);

    final result = await _repository.createPaymentOrder(amountInPaise);

    return result.fold(
      (failure) {
        state = state.copyWith(
          isProcessing: false,
          errorMessage: failure.message ?? 'Failed to create payment order',
        );
        return null;
      },
      (order) {
        state = state.copyWith(isProcessing: false);
        return order;
      },
    );
  }

  /// Verify payment after completion
  Future<bool> verifyPayment(String orderId, String paymentId, String signature) async {
    state = state.copyWith(isProcessing: true, clearError: true);

    final result = await _repository.verifyPayment(orderId, paymentId, signature);

    return result.fold(
      (failure) {
        state = state.copyWith(
          isProcessing: false,
          errorMessage: failure.message ?? 'Failed to verify payment',
        );
        return false;
      },
      (transaction) {
        state = state.copyWith(
          isProcessing: false,
          lastTransaction: transaction,
        );
        return true;
      },
    );
  }

  /// Request withdrawal
  Future<bool> requestWithdrawal(WithdrawalRequest request) async {
    state = state.copyWith(isProcessing: true, clearError: true);

    final result = await _repository.requestWithdrawal(request);

    return result.fold(
      (failure) {
        state = state.copyWith(
          isProcessing: false,
          errorMessage: failure.message ?? 'Failed to request withdrawal',
        );
        return false;
      },
      (transaction) {
        state = state.copyWith(
          isProcessing: false,
          lastTransaction: transaction,
        );
        return true;
      },
    );
  }

  /// Cancel withdrawal
  Future<bool> cancelWithdrawal(String transactionId) async {
    state = state.copyWith(isProcessing: true, clearError: true);

    final result = await _repository.cancelWithdrawal(transactionId);

    return result.fold(
      (failure) {
        state = state.copyWith(
          isProcessing: false,
          errorMessage: failure.message ?? 'Failed to cancel withdrawal',
        );
        return false;
      },
      (_) {
        state = state.copyWith(isProcessing: false);
        return true;
      },
    );
  }

  /// Claim a reward
  Future<bool> claimReward(String rewardId) async {
    state = state.copyWith(isProcessing: true, clearError: true);

    final result = await _repository.claimReward(rewardId);

    return result.fold(
      (failure) {
        state = state.copyWith(
          isProcessing: false,
          errorMessage: failure.message ?? 'Failed to claim reward',
        );
        return false;
      },
      (transaction) {
        state = state.copyWith(
          isProcessing: false,
          lastTransaction: transaction,
        );
        return true;
      },
    );
  }

  /// Clear error
  void clearError() {
    state = state.copyWith(clearError: true);
  }

  /// Reset state
  void reset() {
    state = const PaymentState();
  }
}

// ============================================================================
// Providers
// ============================================================================

/// Wallet provider
final walletProvider = StateNotifierProvider<WalletNotifier, WalletState>((ref) {
  final repository = ref.watch(walletRepositoryProvider);
  return WalletNotifier(repository);
});

/// Payment provider
final paymentProvider = StateNotifierProvider<PaymentNotifier, PaymentState>((ref) {
  final repository = ref.watch(walletRepositoryProvider);
  return PaymentNotifier(repository);
});

/// Wallet balance provider (convenience)
final walletBalanceProvider = Provider<int>((ref) {
  return ref.watch(walletProvider).wallet?.balance ?? 0;
});

/// Wallet balance in Rupees provider
final walletBalanceInRupeesProvider = Provider<double>((ref) {
  return ref.watch(walletProvider).balanceInRupees;
});

/// Bank accounts provider
final bankAccountsProvider = FutureProvider<List<BankAccountModel>>((ref) async {
  final repository = ref.watch(walletRepositoryProvider);
  final result = await repository.getBankAccounts();
  return result.fold(
    (failure) => throw Exception(failure.message),
    (accounts) => accounts,
  );
});

/// UPI IDs provider
final upiIdsProvider = FutureProvider<List<UpiIdModel>>((ref) async {
  final repository = ref.watch(walletRepositoryProvider);
  final result = await repository.getUpiIds();
  return result.fold(
    (failure) => throw Exception(failure.message),
    (upiIds) => upiIds,
  );
});
