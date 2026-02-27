// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'generate_code_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GenerateCodeRequest _$GenerateCodeRequestFromJson(Map<String, dynamic> json) {
  return _GenerateCodeRequest.fromJson(json);
}

/// @nodoc
mixin _$GenerateCodeRequest {
  String get brandId => throw _privateConstructorUsedError;
  List<String> get campaignIds => throw _privateConstructorUsedError;
  double? get coinAmount => throw _privateConstructorUsedError;

  /// Serializes this GenerateCodeRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GenerateCodeRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GenerateCodeRequestCopyWith<GenerateCodeRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GenerateCodeRequestCopyWith<$Res> {
  factory $GenerateCodeRequestCopyWith(
          GenerateCodeRequest value, $Res Function(GenerateCodeRequest) then) =
      _$GenerateCodeRequestCopyWithImpl<$Res, GenerateCodeRequest>;
  @useResult
  $Res call({String brandId, List<String> campaignIds, double? coinAmount});
}

/// @nodoc
class _$GenerateCodeRequestCopyWithImpl<$Res, $Val extends GenerateCodeRequest>
    implements $GenerateCodeRequestCopyWith<$Res> {
  _$GenerateCodeRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GenerateCodeRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? brandId = null,
    Object? campaignIds = null,
    Object? coinAmount = freezed,
  }) {
    return _then(_value.copyWith(
      brandId: null == brandId
          ? _value.brandId
          : brandId // ignore: cast_nullable_to_non_nullable
              as String,
      campaignIds: null == campaignIds
          ? _value.campaignIds
          : campaignIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      coinAmount: freezed == coinAmount
          ? _value.coinAmount
          : coinAmount // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GenerateCodeRequestImplCopyWith<$Res>
    implements $GenerateCodeRequestCopyWith<$Res> {
  factory _$$GenerateCodeRequestImplCopyWith(_$GenerateCodeRequestImpl value,
          $Res Function(_$GenerateCodeRequestImpl) then) =
      __$$GenerateCodeRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String brandId, List<String> campaignIds, double? coinAmount});
}

/// @nodoc
class __$$GenerateCodeRequestImplCopyWithImpl<$Res>
    extends _$GenerateCodeRequestCopyWithImpl<$Res, _$GenerateCodeRequestImpl>
    implements _$$GenerateCodeRequestImplCopyWith<$Res> {
  __$$GenerateCodeRequestImplCopyWithImpl(_$GenerateCodeRequestImpl _value,
      $Res Function(_$GenerateCodeRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of GenerateCodeRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? brandId = null,
    Object? campaignIds = null,
    Object? coinAmount = freezed,
  }) {
    return _then(_$GenerateCodeRequestImpl(
      brandId: null == brandId
          ? _value.brandId
          : brandId // ignore: cast_nullable_to_non_nullable
              as String,
      campaignIds: null == campaignIds
          ? _value._campaignIds
          : campaignIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      coinAmount: freezed == coinAmount
          ? _value.coinAmount
          : coinAmount // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GenerateCodeRequestImpl implements _GenerateCodeRequest {
  const _$GenerateCodeRequestImpl(
      {required this.brandId,
      required final List<String> campaignIds,
      this.coinAmount})
      : _campaignIds = campaignIds;

  factory _$GenerateCodeRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$GenerateCodeRequestImplFromJson(json);

  @override
  final String brandId;
  final List<String> _campaignIds;
  @override
  List<String> get campaignIds {
    if (_campaignIds is EqualUnmodifiableListView) return _campaignIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_campaignIds);
  }

  @override
  final double? coinAmount;

  @override
  String toString() {
    return 'GenerateCodeRequest(brandId: $brandId, campaignIds: $campaignIds, coinAmount: $coinAmount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GenerateCodeRequestImpl &&
            (identical(other.brandId, brandId) || other.brandId == brandId) &&
            const DeepCollectionEquality()
                .equals(other._campaignIds, _campaignIds) &&
            (identical(other.coinAmount, coinAmount) ||
                other.coinAmount == coinAmount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, brandId,
      const DeepCollectionEquality().hash(_campaignIds), coinAmount);

  /// Create a copy of GenerateCodeRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GenerateCodeRequestImplCopyWith<_$GenerateCodeRequestImpl> get copyWith =>
      __$$GenerateCodeRequestImplCopyWithImpl<_$GenerateCodeRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GenerateCodeRequestImplToJson(
      this,
    );
  }
}

abstract class _GenerateCodeRequest implements GenerateCodeRequest {
  const factory _GenerateCodeRequest(
      {required final String brandId,
      required final List<String> campaignIds,
      final double? coinAmount}) = _$GenerateCodeRequestImpl;

  factory _GenerateCodeRequest.fromJson(Map<String, dynamic> json) =
      _$GenerateCodeRequestImpl.fromJson;

  @override
  String get brandId;
  @override
  List<String> get campaignIds;
  @override
  double? get coinAmount;

  /// Create a copy of GenerateCodeRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GenerateCodeRequestImplCopyWith<_$GenerateCodeRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
