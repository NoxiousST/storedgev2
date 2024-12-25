// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransaksiImpl _$$TransaksiImplFromJson(Map<String, dynamic> json) =>
    _$TransaksiImpl(
      id: json['id'] as String?,
      itemId: json['itemId'] as String,
      type: (json['type'] as num).toInt(),
      quantity: (json['quantity'] as num).toInt(),
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$$TransaksiImplToJson(_$TransaksiImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'itemId': instance.itemId,
      'type': instance.type,
      'quantity': instance.quantity,
      'date': instance.date.toIso8601String(),
    };
