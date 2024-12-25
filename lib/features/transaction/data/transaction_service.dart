import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:storedgev2/features/transaction/application/transaction_state.dart';
import 'package:storedgev2/models/item/item.dart';
import 'package:storedgev2/models/transaction/transaction.dart';

import '../application/transaction_provider.dart';

part 'transaction_service.g.dart';

@riverpod
class TransactionService extends _$TransactionService {
  @override
  TransactionState build() {
    return const TransactionState(LoadingStateEnum.initial, null);
  }

  Future<void> addTransaction({
    required Transaksi transaction,
    required Item item
  }) async {
    state = const TransactionState(LoadingStateEnum.loading, null);
    try {
      final firestoreRepository = ref.watch(transactionRepositoryProvider);
      await firestoreRepository.addTransaction(transaction: transaction, item: item);
      state = const TransactionState(LoadingStateEnum.success, null);
    } on Exception catch (e) {
      state = TransactionState(LoadingStateEnum.error, e);
    }
  }

  Future<void> deleteTransaction(Transaksi transaction) async {
    state = const TransactionState(LoadingStateEnum.loading, null);
    try {
      final firestoreRepository = ref.watch(transactionRepositoryProvider);
      await firestoreRepository.deleteTransaction(transaction: transaction);
      state = const TransactionState(LoadingStateEnum.success, null);
    } on Exception catch (e) {
      state = TransactionState(LoadingStateEnum.error, e);
    }
  }

  Future<void> updateTransaction({required Transaksi transaction}) async {
    state = const TransactionState(LoadingStateEnum.loading, null);
    try {
      final firestoreRepository = ref.watch(transactionRepositoryProvider);
      await firestoreRepository.updateTransaction(transaction: transaction);
      state = const TransactionState(LoadingStateEnum.success, null);
    } on Exception catch (e) {
      state = TransactionState(LoadingStateEnum.error, e);
    }
  }
}
