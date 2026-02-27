// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pending_transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PendingTransaction _$PendingTransactionFromJson(Map<String, dynamic> json) {
  return _PendingTransaction.fromJson(json);
}

/// @nodoc
mixin _$PendingTransaction {
  String get id => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  DateTime get estimatedDate => throw _privateConstructorUsedError;
  String? get orderId => throw _privateConstructorUsedError;
  List<PendingSubItem>? get subItems => throw _privateConstructorUsedError;

  /// Serializes this PendingTransaction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PendingTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PendingTransactionCopyWith<PendingTransaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PendingTransactionCopyWith<$Res> {
  factory $PendingTransactionCopyWith(
          PendingTransaction value, $Res Function(PendingTransaction) then) =
      _$PendingTransactionCopyWithImpl<$Res, PendingTransaction>;
  @useResult
  $Res call(
      {String id,
      double amount,
      DateTime estimatedDate,
      String? orderId,
      List<PendingSubItem>? subItems});
}

/// @nodoc
class _$PendingTransactionCopyWithImpl<$Res, $Val extends PendingTransaction>
    implements $PendingTransactionCopyWith<$Res> {
  _$PendingTransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PendingTransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = null,
    Object? estimatedDate = null,
    Object? orderId = freezed,
    Object? subItems = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      estimatedDate: null == estimatedDate
          ? _value.estimatedDate
          : estimatedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      orderId: freezed == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String?,
      subItems: freezed == subItems
          ? _value.subItems
          : subItems // ignore: cast_nullable_to_non_nullable
              as List<PendingSubItem>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PendingTransactionImplCopyWith<$Res>
    implements $PendingTransactionCopyWith<$Res> {
  factory _$$PendingTransactionImplCopyWith(_$PendingTransactionImpl value,
          $Res Function(_$PendingTransactionImpl) then) =
      __$$PendingTransactionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      double amount,
      DateTime estimatedDate,
      String? orderId,
      List<PendingSubItem>? subItems});
}

/// @nodoc
class __$$PendingTransactionImplCopyWithImpl<$Res>
    extends _$PendingTransactionCopyWithImpl<$Res, _$PendingTransactionImpl>
    implements _$$PendingTransactionImplCopyWith<$Res> {
  __$$PendingTransactionImplCopyWithImpl(_$PendingTransactionImpl _value,
      $Res Function(_$PendingTransactionImpl) _then)
      : super(_value, _then);

  /// Create a copy of PendingTransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = null,
    Object? estimatedDate = null,
    Object? orderId = freezed,
    Object? subItems = freezed,
  }) {
    return _then(_$PendingTransactionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      estimatedDate: null == estimatedDate
          ? _value.estimatedDate
          : estimatedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      orderId: freezed == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String?,
      subItems: freezed == subItems
          ? _value._subItems
          : subItems // ignore: cast_nullable_to_non_nullable
              as List<PendingSubItem>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PendingTransactionImpl implements _PendingTransaction {
  const _$PendingTransactionImpl(
      {required this.id,
      required this.amount,
      required this.estimatedDate,
      this.orderId,
      final List<PendingSubItem>? subItems})
      : _subItems = subItems;

  factory _$PendingTransactionImpl.fromJson(Map<String, dynamic> json) =>
      _$$PendingTransactionImplFromJson(json);

  @override
  final String id;
  @override
  final double amount;
  @override
  final DateTime estimatedDate;
  @override
  final String? orderId;
  final List<PendingSubItem>? _subItems;
  @override
  List<PendingSubItem>? get subItems {
    final value = _subItems;
    if (value == null) return null;
    if (_subItems is EqualUnmodifiableListView) return _subItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'PendingTransaction(id: $id, amount: $amount, estimatedDate: $estimatedDate, orderId: $orderId, subItems: $subItems)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PendingTransactionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.estimatedDate, estimatedDate) ||
                other.estimatedDate == estimatedDate) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            const DeepCollectionEquality().equals(other._subItems, _subItems));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, amount, estimatedDate,
      orderId, const DeepCollectionEquality().hash(_subItems));

  /// Create a copy of PendingTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PendingTransactionImplCopyWith<_$PendingTransactionImpl> get copyWith =>
      __$$PendingTransactionImplCopyWithImpl<_$PendingTransactionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PendingTransactionImplToJson(
      this,
    );
  }
}

