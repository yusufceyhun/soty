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

WalletTransaction _$WalletTransactionFromJson(Map<String, dynamic> json) {
  return _WalletTransaction.fromJson(json);
}

/// @nodoc
mixin _$WalletTransaction {
  String get id => throw _privateConstructorUsedError;

  /// Direction: "Kazanç" (earning) or "Harcama" (spending)
  String get type => throw _privateConstructorUsedError;

  /// Sub-type: "Transfer", "Görev", "Alışveriş", "Kampanya", vb.
  String? get transactionTypeName => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  double get balance => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  String? get orderId => throw _privateConstructorUsedError;
  String? get refundId => throw _privateConstructorUsedError;
  String? get taskName => throw _privateConstructorUsedError;
  String? get taskCategory => throw _privateConstructorUsedError;
  String? get transferTo => throw _privateConstructorUsedError;
  String? get brandName => throw _privateConstructorUsedError;
  String? get campaignName => throw _privateConstructorUsedError;
  String? get campaignRule => throw _privateConstructorUsedError;

  /// Serializes this WalletTransaction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WalletTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WalletTransactionCopyWith<WalletTransaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletTransactionCopyWith<$Res> {
  factory $WalletTransactionCopyWith(
          WalletTransaction value, $Res Function(WalletTransaction) then) =
      _$WalletTransactionCopyWithImpl<$Res, WalletTransaction>;
  @useResult
  $Res call(
      {String id,
      String type,
      String? transactionTypeName,
      double amount,
      double balance,
      DateTime date,
      String? orderId,
      String? refundId,
      String? taskName,
      String? taskCategory,
      String? transferTo,
      String? brandName,
      String? campaignName,
      String? campaignRule});
}

/// @nodoc
class _$WalletTransactionCopyWithImpl<$Res, $Val extends WalletTransaction>
    implements $WalletTransactionCopyWith<$Res> {
  _$WalletTransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WalletTransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? transactionTypeName = freezed,
    Object? amount = null,
    Object? balance = null,
    Object? date = null,
    Object? orderId = freezed,
    Object? refundId = freezed,
    Object? taskName = freezed,
    Object? taskCategory = freezed,
    Object? transferTo = freezed,
    Object? brandName = freezed,
    Object? campaignName = freezed,
    Object? campaignRule = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      transactionTypeName: freezed == transactionTypeName
          ? _value.transactionTypeName
          : transactionTypeName // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      orderId: freezed == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String?,
      refundId: freezed == refundId
          ? _value.refundId
          : refundId // ignore: cast_nullable_to_non_nullable
              as String?,
      taskName: freezed == taskName
          ? _value.taskName
          : taskName // ignore: cast_nullable_to_non_nullable
              as String?,
      taskCategory: freezed == taskCategory
          ? _value.taskCategory
          : taskCategory // ignore: cast_nullable_to_non_nullable
              as String?,
      transferTo: freezed == transferTo
          ? _value.transferTo
          : transferTo // ignore: cast_nullable_to_non_nullable
              as String?,
      brandName: freezed == brandName
          ? _value.brandName
          : brandName // ignore: cast_nullable_to_non_nullable
              as String?,
      campaignName: freezed == campaignName
          ? _value.campaignName
          : campaignName // ignore: cast_nullable_to_non_nullable
              as String?,
      campaignRule: freezed == campaignRule
          ? _value.campaignRule
          : campaignRule // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WalletTransactionImplCopyWith<$Res>
    implements $WalletTransactionCopyWith<$Res> {
  factory _$$WalletTransactionImplCopyWith(_$WalletTransactionImpl value,
          $Res Function(_$WalletTransactionImpl) then) =
      __$$WalletTransactionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String type,
      String? transactionTypeName,
      double amount,
      double balance,
      DateTime date,
      String? orderId,
      String? refundId,
      String? taskName,
      String? taskCategory,
      String? transferTo,
      String? brandName,
      String? campaignName,
      String? campaignRule});
}

