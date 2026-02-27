// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'campaign_selection_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CampaignSelectionState {
  List<Campaign> get selectedCampaigns => throw _privateConstructorUsedError;
  int? get coinPercentage => throw _privateConstructorUsedError;
  double get coinAmount => throw _privateConstructorUsedError;
  Campaign? get pendingConflictCampaign => throw _privateConstructorUsedError;
  ConflictType? get conflictType => throw _privateConstructorUsedError;

  /// Create a copy of CampaignSelectionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CampaignSelectionStateCopyWith<CampaignSelectionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CampaignSelectionStateCopyWith<$Res> {
  factory $CampaignSelectionStateCopyWith(CampaignSelectionState value,
          $Res Function(CampaignSelectionState) then) =
      _$CampaignSelectionStateCopyWithImpl<$Res, CampaignSelectionState>;
  @useResult
  $Res call(
      {List<Campaign> selectedCampaigns,
      int? coinPercentage,
      double coinAmount,
      Campaign? pendingConflictCampaign,
      ConflictType? conflictType});

  $CampaignCopyWith<$Res>? get pendingConflictCampaign;
}

/// @nodoc
class _$CampaignSelectionStateCopyWithImpl<$Res,
        $Val extends CampaignSelectionState>
    implements $CampaignSelectionStateCopyWith<$Res> {
  _$CampaignSelectionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CampaignSelectionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedCampaigns = null,
    Object? coinPercentage = freezed,
    Object? coinAmount = null,
    Object? pendingConflictCampaign = freezed,
    Object? conflictType = freezed,
  }) {
    return _then(_value.copyWith(
      selectedCampaigns: null == selectedCampaigns
          ? _value.selectedCampaigns
          : selectedCampaigns // ignore: cast_nullable_to_non_nullable
              as List<Campaign>,
      coinPercentage: freezed == coinPercentage
          ? _value.coinPercentage
          : coinPercentage // ignore: cast_nullable_to_non_nullable
              as int?,
      coinAmount: null == coinAmount
          ? _value.coinAmount
          : coinAmount // ignore: cast_nullable_to_non_nullable
              as double,
      pendingConflictCampaign: freezed == pendingConflictCampaign
          ? _value.pendingConflictCampaign
          : pendingConflictCampaign // ignore: cast_nullable_to_non_nullable
              as Campaign?,
      conflictType: freezed == conflictType
          ? _value.conflictType
          : conflictType // ignore: cast_nullable_to_non_nullable
              as ConflictType?,
    ) as $Val);
  }

  /// Create a copy of CampaignSelectionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CampaignCopyWith<$Res>? get pendingConflictCampaign {
    if (_value.pendingConflictCampaign == null) {
      return null;
    }

    return $CampaignCopyWith<$Res>(_value.pendingConflictCampaign!, (value) {
      return _then(_value.copyWith(pendingConflictCampaign: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CampaignSelectionStateImplCopyWith<$Res>
    implements $CampaignSelectionStateCopyWith<$Res> {
  factory _$$CampaignSelectionStateImplCopyWith(
          _$CampaignSelectionStateImpl value,
          $Res Function(_$CampaignSelectionStateImpl) then) =
      __$$CampaignSelectionStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Campaign> selectedCampaigns,
      int? coinPercentage,
      double coinAmount,
      Campaign? pendingConflictCampaign,
      ConflictType? conflictType});

  @override
  $CampaignCopyWith<$Res>? get pendingConflictCampaign;
}

/// @nodoc
class __$$CampaignSelectionStateImplCopyWithImpl<$Res>
    extends _$CampaignSelectionStateCopyWithImpl<$Res,
        _$CampaignSelectionStateImpl>
    implements _$$CampaignSelectionStateImplCopyWith<$Res> {
  __$$CampaignSelectionStateImplCopyWithImpl(
      _$CampaignSelectionStateImpl _value,
      $Res Function(_$CampaignSelectionStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CampaignSelectionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedCampaigns = null,
    Object? coinPercentage = freezed,
    Object? coinAmount = null,
    Object? pendingConflictCampaign = freezed,
    Object? conflictType = freezed,
  }) {
    return _then(_$CampaignSelectionStateImpl(
      selectedCampaigns: null == selectedCampaigns
          ? _value._selectedCampaigns
          : selectedCampaigns // ignore: cast_nullable_to_non_nullable
              as List<Campaign>,
      coinPercentage: freezed == coinPercentage
          ? _value.coinPercentage
          : coinPercentage // ignore: cast_nullable_to_non_nullable
              as int?,
      coinAmount: null == coinAmount
          ? _value.coinAmount
          : coinAmount // ignore: cast_nullable_to_non_nullable
              as double,
      pendingConflictCampaign: freezed == pendingConflictCampaign
          ? _value.pendingConflictCampaign
          : pendingConflictCampaign // ignore: cast_nullable_to_non_nullable
              as Campaign?,
      conflictType: freezed == conflictType
          ? _value.conflictType
          : conflictType // ignore: cast_nullable_to_non_nullable
              as ConflictType?,
    ));
  }
}

/// @nodoc

class _$CampaignSelectionStateImpl implements _CampaignSelectionState {
  const _$CampaignSelectionStateImpl(
      {final List<Campaign> selectedCampaigns = const [],
      this.coinPercentage = null,
      this.coinAmount = 0,
      this.pendingConflictCampaign,
      this.conflictType})
      : _selectedCampaigns = selectedCampaigns;

  final List<Campaign> _selectedCampaigns;
  @override
  @JsonKey()
  List<Campaign> get selectedCampaigns {
    if (_selectedCampaigns is EqualUnmodifiableListView)
      return _selectedCampaigns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedCampaigns);
  }

  @override
  @JsonKey()
  final int? coinPercentage;
  @override
  @JsonKey()
  final double coinAmount;
  @override
  final Campaign? pendingConflictCampaign;
  @override
  final ConflictType? conflictType;

  @override
  String toString() {
    return 'CampaignSelectionState(selectedCampaigns: $selectedCampaigns, coinPercentage: $coinPercentage, coinAmount: $coinAmount, pendingConflictCampaign: $pendingConflictCampaign, conflictType: $conflictType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CampaignSelectionStateImpl &&
            const DeepCollectionEquality()
                .equals(other._selectedCampaigns, _selectedCampaigns) &&
            (identical(other.coinPercentage, coinPercentage) ||
                other.coinPercentage == coinPercentage) &&
            (identical(other.coinAmount, coinAmount) ||
                other.coinAmount == coinAmount) &&
            (identical(
                    other.pendingConflictCampaign, pendingConflictCampaign) ||
                other.pendingConflictCampaign == pendingConflictCampaign) &&
            (identical(other.conflictType, conflictType) ||
                other.conflictType == conflictType));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_selectedCampaigns),
      coinPercentage,
      coinAmount,
      pendingConflictCampaign,
      conflictType);

  /// Create a copy of CampaignSelectionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CampaignSelectionStateImplCopyWith<_$CampaignSelectionStateImpl>
      get copyWith => __$$CampaignSelectionStateImplCopyWithImpl<
          _$CampaignSelectionStateImpl>(this, _$identity);
}

abstract class _CampaignSelectionState implements CampaignSelectionState {
  const factory _CampaignSelectionState(
      {final List<Campaign> selectedCampaigns,
      final int? coinPercentage,
      final double coinAmount,
      final Campaign? pendingConflictCampaign,
      final ConflictType? conflictType}) = _$CampaignSelectionStateImpl;

  @override
  List<Campaign> get selectedCampaigns;
  @override
  int? get coinPercentage;
  @override
  double get coinAmount;
  @override
  Campaign? get pendingConflictCampaign;
  @override
  ConflictType? get conflictType;

  /// Create a copy of CampaignSelectionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CampaignSelectionStateImplCopyWith<_$CampaignSelectionStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
