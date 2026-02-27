// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WalletSummary _$WalletSummaryFromJson(Map<String, dynamic> json) {
  return _WalletSummary.fromJson(json);
}

/// @nodoc
mixin _$WalletSummary {
  double get totalBalance => throw _privateConstructorUsedError;
  double get availableBalance => throw _privateConstructorUsedError;
  String? get tierName => throw _privateConstructorUsedError;
  String? get cardColor => throw _privateConstructorUsedError;
  String? get brandName => throw _privateConstructorUsedError;

  /// Brand logo URL from API
  String? get brandLogo => throw _privateConstructorUsedError;

  /// Wallet logo URL displayed on the card
  String? get walletLogo => throw _privateConstructorUsedError;

  /// Card background image URL
  String? get walletCover => throw _privateConstructorUsedError;
  int get onlineCampaignCount => throw _privateConstructorUsedError;
  int get storeCampaignCount => throw _privateConstructorUsedError;

  /// Serializes this WalletSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WalletSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WalletSummaryCopyWith<WalletSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletSummaryCopyWith<$Res> {
  factory $WalletSummaryCopyWith(
          WalletSummary value, $Res Function(WalletSummary) then) =
      _$WalletSummaryCopyWithImpl<$Res, WalletSummary>;
  @useResult
  $Res call(
      {double totalBalance,
      double availableBalance,
      String? tierName,
      String? cardColor,
      String? brandName,
      String? brandLogo,
      String? walletLogo,
      String? walletCover,
      int onlineCampaignCount,
      int storeCampaignCount});
}

