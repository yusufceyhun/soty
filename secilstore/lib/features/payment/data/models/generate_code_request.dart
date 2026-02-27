import 'package:freezed_annotation/freezed_annotation.dart';

part 'generate_code_request.freezed.dart';
part 'generate_code_request.g.dart';

@freezed
class GenerateCodeRequest with _$GenerateCodeRequest {
  const factory GenerateCodeRequest({
    required String brandId,
    required List<String> campaignIds,
    double? coinAmount,
  }) = _GenerateCodeRequest;

  factory GenerateCodeRequest.fromJson(Map<String, dynamic> json) =>
      _$GenerateCodeRequestFromJson(json);
}
