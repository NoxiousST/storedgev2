import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:storedgev2/features/supplier/application/supplier_state.dart';
import 'package:storedgev2/models/supplier/supplier.dart';

import '../application/supplier_provider.dart';

part 'supplier_service.g.dart';

@riverpod
class SupplierService extends _$SupplierService {
  @override
  SupplierState build() {
    return const SupplierState(LoadingStateEnum.initial, null);
  }

  Future<void> addSupplier({required Supplier supplier}) async {
    state = const SupplierState(LoadingStateEnum.loading, null);
    try {
      final firestoreRepository = ref.watch(supplierRepositoryProvider);
      await firestoreRepository.addSupplier(supplier: supplier);
      state = const SupplierState(LoadingStateEnum.success, null);
    } on Exception catch (e) {
      state = SupplierState(LoadingStateEnum.error, e);
    }
  }

  Future<void> updateSupplier({required Supplier supplier}) async {
    state = const SupplierState(LoadingStateEnum.loading, null);
    try {
      final firestoreRepository = ref.watch(supplierRepositoryProvider);
      await firestoreRepository.updateSupplier(supplier: supplier);
      state = const SupplierState(LoadingStateEnum.success, null);
    } on Exception catch (e) {
      state = SupplierState(LoadingStateEnum.error, e);
    }
  }

  Future<void> deleteSupplier(String id) async {
    state = const SupplierState(LoadingStateEnum.loading, null);
    try {
      final firestoreRepository = ref.watch(supplierRepositoryProvider);
      await firestoreRepository.deleteSupplier(id: id);
      state = const SupplierState(LoadingStateEnum.success, null);
    } on Exception catch (e) {
      state = SupplierState(LoadingStateEnum.error, e);
    }
  }
}
