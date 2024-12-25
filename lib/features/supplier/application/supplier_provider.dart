import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:storedgev2/core/application/firebase_provider.dart';
import 'package:storedgev2/features/supplier/data/supplier_repository.dart';
import 'package:storedgev2/models/supplier/supplier.dart';

part 'supplier_provider.g.dart';

@riverpod
CollectionReference<Supplier> sCollectionRef(Ref ref) {
  final firestore = ref.watch(firestoreProvider);
  return firestore.collection('supplier').withConverter<Supplier>(
        fromFirestore: (snapshot, _) =>
            Supplier.fromJson(snapshot.data()!).copyWith(id: snapshot.id),
        toFirestore: (supplier, _) => supplier.toJson(),
      );
}


@riverpod
DocumentReference<Supplier> sDocumentRef(Ref ref, String id) {
  final firestore = ref.watch(firestoreProvider);
  return firestore.collection('supplier').doc(id).withConverter<Supplier>(
        fromFirestore: (snapshot, _) => Supplier.fromJson(snapshot.data()!),
        toFirestore: (supplier, _) => supplier.toJson(),
      );
}

@Riverpod(keepAlive: true)
SupplierRepository supplierRepository(Ref ref) {
  final firestore = ref.watch(sCollectionRefProvider);
  return SupplierRepository(firestore);
}

@riverpod
Stream<List<Supplier>> suppliers(Ref ref) {
  final itemsRef = ref.watch(sCollectionRefProvider);
  return itemsRef.snapshots().map(
      (querySnapshot) => querySnapshot.docs.map((doc) => doc.data()).toList());
}

@riverpod
Stream<Supplier> supplier(Ref ref, String id) {
  final itemRef = ref.watch(sDocumentRefProvider(id));
  return itemRef.snapshots().map((snapshot) {
    return snapshot.data() ?? (throw Exception('Snapshot data is null for id: $id'));
  });
}

@riverpod
Future<List<Supplier>> suppliersColl(Ref ref) async {
  final itemsRef = ref.watch(sCollectionRefProvider);
  final querySnapshot = await itemsRef.snapshots().first;
  return querySnapshot.docs.map((doc) => doc.data()).toList();
}

@riverpod
Future<Supplier?> supplierDoc(Ref ref, String id) async {
  final docRef = ref.watch(sDocumentRefProvider(id));

  try {
    final snapshot = await docRef.get();

    if (!snapshot.exists || snapshot.data() == null) {
      log('Supplier document with ID $id does not exist');
      return null;
    }

    return snapshot.data();
  } catch (e) {
    log('Error fetching Supplier document with ID $id: $e');
    return null; // Return null if an error occurs
  }
}