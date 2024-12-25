import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:storedgev2/core/application/firebase_provider.dart';
import 'package:storedgev2/features/item/application/item_provider.dart';
import 'package:storedgev2/features/transaction/data/transaction_repository.dart';
import 'package:storedgev2/models/transaction/transaction.dart';

part 'transaction_provider.g.dart';

@riverpod
CollectionReference<Transaksi> tCollectionRef(Ref ref) {
  final firestore = ref.watch(firestoreProvider);
  return firestore.collection('transaction').withConverter<Transaksi>(
        fromFirestore: (snapshot, _) =>
            Transaksi.fromJson(snapshot.data()!).copyWith(id: snapshot.id),
        toFirestore: (transaction, _) => transaction.toJson(),
      );
}

@riverpod
DocumentReference<Transaksi> tDocumentRef(Ref ref, String id) {
  final firestore = ref.watch(firestoreProvider);
  return firestore.collection('transaction').doc(id).withConverter<Transaksi>(
        fromFirestore: (snapshot, _) => Transaksi.fromJson(snapshot.data()!),
        toFirestore: (transaction, _) => transaction.toJson(),
      );
}

@Riverpod(keepAlive: true)
TransactionRepository transactionRepository(Ref ref) {
  final transaction = ref.watch(tCollectionRefProvider);
  final item = ref.watch(iCollectionRefProvider);
  return TransactionRepository(transaction, item);
}

@riverpod
Stream<List<Transaksi>> transactions(Ref ref) {
  final transactionsRef = ref.watch(tCollectionRefProvider);
  return transactionsRef.snapshots().map(
      (querySnapshot) => querySnapshot.docs.map((doc) => doc.data()).toList());
}

@riverpod
Stream<List<Transaksi>> itemTransactions(Ref ref, String itemId) {
  final transactionsRef = ref.watch(tCollectionRefProvider);
  final filteredQuery = transactionsRef.where('itemId', isEqualTo: itemId);
  return filteredQuery.snapshots().map(
          (querySnapshot) => querySnapshot.docs.map((doc) => doc.data()).toList());
}

@riverpod
Stream<Transaksi> transaction(Ref ref, String id) {
  final transactionRef = ref.watch(tDocumentRefProvider(id));
  return transactionRef.snapshots().map((snapshot) {
    return snapshot.data() ?? (throw Exception('Snapshot data is null for id: $id'));
  });
}

@riverpod
Future<Transaksi> transactionDoc(ref, id)  async {
  final docRef = ref.watch(tDocumentRefProvider(id));
  final snapshot = await docRef.get();

  return snapshot.data()!;
}