/// @nodoc
class _$WalletSummaryCopyWithImpl<$Res, $Val extends WalletSummary>
    implements $WalletSummaryCopyWith<$Res> {
  _$WalletSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WalletSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalBalance = null,
    Object? availableBalance = null,
    Object? tierName = freezed,
    Object? cardColor = freezed,
    Object? brandName = freezed,
    Object? brandLogo = freezed,
    Object? walletLogo = freezed,
    Object? walletCover = freezed,
    Object? onlineCampaignCount = null,
    Object? storeCampaignCount = null,
  }) {
    return _then(_value.copyWith(
      totalBalance: null == totalBalance
          ? _value.totalBalance
          : totalBalance // ignore: cast_nullable_to_non_nullable
              as double,
      availableBalance: null == availableBalance
          ? _value.availableBalance
          : availableBalance // ignore: cast_nullable_to_non_nullable
              as double,
      tierName: freezed == tierName
          ? _value.tierName
          : tierName // ignore: cast_nullable_to_non_nullable
              as String?,
      cardColor: freezed == cardColor
          ? _value.cardColor
          : cardColor // ignore: cast_nullable_to_non_nullable
              as String?,
      brandName: freezed == brandName
          ? _value.brandName
          : brandName // ignore: cast_nullable_to_non_nullable
              as String?,
      brandLogo: freezed == brandLogo
          ? _value.brandLogo
          : brandLogo // ignore: cast_nullable_to_non_nullable
              as String?,
      walletLogo: freezed == walletLogo
          ? _value.walletLogo
          : walletLogo // ignore: cast_nullable_to_non_nullable
              as String?,
      walletCover: freezed == walletCover
          ? _value.walletCover
          : walletCover // ignore: cast_nullable_to_non_nullable
              as String?,
      onlineCampaignCount: null == onlineCampaignCount
          ? _value.onlineCampaignCount
          : onlineCampaignCount // ignore: cast_nullable_to_non_nullable
              as int,
      storeCampaignCount: null == storeCampaignCount
          ? _value.storeCampaignCount
          : storeCampaignCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WalletSummaryImplCopyWith<$Res>
    implements $WalletSummaryCopyWith<$Res> {
  factory _$$WalletSummaryImplCopyWith(
          _$WalletSummaryImpl value, $Res Function(_$WalletSummaryImpl) then) =
      __$$WalletSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double totalBalance,
      double availableBalance,
      String? tierName,
      String? cardColor,
      String? brandName,
      String? brandLogo,
      String? walletLogo,
      String? walletCover,
      int onlineCampaignCount,
      int storeCampaignCount});
}

/// @nodoc
class __$$WalletSummaryImplCopyWithImpl<$Res>
    extends _$WalletSummaryCopyWithImpl<$Res, _$WalletSummaryImpl>
    implements _$$WalletSummaryImplCopyWith<$Res> {
  __$$WalletSummaryImplCopyWithImpl(
      _$WalletSummaryImpl _value, $Res Function(_$WalletSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalBalance = null,
    Object? availableBalance = null,
    Object? tierName = freezed,
    Object? cardColor = freezed,
    Object? brandName = freezed,
    Object? brandLogo = freezed,
    Object? walletLogo = freezed,
    Object? walletCover = freezed,
    Object? onlineCampaignCount = null,
    Object? storeCampaignCount = null,
  }) {
    return _then(_$WalletSummaryImpl(
      totalBalance: null == totalBalance
          ? _value.totalBalance
          : totalBalance // ignore: cast_nullable_to_non_nullable
              as double,
      availableBalance: null == availableBalance
          ? _value.availableBalance
          : availableBalance // ignore: cast_nullable_to_non_nullable
              as double,
      tierName: freezed == tierName
          ? _value.tierName
          : tierName // ignore: cast_nullable_to_non_nullable
              as String?,
      cardColor: freezed == cardColor
          ? _value.cardColor
          : cardColor // ignore: cast_nullable_to_non_nullable
              as String?,
      brandName: freezed == brandName
          ? _value.brandName
          : brandName // ignore: cast_nullable_to_non_nullable
              as String?,
      brandLogo: freezed == brandLogo
          ? _value.brandLogo
          : brandLogo // ignore: cast_nullable_to_non_nullable
              as String?,
      walletLogo: freezed == walletLogo
          ? _value.walletLogo
          : walletLogo // ignore: cast_nullable_to_non_nullable
              as String?,
      walletCover: freezed == walletCover
          ? _value.walletCover
          : walletCover // ignore: cast_nullable_to_non_nullable
              as String?,
      onlineCampaignCount: null == onlineCampaignCount
          ? _value.onlineCampaignCount
          : onlineCampaignCount // ignore: cast_nullable_to_non_nullable
              as int,
      storeCampaignCount: null == storeCampaignCount
          ? _value.storeCampaignCount
          : storeCampaignCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WalletSummaryImpl implements _WalletSummary {
  const _$WalletSummaryImpl(
      {required this.totalBalance,
      required this.availableBalance,
      this.tierName,
      this.cardColor,
      this.brandName,
      this.brandLogo,
      this.walletLogo,
      this.walletCover,
      this.onlineCampaignCount = 0,
      this.storeCampaignCount = 0});

  factory _$WalletSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$WalletSummaryImplFromJson(json);

  @override
  final double totalBalance;
  @override
  final double availableBalance;
  @override
  final String? tierName;
  @override
  final String? cardColor;
  @override
  final String? brandName;

  /// Brand logo URL from API
  @override
  final String? brandLogo;

  /// Wallet logo URL displayed on the card
  @override
  final String? walletLogo;

  /// Card background image URL
  @override
  final String? walletCover;
  @override
  @JsonKey()
  final int onlineCampaignCount;
  @override
  @JsonKey()
  final int storeCampaignCount;

  @override
  String toString() {
    return 'WalletSummary(totalBalance: $totalBalance, availableBalance: $availableBalance, tierName: $tierName, cardColor: $cardColor, brandName: $brandName, brandLogo: $brandLogo, walletLogo: $walletLogo, walletCover: $walletCover, onlineCampaignCount: $onlineCampaignCount, storeCampaignCount: $storeCampaignCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletSummaryImpl &&
            (identical(other.totalBalance, totalBalance) ||
                other.totalBalance == totalBalance) &&
            (identical(other.availableBalance, availableBalance) ||
                other.availableBalance == availableBalance) &&
            (identical(other.tierName, tierName) ||
                other.tierName == tierName) &&
            (identical(other.cardColor, cardColor) ||
                other.cardColor == cardColor) &&
            (identical(other.brandName, brandName) ||
                other.brandName == brandName) &&
            (identical(other.brandLogo, brandLogo) ||
                other.brandLogo == brandLogo) &&
            (identical(other.walletLogo, walletLogo) ||
                other.walletLogo == walletLogo) &&
            (identical(other.walletCover, walletCover) ||
                other.walletCover == walletCover) &&
            (identical(other.onlineCampaignCount, onlineCampaignCount) ||
                other.onlineCampaignCount == onlineCampaignCount) &&
            (identical(other.storeCampaignCount, storeCampaignCount) ||
                other.storeCampaignCount == storeCampaignCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalBalance,
      availableBalance,
      tierName,
      cardColor,
      brandName,
      brandLogo,
      walletLogo,
      walletCover,
      onlineCampaignCount,
      storeCampaignCount);

  /// Create a copy of WalletSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletSummaryImplCopyWith<_$WalletSummaryImpl> get copyWith =>
      __$$WalletSummaryImplCopyWithImpl<_$WalletSummaryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WalletSummaryImplToJson(
      this,
    );
  }
}

abstract class _WalletSummary implements WalletSummary {
  const factory _WalletSummary(
      {required final double totalBalance,
      required final double availableBalance,
      final String? tierName,
      final String? cardColor,
      final String? brandName,
      final String? brandLogo,
      final String? walletLogo,
      final String? walletCover,
      final int onlineCampaignCount,
      final int storeCampaignCount}) = _$WalletSummaryImpl;

  factory _WalletSummary.fromJson(Map<String, dynamic> json) =
      _$WalletSummaryImpl.fromJson;

  @override
  double get totalBalance;
  @override
  double get availableBalance;
  @override
  String? get tierName;
  @override
  String? get cardColor;
  @override
  String? get brandName;

  /// Brand logo URL from API
  @override
  String? get brandLogo;

  /// Wallet logo URL displayed on the card
  @override
  String? get walletLogo;

  /// Card background image URL
  @override
  String? get walletCover;
  @override
  int get onlineCampaignCount;
  @override
  int get storeCampaignCount;

  /// Create a copy of WalletSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalletSummaryImplCopyWith<_$WalletSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
