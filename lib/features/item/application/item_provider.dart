import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:storedgev2/core/application/firebase_provider.dart';
import 'package:storedgev2/features/item/data/item_repository.dart';
import 'package:storedgev2/models/item/item.dart';

part 'item_provider.g.dart';

@riverpod
CollectionReference<Item> iCollectionRef(Ref ref) {
  final firestore = ref.watch(firestoreProvider);
  return firestore.collection('items').withConverter<Item>(
        fromFirestore: (snapshot, _) =>
            Item.fromJson(snapshot.data()!).copyWith(id: snapshot.id),
        toFirestore: (item, _) => item.toJson(),
      );
}

@riverpod
Reference iStorageRef(Ref ref) {
  final storage = ref.watch(storageProvider);
  return storage.ref().child('items');
}

@riverpod
DocumentReference<Item> iDocumentRef(Ref ref, String id) {
  final firestore = ref.watch(firestoreProvider);
  return firestore.collection('items').doc(id).withConverter<Item>(
        fromFirestore: (snapshot, _) => Item.fromJson(snapshot.data()!),
        toFirestore: (item, _) => item.toJson(),
      );
}

@Riverpod(keepAlive: true)
ItemRepository itemRepository(Ref ref) {
  final firestore = ref.watch(iCollectionRefProvider);
  final storage = ref.watch(iStorageRefProvider);
  return ItemRepository(firestore, storage);
}

@riverpod
Stream<List<Item>> items(Ref ref) {
  final itemsRef = ref.watch(iCollectionRefProvider);
  return itemsRef.snapshots().map(
      (querySnapshot) => querySnapshot.docs.map((doc) => doc.data()).toList());
}

@riverpod
Stream<Item> item(Ref ref, String id) {
  final itemRef = ref.watch(iDocumentRefProvider(id));
  return itemRef.snapshots().map((snapshot) {
    return snapshot.data() ?? (throw Exception('Snapshot data is null for id: $id'));
  });
}

@riverpod
Future<Item> itemDoc(ref, id)  async {
  final docRef = ref.watch(iDocumentRefProvider(id));
  final snapshot = await docRef.get();

  return snapshot.data()!;
}

