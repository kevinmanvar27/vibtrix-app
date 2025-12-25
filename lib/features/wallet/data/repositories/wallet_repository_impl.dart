import 'package:dio/dio.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/error_handler.dart';
import '../../../../core/models/base_response.dart';
import '../../domain/repositories/wallet_repository.dart';
import '../datasources/wallet_api_service.dart';
import '../models/wallet_model.dart';

/// Implementation of WalletRepository
class WalletRepositoryImpl implements WalletRepository {
  final WalletApiService _apiService;

  WalletRepositoryImpl({required WalletApiService apiService})
      : _apiService = apiService;

  @override
  Future<Result<WalletModel>> getWallet() async {
    try {
      final wallet = await _apiService.getWallet();
      return Right(wallet);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<int>> getBalance() async {
    try {
      final wallet = await _apiService.getWallet();
      return Right(wallet.balance);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<PaginatedResponse<TransactionModel>>> getTransactions({
    TransactionType? type,
    TransactionStatus? status,
    DateTime? startDate,
    DateTime? endDate,
    String? cursor,
    int limit = 20,
  }) async {
    try {
      final response = await _apiService.getTransactions(
        type: type?.name,
        status: status?.name,
        startDate: startDate?.toIso8601String(),
        endDate: endDate?.toIso8601String(),
        cursor: cursor,
        limit: limit,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<TransactionModel>> getTransaction(String transactionId) async {
    try {
      final transaction = await _apiService.getTransaction(transactionId);
      return Right(transaction);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<PaymentOrderModel>> createPaymentOrder(int amountPaise, {String purpose = 'add_money'}) async {
    try {
      final order = await _apiService.createPaymentOrder(
        CreatePaymentOrderRequest(amount: amountPaise, purpose: purpose),
      );
      return Right(order);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<TransactionModel>> verifyPayment(
    String orderId,
    String paymentId,
    String signature,
  ) async {
    try {
      final transaction = await _apiService.verifyPayment(
        VerifyPaymentRequest(
          orderId: orderId,
          paymentId: paymentId,
          signature: signature,
        ),
      );
      return Right(transaction);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<TransactionModel>> requestWithdrawal(WithdrawalRequest request) async {
    try {
      final transaction = await _apiService.requestWithdrawal(request);
      return Right(transaction);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<void>> cancelWithdrawal(String transactionId) async {
    try {
      await _apiService.cancelWithdrawal(transactionId);
      return const Right(null);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<PaginatedResponse<TransactionModel>>> getWithdrawalHistory({
    String? cursor,
    int limit = 20,
  }) async {
    try {
      final response = await _apiService.getTransactions(
        type: TransactionType.withdrawal.name,
        cursor: cursor,
        limit: limit,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<List<BankAccountModel>>> getBankAccounts() async {
    try {
      final accounts = await _apiService.getBankAccounts();
      return Right(accounts);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<BankAccountModel>> addBankAccount(AddBankAccountRequest request) async {
    try {
      final account = await _apiService.addBankAccount(request);
      return Right(account);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<void>> deleteBankAccount(String accountId) async {
    try {
      await _apiService.deleteBankAccount(accountId);
      return const Right(null);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<void>> setDefaultBankAccount(String accountId) async {
    try {
      await _apiService.setDefaultBankAccount(accountId);
      return const Right(null);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<BankAccountModel>> verifyBankAccount(String accountId) async {
    try {
      final account = await _apiService.verifyBankAccount(accountId);
      return Right(account);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<List<UpiIdModel>>> getUpiIds() async {
    try {
      final upiIds = await _apiService.getUpiIds();
      return Right(upiIds);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<UpiIdModel>> addUpiId(String upiId) async {
    try {
      final result = await _apiService.addUpiId(AddUpiIdRequest(upiId: upiId));
      return Right(result);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<void>> deleteUpiId(String upiIdId) async {
    try {
      await _apiService.deleteUpiId(upiIdId);
      return const Right(null);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<void>> setDefaultUpiId(String upiIdId) async {
    try {
      await _apiService.setDefaultUpiId(upiIdId);
      return const Right(null);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<UpiIdModel>> verifyUpiId(String upiIdId) async {
    try {
      final result = await _apiService.verifyUpiId(upiIdId);
      return Right(result);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<EarningsModel>> getEarnings({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final earnings = await _apiService.getEarnings(
        startDate: startDate?.toIso8601String(),
        endDate: endDate?.toIso8601String(),
      );
      return Right(earnings);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<EarningsBreakdownModel>> getEarningsBreakdown({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final breakdown = await _apiService.getEarningsBreakdown(
        startDate: startDate?.toIso8601String(),
        endDate: endDate?.toIso8601String(),
      );
      return Right(breakdown);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<List<RewardModel>>> getAvailableRewards() async {
    try {
      final rewards = await _apiService.getAvailableRewards();
      return Right(rewards);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<TransactionModel>> claimReward(String rewardId) async {
    try {
      final transaction = await _apiService.claimReward(rewardId);
      return Right(transaction);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<ReferralInfoModel>> getReferralInfo() async {
    try {
      final info = await _apiService.getReferralInfo();
      return Right(info);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<String>> generateReferralCode() async {
    try {
      final response = await _apiService.generateReferralCode();
      return Right(response.code);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<KycStatusModel>> getKycStatus() async {
    try {
      final status = await _apiService.getKycStatus();
      return Right(status);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<void>> submitKyc(KycSubmissionRequest request) async {
    try {
      await _apiService.submitKyc(request);
      return const Right(null);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }

  @override
  Future<Result<void>> updateKyc(KycSubmissionRequest request) async {
    try {
      await _apiService.updateKyc(request);
      return const Right(null);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(NetworkErrorHandler.handleException(e));
    }
  }
}
