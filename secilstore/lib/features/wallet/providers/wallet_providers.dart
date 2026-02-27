import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers/core_providers.dart';
import '../data/models/pending_transaction.dart';
import '../data/models/transaction.dart';
import '../data/models/wallet_summary.dart';
import '../data/wallet_repository.dart';

part 'wallet_providers.g.dart';

@riverpod
WalletRepository walletRepository(Ref ref) {
  return WalletRepository(ref.watch(dioClientProvider));
}

@riverpod
Future<WalletSummary> walletSummary(Ref ref) async {
  return ref.watch(walletRepositoryProvider).getSummary();
}

@riverpod
Future<List<WalletTransaction>> transactions(
  Ref ref,
  TransactionFilter filter,
) async {
  return ref.watch(walletRepositoryProvider).getTransactions(filter);
}

@riverpod
Future<List<PendingTransaction>> pendingTransactions(
  Ref ref,
) async {
  return ref.watch(walletRepositoryProvider).getPendingTransactions();
}

final pendingTransactionsDataProvider =
    FutureProvider.autoDispose<PendingTransactionsData>((ref) async {
  return ref.watch(walletRepositoryProvider).getPendingTransactionsData();
});

@riverpod
class WalletTabNotifier extends _$WalletTabNotifier {
  @override
  int build() => 0;

  void selectTab(int index) => state = index;
}