abstract class _PendingTransaction implements PendingTransaction {
  const factory _PendingTransaction(
      {required final String id,
      required final double amount,
      required final DateTime estimatedDate,
      final String? orderId,
      final List<PendingSubItem>? subItems}) = _$PendingTransactionImpl;

  factory _PendingTransaction.fromJson(Map<String, dynamic> json) =
      _$PendingTransactionImpl.fromJson;

  @override
  String get id;
  @override
  double get amount;
  @override
  DateTime get estimatedDate;
  @override
  String? get orderId;
  @override
  List<PendingSubItem>? get subItems;

  /// Create a copy of PendingTransaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PendingTransactionImplCopyWith<_$PendingTransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PendingSubItem _$PendingSubItemFromJson(Map<String, dynamic> json) {
  return _PendingSubItem.fromJson(json);
}

/// @nodoc
mixin _$PendingSubItem {
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;

  /// Serializes this PendingSubItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PendingSubItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PendingSubItemCopyWith<PendingSubItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PendingSubItemCopyWith<$Res> {
  factory $PendingSubItemCopyWith(
          PendingSubItem value, $Res Function(PendingSubItem) then) =
      _$PendingSubItemCopyWithImpl<$Res, PendingSubItem>;
  @useResult
  $Res call({String name, String? description, double amount});
}

/// @nodoc
class _$PendingSubItemCopyWithImpl<$Res, $Val extends PendingSubItem>
    implements $PendingSubItemCopyWith<$Res> {
  _$PendingSubItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PendingSubItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = freezed,
    Object? amount = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PendingSubItemImplCopyWith<$Res>
    implements $PendingSubItemCopyWith<$Res> {
  factory _$$PendingSubItemImplCopyWith(_$PendingSubItemImpl value,
          $Res Function(_$PendingSubItemImpl) then) =
      __$$PendingSubItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String? description, double amount});
}

/// @nodoc
class __$$PendingSubItemImplCopyWithImpl<$Res>
    extends _$PendingSubItemCopyWithImpl<$Res, _$PendingSubItemImpl>
    implements _$$PendingSubItemImplCopyWith<$Res> {
  __$$PendingSubItemImplCopyWithImpl(
      _$PendingSubItemImpl _value, $Res Function(_$PendingSubItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of PendingSubItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = freezed,
    Object? amount = null,
  }) {
    return _then(_$PendingSubItemImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PendingSubItemImpl implements _PendingSubItem {
  const _$PendingSubItemImpl(
      {required this.name, this.description, required this.amount});

  factory _$PendingSubItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$PendingSubItemImplFromJson(json);

  @override
  final String name;
  @override
  final String? description;
  @override
  final double amount;

  @override
  String toString() {
    return 'PendingSubItem(name: $name, description: $description, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PendingSubItemImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, description, amount);

  /// Create a copy of PendingSubItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PendingSubItemImplCopyWith<_$PendingSubItemImpl> get copyWith =>
      __$$PendingSubItemImplCopyWithImpl<_$PendingSubItemImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PendingSubItemImplToJson(
      this,
    );
  }
}

abstract class _PendingSubItem implements PendingSubItem {
  const factory _PendingSubItem(
      {required final String name,
      final String? description,
      required final double amount}) = _$PendingSubItemImpl;

  factory _PendingSubItem.fromJson(Map<String, dynamic> json) =
      _$PendingSubItemImpl.fromJson;

  @override
  String get name;
  @override
  String? get description;
  @override
  double get amount;

  /// Create a copy of PendingSubItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PendingSubItemImplCopyWith<_$PendingSubItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
