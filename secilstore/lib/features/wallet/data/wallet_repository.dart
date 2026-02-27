import 'package:dio/dio.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/error/app_exception.dart';
import '../../../core/error/error_handler.dart';
import '../../../core/network/api_endpoints.dart';
import 'models/pending_transaction.dart';
import 'models/transaction.dart';
import 'models/wallet_summary.dart';

enum TransactionFilter { all, earnings, losses }

class PendingTransactionsData {
  const PendingTransactionsData({
    required this.items,
    required this.approvalDurationDays,
  });

  final List<PendingTransaction> items;
  final int approvalDurationDays;
}

class WalletRepository {
  WalletRepository(this._dio);

  final Dio _dio;

  Future<WalletSummary> getSummary() async {
    try {
      final response = await _dio.get(
        ApiEndpoints.walletSummary(AppConstants.brandId),
      );

      final data = response.data as Map<String, dynamic>?;
      if (data == null) throw const ServerException();

      final responseData = data['responseData'] as Map<String, dynamic>?;
      if (responseData != null) {
        return WalletSummary(
          totalBalance: _parseDouble(
            responseData['totalAvailableCoin'] ??
                responseData['totalBalance'] ??
                responseData['TotalBalance'] ??
                0,
          ),
          availableBalance: _parseDouble(
            responseData['totalAvailableTransferCoin'] ??
                responseData['availableBalance'] ??
                responseData['AvailableBalance'] ??
                0,
          ),
          tierName: responseData['tierName'] as String? ??
              responseData['TierName'] as String?,
          cardColor: responseData['cardColor'] as String? ??
              responseData['CardColor'] as String?,
          brandName: responseData['brandName'] as String? ??
              responseData['BrandName'] as String?,
          brandLogo: responseData['brandLogo'] as String? ??
              responseData['BrandLogo'] as String?,
          walletLogo: responseData['walletLogo'] as String? ??
              responseData['WalletLogo'] as String?,
          walletCover: responseData['walletCover'] as String? ??
              responseData['WalletCover'] as String?,
          onlineCampaignCount: _parseInt(
            responseData['onlineCampaignCount'] ??
                responseData['OnlineCampaignCount'] ??
                0,
          ),
          storeCampaignCount: _parseInt(
            responseData['storeCampaignCount'] ??
                responseData['StoreCampaignCount'] ??
                0,
          ),
        );
      }

      return WalletSummary(
        totalBalance: _parseDouble(
            data['totalAvailableCoin'] ?? data['totalBalance'] ?? 0),
        availableBalance: _parseDouble(data['totalAvailableTransferCoin'] ??
            data['availableBalance'] ??
            0),
        tierName: data['tierName'] as String?,
        cardColor: data['cardColor'] as String?,
        brandName: data['brandName'] as String?,
        brandLogo: data['brandLogo'] as String?,
        walletLogo: data['walletLogo'] as String?,
        walletCover: data['walletCover'] as String?,
        onlineCampaignCount: _parseInt(data['onlineCampaignCount'] ?? 0),
        storeCampaignCount: _parseInt(data['storeCampaignCount'] ?? 0),
      );
    } on AppException {
      rethrow;
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (e) {
      if (e is AppException) rethrow;
      throw const UnknownException();
    }
  }

  Future<List<WalletTransaction>> getTransactions(
      TransactionFilter filter) async {
    try {
      final filterType = switch (filter) {
        TransactionFilter.all => 1,
        TransactionFilter.earnings => 2,
        TransactionFilter.losses => 3,
      };

      final response = await _dio.get(
        ApiEndpoints.transactions(AppConstants.brandId),
        queryParameters: {'FilterType': filterType},
      );

      final data = response.data as Map<String, dynamic>?;
      if (data == null) return [];

      final responseData = data['responseData'];

      // API returns { responseData: { transactions: [...] } }
      if (responseData is Map<String, dynamic>) {
        final txList = responseData['transactions'] as List? ??
            responseData['Transactions'] as List? ??
            [];
        return txList
            .map((e) => _parseTransaction(e as Map<String, dynamic>))
            .toList();
      }

      // Fallback: responseData itself is a list
      if (responseData is List) {
        return responseData
            .map((e) => _parseTransaction(e as Map<String, dynamic>))
            .toList();
      }

      return [];
    } on AppException {
      rethrow;
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (e) {
      if (e is AppException) rethrow;
      throw const UnknownException();
    }
  }

  Future<List<PendingTransaction>> getPendingTransactions() async {
    final data = await getPendingTransactionsData();
    return data.items;
  }

  Future<PendingTransactionsData> getPendingTransactionsData() async {
    try {
      final response = await _dio.post(
        ApiEndpoints.pendingTransactions,
        data: {'brandId': AppConstants.brandId},
      );

      final data = response.data as Map<String, dynamic>?;
      if (data == null) {
        return const PendingTransactionsData(
            items: [], approvalDurationDays: 30);
      }

      final responseData = data['responseData'] ?? data['ResponseData'];

      var approvalDurationDays = 30;
      List<dynamic> rawBaskets = const [];

      if (responseData is List) {
        rawBaskets = responseData;
      } else if (responseData is Map<String, dynamic>) {
        final waitingReward = responseData['sotierBasketWaitingReward'] ??
            responseData['SotierBasketWaitingReward'];

        if (waitingReward is Map<String, dynamic>) {
          approvalDurationDays = _parseInt(
            waitingReward['approveDuration'] ??
                waitingReward['ApproveDuration'] ??
                30,
          );
          rawBaskets =
              waitingReward['sotierBasketWaitingRewardBaskets'] as List? ??
                  waitingReward['SotierBasketWaitingRewardBaskets'] as List? ??
                  waitingReward['baskets'] as List? ??
                  waitingReward['Baskets'] as List? ??
                  const [];
        } else {
          approvalDurationDays = _parseInt(
            responseData['approveDuration'] ??
                responseData['ApproveDuration'] ??
                30,
          );
          rawBaskets = responseData['transactions'] as List? ??
              responseData['Transactions'] as List? ??
              responseData['items'] as List? ??
              responseData['Items'] as List? ??
              const [];
        }
      }

      final items = rawBaskets
          .whereType<Map>()
          .map((e) => _parsePendingTransaction(
                Map<String, dynamic>.from(e),
                approvalDurationDays: approvalDurationDays,
              ))
          .toList();

      return PendingTransactionsData(
        items: items,
        approvalDurationDays:
            approvalDurationDays > 0 ? approvalDurationDays : 30,
      );
    } on AppException {
      rethrow;
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (e) {
      if (e is AppException) rethrow;
      throw const UnknownException();
    }
  }

  WalletTransaction _parseTransaction(Map<String, dynamic> json) {
    // API returns a nested "detail" object with sub-fields
    final detail = json['detail'] as Map<String, dynamic>? ?? {};

    return WalletTransaction(
      id: (json['id'] ?? json['Id'] ?? '').toString(),
      // API returns type as int (1=Kazanç, 2=Harcama); typeName has the string
      type: json['typeName'] as String? ??
          json['TypeName'] as String? ??
          json['type']?.toString() ??
          'Alışveriş',
      // transactionTypeName: Transfer, Görev, Alışveriş, Kampanya, vb.
      transactionTypeName: json['transactionTypeName'] as String? ??
          json['TransactionTypeName'] as String?,
      // API uses "coin" for the transaction amount, not "amount"
      amount: _parseDouble(json['coin'] ??
          json['Coin'] ??
          json['amount'] ??
          json['Amount'] ??
          0),
      balance: _parseDouble(
          json['balance'] ?? json['Balance'] ?? json['remainingBalance'] ?? 0),
      date: DateTime.tryParse(
            (json['date'] ??
                    json['Date'] ??
                    json['createdDate'] ??
                    json['CreatedDate'] ??
                    '')
                .toString(),
          ) ??
          DateTime.now(),
      // detail.orderNumber
      orderId: detail['orderNumber'] as String? ??
          json['orderId'] as String? ??
          json['OrderId'] as String?,
      refundId: json['refundId'] as String? ?? json['RefundId'] as String?,
      // detail.title holds the task/campaign name
      taskName: detail['title'] as String? ??
          json['taskName'] as String? ??
          json['TaskName'] as String?,
      // detail.subTitle holds the category
      taskCategory: detail['subTitle'] as String? ??
          json['taskCategory'] as String? ??
          json['TaskCategory'] as String?,
      // detail.transferParty holds the transfer recipient
      transferTo: detail['transferParty'] as String? ??
          json['transferTo'] as String? ??
          json['TransferTo'] as String?,
      brandName: json['brandName'] as String? ?? json['BrandName'] as String?,
      campaignName:
          json['campaignName'] as String? ?? json['CampaignName'] as String?,
      campaignRule:
          json['campaignRule'] as String? ?? json['CampaignRule'] as String?,
    );
  }

  PendingTransaction _parsePendingTransaction(
    Map<String, dynamic> json, {
    required int approvalDurationDays,
  }) {
    final subItemsRaw = json['subItems'] as List? ??
        json['SubItems'] as List? ??
        json['campaigns'] as List? ??
        [];
    final subItems = subItemsRaw
        .map((e) => PendingSubItem(
              name: (e['name'] ?? e['Name'] ?? e['campaignName'] ?? '')
                  .toString(),
              description:
                  e['description'] as String? ?? e['Description'] as String?,
              amount: _parseDouble(
                  e['amount'] ?? e['Amount'] ?? e['coinAmount'] ?? 0),
            ))
        .toList();

    return PendingTransaction(
      id: (json['id'] ??
              json['Id'] ??
              json['basketId'] ??
              json['BasketId'] ??
              json['orderId'] ??
              json['OrderId'] ??
              '')
          .toString(),
      amount: _parseDouble(
        json['amount'] ??
            json['Amount'] ??
            json['coinAmount'] ??
            json['CoinAmount'] ??
            json['totalCoinAmount'] ??
            json['TotalCoinAmount'] ??
            0,
      ),
      estimatedDate: DateTime.tryParse(
            (json['estimatedDate'] ??
                    json['EstimatedDate'] ??
                    json['approveDate'] ??
                    json['ApproveDate'] ??
                    json['approvalDate'] ??
                    json['ApprovalDate'] ??
                    json['approvalDateUtc'] ??
                    json['ApprovalDateUtc'] ??
                    json['estimatedApprovalDate'] ??
                    json['EstimatedApprovalDate'] ??
                    '')
                .toString(),
          ) ??
          DateTime.now().add(Duration(days: approvalDurationDays)),
      orderId: json['orderId'] as String? ??
          json['OrderId'] as String? ??
          json['orderNo'] as String? ??
          json['OrderNo'] as String?,
      subItems: subItems.isEmpty ? null : subItems,
    );
  }

  double _parseDouble(dynamic value) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0;
    return 0;
  }

  int _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }
}
