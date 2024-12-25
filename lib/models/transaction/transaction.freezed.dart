// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Transaksi _$TransaksiFromJson(Map<String, dynamic> json) {
  return _Transaksi.fromJson(json);
}

/// @nodoc
mixin _$Transaksi {
  String? get id => throw _privateConstructorUsedError;
  String get itemId => throw _privateConstructorUsedError;
  int get type => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;

  /// Serializes this Transaksi to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Transaksi
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransaksiCopyWith<Transaksi> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransaksiCopyWith<$Res> {
  factory $TransaksiCopyWith(Transaksi value, $Res Function(Transaksi) then) =
      _$TransaksiCopyWithImpl<$Res, Transaksi>;
  @useResult
  $Res call({String? id, String itemId, int type, int quantity, DateTime date});
}

/// @nodoc
class _$TransaksiCopyWithImpl<$Res, $Val extends Transaksi>
    implements $TransaksiCopyWith<$Res> {
  _$TransaksiCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Transaksi
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? itemId = null,
    Object? type = null,
    Object? quantity = null,
    Object? date = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      itemId: null == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransaksiImplCopyWith<$Res>
    implements $TransaksiCopyWith<$Res> {
  factory _$$TransaksiImplCopyWith(
          _$TransaksiImpl value, $Res Function(_$TransaksiImpl) then) =
      __$$TransaksiImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, String itemId, int type, int quantity, DateTime date});
}

/// @nodoc
class __$$TransaksiImplCopyWithImpl<$Res>
    extends _$TransaksiCopyWithImpl<$Res, _$TransaksiImpl>
    implements _$$TransaksiImplCopyWith<$Res> {
  __$$TransaksiImplCopyWithImpl(
      _$TransaksiImpl _value, $Res Function(_$TransaksiImpl) _then)
      : super(_value, _then);

  /// Create a copy of Transaksi
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? itemId = null,
    Object? type = null,
    Object? quantity = null,
    Object? date = null,
  }) {
    return _then(_$TransaksiImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      itemId: null == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TransaksiImpl implements _Transaksi {
  const _$TransaksiImpl(
      {this.id,
      required this.itemId,
      required this.type,
      required this.quantity,
      required this.date});

  factory _$TransaksiImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransaksiImplFromJson(json);

  @override
  final String? id;
  @override
  final String itemId;
  @override
  final int type;
  @override
  final int quantity;
  @override
  final DateTime date;

  @override
  String toString() {
    return 'Transaksi(id: $id, itemId: $itemId, type: $type, quantity: $quantity, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransaksiImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.itemId, itemId) || other.itemId == itemId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, itemId, type, quantity, date);

  /// Create a copy of Transaksi
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransaksiImplCopyWith<_$TransaksiImpl> get copyWith =>
      __$$TransaksiImplCopyWithImpl<_$TransaksiImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransaksiImplToJson(
      this,
    );
  }
}

abstract class _Transaksi implements Transaksi {
  const factory _Transaksi(
      {final String? id,
      required final String itemId,
      required final int type,
      required final int quantity,
      required final DateTime date}) = _$TransaksiImpl;

  factory _Transaksi.fromJson(Map<String, dynamic> json) =
      _$TransaksiImpl.fromJson;

  @override
  String? get id;
  @override
  String get itemId;
  @override
  int get type;
  @override
  int get quantity;
  @override
  DateTime get date;

  /// Create a copy of Transaksi
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransaksiImplCopyWith<_$TransaksiImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