/// @nodoc
class __$$WalletTransactionImplCopyWithImpl<$Res>
    extends _$WalletTransactionCopyWithImpl<$Res, _$WalletTransactionImpl>
    implements _$$WalletTransactionImplCopyWith<$Res> {
  __$$WalletTransactionImplCopyWithImpl(_$WalletTransactionImpl _value,
      $Res Function(_$WalletTransactionImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletTransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? transactionTypeName = freezed,
    Object? amount = null,
    Object? balance = null,
    Object? date = null,
    Object? orderId = freezed,
    Object? refundId = freezed,
    Object? taskName = freezed,
    Object? taskCategory = freezed,
    Object? transferTo = freezed,
    Object? brandName = freezed,
    Object? campaignName = freezed,
    Object? campaignRule = freezed,
  }) {
    return _then(_$WalletTransactionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      transactionTypeName: freezed == transactionTypeName
          ? _value.transactionTypeName
          : transactionTypeName // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      orderId: freezed == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String?,
      refundId: freezed == refundId
          ? _value.refundId
          : refundId // ignore: cast_nullable_to_non_nullable
              as String?,
      taskName: freezed == taskName
          ? _value.taskName
          : taskName // ignore: cast_nullable_to_non_nullable
              as String?,
      taskCategory: freezed == taskCategory
          ? _value.taskCategory
          : taskCategory // ignore: cast_nullable_to_non_nullable
              as String?,
      transferTo: freezed == transferTo
          ? _value.transferTo
          : transferTo // ignore: cast_nullable_to_non_nullable
              as String?,
      brandName: freezed == brandName
          ? _value.brandName
          : brandName // ignore: cast_nullable_to_non_nullable
              as String?,
      campaignName: freezed == campaignName
          ? _value.campaignName
          : campaignName // ignore: cast_nullable_to_non_nullable
              as String?,
      campaignRule: freezed == campaignRule
          ? _value.campaignRule
          : campaignRule // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WalletTransactionImpl implements _WalletTransaction {
  const _$WalletTransactionImpl(
      {required this.id,
      required this.type,
      this.transactionTypeName,
      required this.amount,
      required this.balance,
      required this.date,
      this.orderId,
      this.refundId,
      this.taskName,
      this.taskCategory,
      this.transferTo,
      this.brandName,
      this.campaignName,
      this.campaignRule});

  factory _$WalletTransactionImpl.fromJson(Map<String, dynamic> json) =>
      _$$WalletTransactionImplFromJson(json);

  @override
  final String id;

  /// Direction: "Kazanç" (earning) or "Harcama" (spending)
  @override
  final String type;

  /// Sub-type: "Transfer", "Görev", "Alışveriş", "Kampanya", vb.
  @override
  final String? transactionTypeName;
  @override
  final double amount;
  @override
  final double balance;
  @override
  final DateTime date;
  @override
  final String? orderId;
  @override
  final String? refundId;
  @override
  final String? taskName;
  @override
  final String? taskCategory;
  @override
  final String? transferTo;
  @override
  final String? brandName;
  @override
  final String? campaignName;
  @override
  final String? campaignRule;

  @override
  String toString() {
    return 'WalletTransaction(id: $id, type: $type, transactionTypeName: $transactionTypeName, amount: $amount, balance: $balance, date: $date, orderId: $orderId, refundId: $refundId, taskName: $taskName, taskCategory: $taskCategory, transferTo: $transferTo, brandName: $brandName, campaignName: $campaignName, campaignRule: $campaignRule)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletTransactionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.transactionTypeName, transactionTypeName) ||
                other.transactionTypeName == transactionTypeName) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.refundId, refundId) ||
                other.refundId == refundId) &&
            (identical(other.taskName, taskName) ||
                other.taskName == taskName) &&
            (identical(other.taskCategory, taskCategory) ||
                other.taskCategory == taskCategory) &&
            (identical(other.transferTo, transferTo) ||
                other.transferTo == transferTo) &&
            (identical(other.brandName, brandName) ||
                other.brandName == brandName) &&
            (identical(other.campaignName, campaignName) ||
                other.campaignName == campaignName) &&
            (identical(other.campaignRule, campaignRule) ||
                other.campaignRule == campaignRule));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      type,
      transactionTypeName,
      amount,
      balance,
      date,
      orderId,
      refundId,
      taskName,
      taskCategory,
      transferTo,
      brandName,
      campaignName,
      campaignRule);

  /// Create a copy of WalletTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletTransactionImplCopyWith<_$WalletTransactionImpl> get copyWith =>
      __$$WalletTransactionImplCopyWithImpl<_$WalletTransactionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WalletTransactionImplToJson(
      this,
    );
  }
}

abstract class _WalletTransaction implements WalletTransaction {
  const factory _WalletTransaction(
      {required final String id,
      required final String type,
      final String? transactionTypeName,
      required final double amount,
      required final double balance,
      required final DateTime date,
      final String? orderId,
      final String? refundId,
      final String? taskName,
      final String? taskCategory,
      final String? transferTo,
      final String? brandName,
      final String? campaignName,
      final String? campaignRule}) = _$WalletTransactionImpl;

  factory _WalletTransaction.fromJson(Map<String, dynamic> json) =
      _$WalletTransactionImpl.fromJson;

  @override
  String get id;

  /// Direction: "Kazanç" (earning) or "Harcama" (spending)
  @override
  String get type;

  /// Sub-type: "Transfer", "Görev", "Alışveriş", "Kampanya", vb.
  @override
  String? get transactionTypeName;
  @override
  double get amount;
  @override
  double get balance;
  @override
  DateTime get date;
  @override
  String? get orderId;
  @override
  String? get refundId;
  @override
  String? get taskName;
  @override
  String? get taskCategory;
  @override
  String? get transferTo;
  @override
  String? get brandName;
  @override
  String? get campaignName;
  @override
  String? get campaignRule;

  /// Create a copy of WalletTransaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalletTransactionImplCopyWith<_$WalletTransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
