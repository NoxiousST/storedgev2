import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:storedgev2/models/transaction/transaction.dart';

import '../../../models/item/item.dart';

class TransactionRepository {
  TransactionRepository(this._transactionRef, this._itemRef);

  final CollectionReference<Transaksi> _transactionRef;
  final CollectionReference<Item> _itemRef;

  Future<void> addTransaction({
    required Transaksi transaction,
    required Item item
  }) async {
    try {
      int qty = transaction.quantity;
      if (transaction.type == 1) qty *= -1;

      await _itemRef.doc(transaction.itemId).update({'stock': item.stock + qty});
      await _transactionRef.add(transaction);

      log('Transaction added successfully!');
    } catch (e) {
      log('Failed to add transaction: $e');
      rethrow;
    }
  }


  Future<void> updateTransaction({
    required Transaksi transaction,
    File? file,
  }) async {
    try {
      final document = _transactionRef.doc(transaction.id);
      await document.update(transaction.toJson());

      log('Transaction updated successfully!');
    } catch (e) {
      log('Failed to update transaction: $e');
      rethrow;
    }
  }

  Future<void> deleteTransaction({
    required Transaksi transaction,
  }) async {
    try {
      await _transactionRef.doc(transaction.id).delete();

      log('Transaction successfully deleted!');
    } catch (e) {
      log('Failed to delete transaction: $e');
      rethrow;
    }
  }
}
