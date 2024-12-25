import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../item/application/item_provider.dart';
import '../../supplier/application/supplier_provider.dart';

part 'dashboard_provider.g.dart';

@riverpod
Future<int> itemCollectionCount(Ref ref) async {
  final itemCollection = ref.watch(iCollectionRefProvider);
  final snapshot = await itemCollection.count().get();
  return snapshot.count!;
}

@riverpod
Future<int> supplierCollectionCount(Ref ref) async {
  final supplierCollection = ref.watch(sCollectionRefProvider);
  final snapshot = await supplierCollection.where('deleted', isEqualTo: false).count().get();
  return snapshot.count!;
}



