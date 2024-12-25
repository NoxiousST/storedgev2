// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplier.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SupplierImpl _$$SupplierImplFromJson(Map<String, dynamic> json) =>
    _$SupplierImpl(
      id: json['id'] as String?,
      name: json['name'] as String,
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      contact: json['contact'] as String,
      deleted: json['deleted'] as bool? ?? false,
    );

Map<String, dynamic> _$$SupplierImplToJson(_$SupplierImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'location': instance.location.toJson(),
      'contact': instance.contact,
      'deleted': instance.deleted,
    };
