import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction.freezed.dart';
part 'transaction.g.dart';

@freezed
class Transaksi with _$Transaksi {
  const factory Transaksi({
    String? id,
    required String itemId,
    required int type,
    required int quantity,
    required DateTime date,
  }) = _Transaksi;

  factory Transaksi.fromJson(Map<String, dynamic> json) =>
      _$TransaksiFromJson(json);
}
