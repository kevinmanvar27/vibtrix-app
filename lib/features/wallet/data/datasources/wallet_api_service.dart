import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/models/base_response.dart';
import '../models/wallet_model.dart';

part 'wallet_api_service.g.dart';

@RestApi()
abstract class WalletApiService {
  factory WalletApiService(Dio dio, {String baseUrl}) = _WalletApiService;

  // Wallet endpoints
  @GET('/wallet')
  Future<WalletModel> getWallet();

  @GET('/wallet/balance')
  Future<WalletBalanceResponse> getBalance();

  // Transaction history
  @GET('/wallet/transactions')
  Future<PaginatedResponse<TransactionModel>> getTransactions({
    @Query('type') String? type,
    @Query('status') String? status,
    @Query('startDate') String? startDate,
    @Query('endDate') String? endDate,
    @Query('cursor') String? cursor,
    @Query('limit') int limit = 20,
  });

  @GET('/wallet/transactions/{transactionId}')
  Future<TransactionModel> getTransaction(@Path('transactionId') String transactionId);

  // Payment Order (Razorpay integration)
  @POST('/wallet/payment-order')
  Future<PaymentOrderModel> createPaymentOrder(@Body() CreatePaymentOrderRequest request);

  @POST('/wallet/payment/verify')
  Future<TransactionModel> verifyPayment(@Body() VerifyPaymentRequest request);

  // Withdrawals
  @POST('/wallet/withdraw')
  Future<TransactionModel> requestWithdrawal(@Body() WithdrawalRequest request);

  @DELETE('/wallet/withdraw/{transactionId}')
  Future<void> cancelWithdrawal(@Path('transactionId') String transactionId);

  @GET('/wallet/withdrawals')
  Future<PaginatedResponse<TransactionModel>> getWithdrawals({
    @Query('status') String? status,
    @Query('cursor') String? cursor,
    @Query('limit') int limit = 20,
  });

  // Bank accounts
  @GET('/wallet/bank-accounts')
  Future<List<BankAccountModel>> getBankAccounts();

  @POST('/wallet/bank-accounts')
  Future<BankAccountModel> addBankAccount(@Body() AddBankAccountRequest request);

  @DELETE('/wallet/bank-accounts/{accountId}')
  Future<void> deleteBankAccount(@Path('accountId') String accountId);

  @PUT('/wallet/bank-accounts/{accountId}/default')
  Future<void> setDefaultBankAccount(@Path('accountId') String accountId);

  @POST('/wallet/bank-accounts/{accountId}/verify')
  Future<BankAccountModel> verifyBankAccount(@Path('accountId') String accountId);

  // UPI
  @GET('/wallet/upi')
  Future<List<UpiIdModel>> getUpiIds();

  @POST('/wallet/upi')
  Future<UpiIdModel> addUpiId(@Body() AddUpiIdRequest request);

  @DELETE('/wallet/upi/{upiId}')
  Future<void> deleteUpiId(@Path('upiId') String upiId);

  @PUT('/wallet/upi/{upiId}/default')
  Future<void> setDefaultUpiId(@Path('upiId') String upiId);

  @POST('/wallet/upi/{upiId}/verify')
  Future<UpiIdModel> verifyUpiId(@Path('upiId') String upiId);

  // Earnings
  @GET('/wallet/earnings')
  Future<EarningsModel> getEarnings({
    @Query('startDate') String? startDate,
    @Query('endDate') String? endDate,
  });

  @GET('/wallet/earnings/breakdown')
  Future<EarningsBreakdownModel> getEarningsBreakdown({
    @Query('startDate') String? startDate,
    @Query('endDate') String? endDate,
  });

  // Rewards
  @GET('/wallet/rewards')
  Future<List<RewardModel>> getAvailableRewards();

  @POST('/wallet/rewards/{rewardId}/claim')
  Future<TransactionModel> claimReward(@Path('rewardId') String rewardId);

  // Referrals
  @GET('/wallet/referral')
  Future<ReferralInfoModel> getReferralInfo();

  @POST('/wallet/referral/generate')
  Future<ReferralCodeResponse> generateReferralCode();

  // KYC
  @GET('/wallet/kyc/status')
  Future<KycStatusModel> getKycStatus();

  @POST('/wallet/kyc/submit')
  Future<void> submitKyc(@Body() KycSubmissionRequest request);

  @PUT('/wallet/kyc/update')
  Future<void> updateKyc(@Body() KycSubmissionRequest request);
}

// ============ Response Models ============

@JsonSerializable()
class WalletBalanceResponse {
  final int balance;
  final int pendingBalance;
  final int withdrawableBalance;
  final String currency;

  WalletBalanceResponse({
    required this.balance,
    required this.pendingBalance,
    required this.withdrawableBalance,
    required this.currency,
  });

  double get balanceInRupees => balance / 100;
  double get pendingBalanceInRupees => pendingBalance / 100;
  double get withdrawableBalanceInRupees => withdrawableBalance / 100;

  factory WalletBalanceResponse.fromJson(Map<String, dynamic> json) =>
      _$WalletBalanceResponseFromJson(json);
  Map<String, dynamic> toJson() => _$WalletBalanceResponseToJson(this);
}

@JsonSerializable()
class ReferralCodeResponse {
  final String code;
  final String shareUrl;

  ReferralCodeResponse({
    required this.code,
    required this.shareUrl,
  });

  factory ReferralCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$ReferralCodeResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ReferralCodeResponseToJson(this);
}

@JsonSerializable()
class AddUpiIdRequest {
  final String upiId;
  final String? name;
  final bool isPrimary;

  AddUpiIdRequest({
    required this.upiId,
    this.name,
    this.isPrimary = false,
  });

  factory AddUpiIdRequest.fromJson(Map<String, dynamic> json) =>
      _$AddUpiIdRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AddUpiIdRequestToJson(this);
}
