import 'package:freezed_annotation/freezed_annotation.dart';

import '../location/location.dart';

part 'supplier.freezed.dart';
part 'supplier.g.dart';

@freezed
class Supplier with _$Supplier {
  const factory Supplier({
    String? id,
    required String name,
    required Location location,
    required String contact,
    @Default(false) bool deleted
  }) = _Supplier;

  factory Supplier.fromJson(Map<String, dynamic> json) => _$SupplierFromJson(json);
}