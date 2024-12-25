import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:storedgev2/models/supplier/supplier.dart';

class SupplierRepository {
  SupplierRepository(this._supplierRef);

  final CollectionReference<Supplier> _supplierRef;

  Future<void> addSupplier({required Supplier supplier}) async {
    await _supplierRef.add(supplier);
  }

  Future<void> updateSupplier({
    required Supplier supplier,
  }) async {
    final document = _supplierRef.doc(supplier.id);
    await document.update(supplier.toJson());
  }

  Future<void> deleteSupplier({
    required String id,
  }) async {
    _supplierRef.doc(id).delete();
  }
}
