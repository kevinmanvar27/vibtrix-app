import '../../../../core/utils/either.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/models/base_response.dart';
import '../../data/models/wallet_model.dart';

/// Abstract repository for wallet operations
abstract class WalletRepository {
  // Wallet info
  Future<Result<WalletModel>> getWallet();
  Future<Result<int>> getBalance(); // Returns balance in paise
  
  // Transaction history
  Future<Result<PaginatedResponse<TransactionModel>>> getTransactions({
    TransactionType? type,
    TransactionStatus? status,
    DateTime? startDate,
    DateTime? endDate,
    String? cursor,
    int limit = 20,
  });
  Future<Result<TransactionModel>> getTransaction(String transactionId);
  
  // Add money
  Future<Result<PaymentOrderModel>> createPaymentOrder(int amountPaise, {String purpose = 'add_money'});
  Future<Result<TransactionModel>> verifyPayment(String orderId, String paymentId, String signature);
  
  // Withdrawals
  Future<Result<TransactionModel>> requestWithdrawal(WithdrawalRequest request);
  Future<Result<void>> cancelWithdrawal(String transactionId);
  Future<Result<PaginatedResponse<TransactionModel>>> getWithdrawalHistory({
    String? cursor,
    int limit = 20,
  });
  
  // Bank accounts
  Future<Result<List<BankAccountModel>>> getBankAccounts();
  Future<Result<BankAccountModel>> addBankAccount(AddBankAccountRequest request);
  Future<Result<void>> deleteBankAccount(String accountId);
  Future<Result<void>> setDefaultBankAccount(String accountId);
  Future<Result<BankAccountModel>> verifyBankAccount(String accountId);
  
  // UPI
  Future<Result<List<UpiIdModel>>> getUpiIds();
  Future<Result<UpiIdModel>> addUpiId(String upiId);
  Future<Result<void>> deleteUpiId(String upiIdId);
  Future<Result<void>> setDefaultUpiId(String upiIdId);
  Future<Result<UpiIdModel>> verifyUpiId(String upiIdId);
  
  // Earnings
  Future<Result<EarningsModel>> getEarnings({
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<Result<EarningsBreakdownModel>> getEarningsBreakdown({
    DateTime? startDate,
    DateTime? endDate,
  });
  
  // Rewards & Bonuses
  Future<Result<List<RewardModel>>> getAvailableRewards();
  Future<Result<TransactionModel>> claimReward(String rewardId);
  Future<Result<ReferralInfoModel>> getReferralInfo();
  Future<Result<String>> generateReferralCode();
  
  // KYC
  Future<Result<KycStatusModel>> getKycStatus();
  Future<Result<void>> submitKyc(KycSubmissionRequest request);
  Future<Result<void>> updateKyc(KycSubmissionRequest request);
}
